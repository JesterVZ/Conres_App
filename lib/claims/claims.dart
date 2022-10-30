import 'package:accordion/accordion.dart';
import 'package:conres_app/Services/update-claim-service.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/claims/new-claim/new-claim-documant.dart';
import 'package:conres_app/claims/new-claim/new-claim-step-1.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/model/claim.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DI/dependency-provider.dart';
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

  @override
  void initState() {
    controller.addListener(pagination);
    super.initState();
  }

  Future<void> _refrash() async {
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
              body: ListView.builder(
                  itemCount: claimsMap.length,
                  itemBuilder: (context, int index) {
                    return ClaimElement(
                        currentClaim: claimsMap.values.elementAt(index),
                        downloadFunction: downloadClaim,
                        userId: userId,
                        mainListener: widget.mainListener);
                  }),
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
      return;
    }
    if (state.fullInfo != null) {
      userId = state.fullInfo!['user_id'];
      if (state.claims != null) {
        if (claims.isEmpty) {
          setState(() {
            claimsMap = {for (var e in state.claims!) e.claim_id!: e};
          });
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
    updateClaimService!.update = updateStatus;
    profileBloc!.getClaims();
  }
}
