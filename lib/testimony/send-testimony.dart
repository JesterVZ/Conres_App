import 'package:conres_app/testimony/link-pu.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../consts.dart';
import '../elements/bloc-screen.dart';
import '../elements/header-notification.dart';
import '../elements/testimony.dart';

class SendTestimony extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SendTestimony();
}

class _SendTestimony extends State<SendTestimony> {
  AuthBloc? authBloc;
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
    return BlocScreen<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) => _listener(context, state),
    builder: (context, state) {
      return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(21, 58, 21, 54),
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
                                  child: HeaderNotification(sendTestimony)),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 61,
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          primary: colorGray,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: const [
                                              Text("Текущий Лицевой счёт",
                                                  style: TextStyle(
                                                      color: Colors.white, fontSize: 14)),
                                              Text("345672309",
                                                  style: TextStyle(
                                                      color: Colors.white, fontSize: 18))
                                            ],
                                          ),
                                          Spacer(),
                                          Container(
                                            //margin: EdgeInsets.fromLTRB(45, 0, 0, 0),
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                                color: meterDataColor,
                                                shape: BoxShape.circle),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(13, 9, 11, 9),
                                              child: SvgPicture.asset(
                                                "assets/ls-right-arrow.svg",
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ))),
                              content,
                            ],
                          ),
                        )
                      ],
                    ),

                  ],
                )
              ],
            ),
          ));
    });

  }
  _listener(BuildContext context, AuthState state){
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
    if(state.testimony != null){
      try{
        List<Widget> meters = [];
        for(int i = 0; i < state.testimony!.length; i++){
          meters.add(Testimony(state.testimony![i]));
        }
        content = Column(
          children: meters,
        );

      } catch(e){
        print(e.toString());
      }
    }
  }
  @override
  void didChangeDependencies() {
    authBloc ??= DependencyProvider.of(context)!.authBloc;
    authBloc!.getTestimony();
    super.didChangeDependencies();
  }
}
