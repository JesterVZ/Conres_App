import 'dart:core';

import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/elements/testimony/testimony-not-found.dart';
import 'package:conres_app/testimony/link-pu.dart';
import 'package:conres_app/testimony/objects-pu.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/header/header-notification.dart';
import '../elements/testimony/testimony.dart';

class SendTestimony extends StatefulWidget {
  final String? personal;

  const SendTestimony({required this.personal});

  @override
  State<StatefulWidget> createState() => _SendTestimony();
}

class _SendTestimony extends State<SendTestimony> {
  ProfileBloc? profileBloc;
  bool getPU = false;
  List<Widget> meters = [];
  Widget content = Container(
      margin: EdgeInsets.only(top: 21),
      decoration: DottedDecoration(
        shape: Shape.box,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(testimonyNotFound,
            textAlign: TextAlign.center,
            style: TextStyle(color: dashedColor, fontSize: 16)),
      ));
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
                    child: HeaderNotification(text: "Передача показаний")
                ),
                Expanded(child: Scrollbar(child: SingleChildScrollView(
                    child: content
                ))),
                Visibility(
                  visible: getPU,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 24),
                    width: MediaQuery.of(context).size.width - 35,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(primary: colorMain, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      child: Text("Передать показания", style: TextStyle(fontSize: 18),),
                    )
                  ),
                ),
                Visibility(
                  visible: !getPU,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 24),
                              width: MediaQuery.of(context).size.width - 35,
                              height: 70,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ObjectsPU()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: colorGray, shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)
                                  )),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SvgPicture.asset('assets/meters-data.svg', color: colorGray,),
                                        ),
                                        //margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                      ),
                                      Spacer(),
                                      const Text(
                                        "Привязать новый ПУ",
                                        style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Bubicon-Medium'),
                                      ),
                                      Spacer(),
                                      Container(
                                        //margin: EdgeInsets.fromLTRB(45, 0, 0, 0),
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                            color: meterDataColor,
                                            shape: BoxShape.circle
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(13, 9, 11, 9),
                                          child: SvgPicture.asset("assets/ls-right-arrow.svg", color: Colors.white,),
                                        ),
                                      )
                                    ],
                                  ))))
              ],
            ),
          ));
    });

  }
  _listener(BuildContext context, ProfileState state){
    if(state.loading!){
      content = Center(
        child: Container(
          width: 50,
          height: 50,
          child: Image.asset('assets/loading.gif')
        )

      );
      return;
    }
    if(state.meters != null){
      getPU = true;
      for(int i = 0; i < state.meters!.length; i++){
        meters.add(Testimony(state.meters![i]));
      }
      content = Column(
        children: meters,
      );
    }
  }
  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    //profileBloc!.getTU();
    super.didChangeDependencies();
  }
}
