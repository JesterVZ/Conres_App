import 'package:accordion/accordion.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
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
  const Claims({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Claims();
}

class _Claims extends State<Claims> {
  ProfileBloc? profileBloc;
  String? userId;
  List<ClaimElement> claims = [];
  ScrollController controller = ScrollController();

  @override
  void initState() {
    controller.addListener(pagination);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Scaffold(
              body: Container(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding),
                    height: 100,
                    child: HeaderNotification(
                      text: "Заявления",
                    )),
                Expanded(
                    child: ListView.builder(
                  itemCount: claims.length,
                  itemBuilder: (context, index) {
                    return ClaimElement(currentClaim: state.claims![index], downloadFunction: downloadClaim, userId: userId,);
                  },
                )),
                Container(
                  padding: EdgeInsets.only(left: defaultSidePadding, right: defaultSidePadding),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewClaimStep1()));
                    },
                    child: Text("Новое заявление", style: buttonTextStyle),
                    style: ElevatedButton.styleFrom(
                        primary: colorMain,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                )
              ],
            ),
          ));
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      return;
    }
    if (state.bindLsData != null) {
      userId = state.bindLsData!.data['user_id'];
    }
    if (state.claims != null) {
      if (claims.isEmpty) {
        setState(() {
          for (int i = 0; i < state.claims!.length; i++) {
            claims.add(ClaimElement(currentClaim: state.claims![i], downloadFunction: downloadClaim, userId: userId,));
          }
        });
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

  void downloadClaim(Claim claim){
    String url = claimLoadLink + claim.document_href!;
    String filename = getFileName(claim.document_href!);
    profileBloc!.downloadFile(url, filename);
  }

  String getFileName(String value){
    List<String> result = value.split("/");
    return result[1];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileBloc!.getClaims();
  }
}
