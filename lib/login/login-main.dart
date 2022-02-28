
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../consts.dart';
import '../elements/bloc-screen.dart';
import '../profile/profile-ls.dart';
import '../shared-preferences/shared-preferences.dart';
import 'login-account.dart';
import 'change-type.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController lkController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthBloc? authBloc;
  SharedPreferences? preferences;
  bool flag = false;
  final Widget svg = SvgPicture.asset('assets/background_image.svg',
      color: colorLogo, semanticsLabel: 'Acme Logo');
  @override
  void initState(){
    getSharedData();
  }

  void getSharedData() async{
    preferences = await SharedPreferences.getInstance();
    _handleCheckLogin(preferences!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocScreen<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) => _listener(context, state),
    builder: (context, state) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(right: 0, child: svg),
              Padding(
                  padding: EdgeInsets.only(left: 27, right: 27, top: 76),
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Flexible(
                          flex: 1,
                          child: Text(lkTitle,
                              style: const TextStyle(
                                  fontFamily: 'Bubicon-Bold',
                                  fontSize: 36.0)))
                    ],
                  )),
              Positioned(
                width: MediaQuery.of(context).size.width,
                bottom: 20,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 55.0,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const ChangeType()));
                              },
                              child: Text(
                                reg,
                                style: const TextStyle(fontSize: 18.0),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: colorMain))),
                    ),

                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 55.0,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginEmail()));
                            },
                            child: Text(
                              login,
                              style: buttonTextStyle,
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: colorGray))),

                    //ElevatedButton(onPressed: (){}, child: Text(login)),
                  ],
                ),
              )
            ],
          ));
    });
  }

  Object loginData() async{
    var result = await getLogin(preferences!).then((value) {
      print(value);
    });
    return List<dynamic>;
  }

  _listener(BuildContext context, AuthState state) {
    if(state.isLogin != null){
      if(state.isLogin == true){
        authBloc!.getLogin(preferences!);
        if(state.loginData != null){
          authBloc!.login(state.loginData![0], state.loginData![1]);
          if(state.profile != null) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) => ProfilePage(profile: state.profile)), (route) => false);
          }
        }

      } else{
        return;
      }
    } else {
      return;
    }
  }

  _handleCheckLogin(SharedPreferences preferences){
    authBloc!.checkLogin(preferences);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc ??= DependencyProvider.of(context)!.authBloc;
  }
}
