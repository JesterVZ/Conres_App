import 'package:accordion/accordion.dart';
import 'package:conres_app/Services/main-claim-send-service.dart';
import 'package:conres_app/Services/update-claim-service.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/claims/new-claim/new-claim-documant.dart';
import 'package:conres_app/claims/new-claim/new-claim-step-1.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/elements/not-found.dart';
import 'package:conres_app/model/claim.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DI/dependency-provider.dart';
import '../Services/base-claim-send-service.dart';
import '../consts.dart';
import '../contracts/new-ls/new-ls.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/claims/claim-element.dart';
import '../elements/header/header.dart';

class Claims extends StatefulWidget {
  Claims({Key? key, required this.mainListener}) : super(key: key);
  Function? mainListener; //ссылка на основной listener для сокета
  @override
  State<StatefulWidget> createState() => _Claims();
}

class _Claims extends State<Claims> {
  ProfileBloc? profileBloc;
  String? userId;
  List<ClaimElement> claims = [];
  Map<String, dynamic> claimsMap = {};
  ScrollController controller = ScrollController();
  UpdateClaimService? updateClaimService;
  BaseClaimSendService? baseClaimSendService;
  MainClaimSendService? mainClaimSendService;

  bool isLoaded = false;
  bool? isLoading;

  @override
  void initState() {
    controller.addListener(pagination);
    super.initState();
  }

  void refrashDelegate() {
    isLoaded = false;
    claims.clear();
    profileBloc!.getClaims();
  }

  Future<void> _refrash() async {
    isLoaded = false;
    claims.clear();
    profileBloc!.getClaims();
  }

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return MainForm(
              header: HeaderNotification(text: "Заявления"),
              body: Stack(
              children: [
                ListView.builder(
                  itemCount: claimsMap.length,
                  itemBuilder: (context, int index) {
                    return ClaimElement(
                        currentClaim: claimsMap.values.elementAt(index),
                        downloadFunction: downloadClaim,
                        mainListener: widget.mainListener);
                  }),
                Visibility(
                  visible: claimsMap.isEmpty && isLoading == false ? true : false,
                  child: NotFound(
                    title: "Заявления",
                    text: "По данному лицевому счету не найдены заявления"),
                ),
                Visibility(
                          child: Center(
                              child: Container(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(color: colorMain),
                          )),
                          visible: (isLoading == true) ? true : false)
              ],
            ),
              footer: DefaultButton(
                isGetPadding: true,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewClaimDicument()));
                },
                text: "Новое заявление",
              ),
              onRefrash: _refrash);
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      isLoading = true;
      return;
    } else {
      isLoading = false;
    }
    if (state.fullInfo != null) {
      userId = state.fullInfo!['user_id'];
      if (state.claims != null && state.claims!.isNotEmpty && isLoaded == false) {
        if (claims.isEmpty) {
          claimsMap = {for (var e in state.claims!) e.claim_id!: e};
          isLoaded = true;
        }
      }
    }
  }

  void pagination() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      setState(() {
        print("pagination");
      });
    }
  }

  void downloadClaim(Claim claim) {
    String url = claimLoadLink + claim.document_href!;
    String filename = getFileName(claim.document_href!);
    profileBloc!.downloadFile(url, filename);
  }

  String getFileName(String value) {
    List<String> result = value.split("/");
    return result[1];
  }

  void updateStatus(String claim_id, String status, String status_pay) {
    Claim newClaim = claimsMap[claim_id];
    newClaim.status = status;
    switch (status_pay) {
      case "1":
        newClaim.status_pay = "Не оплачено";
        break;
      case "2":
        newClaim.status_pay = "Оплачено частично";
        break;
      case "3":
        newClaim.status_pay = "Оплачено";
        break;
    }
    setState(() {
      claimsMap.update(claim_id, (value) => newClaim);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    updateClaimService ??= DependencyProvider.of(context)!.updateClaimService;
    baseClaimSendService ??=
        DependencyProvider.of(context)!.baseClaimSendService;
    mainClaimSendService ??=
        DependencyProvider.of(context)!.mainClaimSendService;
    baseClaimSendService!.delegateFunc = refrashDelegate;
    mainClaimSendService!.delegateFunc = refrashDelegate;
    updateClaimService!.update = updateStatus;
    profileBloc!.getClaims();
  }
}
