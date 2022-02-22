import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../consts.dart';
import '../elements/bloc-screen.dart';
import '../elements/header.dart';
import '../network.dart';
import '../profile/profile-ls.dart';

class LoginEmail extends StatefulWidget {
  const LoginEmail({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginEmail();
}

class _LoginEmail extends State<LoginEmail> {
  TextEditingController lkController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthBloc? authBloc;
  final Widget svg = SvgPicture.asset('assets/background_image.svg',
      color: colorLogo, semanticsLabel: 'Acme Logo');

  @override
  Widget build(BuildContext context) {
    return BlocScreen<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) => _listener(context, state),
    builder: (context, state) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Padding(
                  padding: EdgeInsets.fromLTRB(21, 74, 21, 0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 14),
                        child: HeaderRow(loginAccount, 34, false),
                      ),

                      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lkInputText,
                                style: labelTextStyle,
                              ),
                              TextField(
                                controller: lkController,
                                decoration: InputDecoration(
                                    hintText: "E-mail",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: inputBorder))),
                              )
                            ],
                          )
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: 26),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lkPasswordText,
                                style: labelTextStyle,
                              ),
                              TextField(
                                controller: passwordController,
                                autofocus: false,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: inputBorder))),
                              )
                            ],
                          )
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: ElevatedButton(
                                    onPressed: () {
                                      _handleLogin(state, lkController.text, passwordController.text);

                                    },
                                    child: Text(
                                      login,
                                      style: buttonTextStyle,
                                    ),
                                    style:
                                    ElevatedButton.styleFrom(primary: colorMain))),
                          ),

                          //ElevatedButton(onPressed: (){}, child: Text(login)),
                        ],
                      )


                    ],
                  )
              )
          );
    });

  }

  _handleLogin(AuthState state, String username, String password) {
    authBloc!.login(username, password);
  }
  _listener(BuildContext context, AuthState state) {
    if (state.loading!) {
      return;
    }
    if(state.error == null){
      Navigator.push(context, MaterialPageRoute(builder:  (context) =>  ProfilePage(profile: state.profile)));
    } else {

    }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc ??= DependencyProvider.of(context)!.authBloc;
  }
}
