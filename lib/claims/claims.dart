import 'package:accordion/accordion.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
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
  List<ClaimElement> claims = [];
  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.only(left: 18, right: 18),
              color: pageColor,
              child: Column(
                children: [
                  Container(
                      height: 100,
                      child: HeaderRow(text: reportsPage, fontSize: 24)
                  ),
                  Expanded(child: Scrollbar(child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: claims
                          )
                        ],
                      )
                  ))),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: Padding(
                      padding: EdgeInsets.only(left: 18, right: 18),
                      child: ElevatedButton(
                        onPressed: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => const NewLS()));
                        },
                        child: Text(linkNewLs, style: buttonTextStyle),
                        style: ElevatedButton.styleFrom(
                            primary: colorMain,shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          );
        });

  }
  _listener(BuildContext context, ProfileState state) {
    if(state.loading == true){
      return;
    }
    if(state.claims != null){
      for(int i = 0; i < state.claims!.length; i++){
        claims.add(ClaimElement(currentClaim: state.claims![i]));
      }
    }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileBloc!.getClaims();
  }
}
