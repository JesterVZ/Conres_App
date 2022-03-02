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
          body: Stack(
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
              Positioned(
                  bottom: 24,
                  child: Container(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(21, 58, 21, 54),
                        child: Container(
                            width: MediaQuery.of(context).size.width - 35,
                            height: 70,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const LinkPU()));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                        color: Colors.white, shape: BoxShape.circle),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        'assets/plus.svg',
                                        color: colorMain,
                                      ),
                                    ),
                                    //margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    "Привязать прибор учёта",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Bubicon-Medium'),
                                  ),
                                ],
                              ),
                            ))),
                  ))
            ],
          ));
    });

  }
  _listener(BuildContext context, AuthState state){

  }
  @override
  void didChangeDependencies() {
    authBloc ??= DependencyProvider.of(context)!.authBloc;
    super.didChangeDependencies();
  }
}
