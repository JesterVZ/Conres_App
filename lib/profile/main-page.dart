import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/contracts/contracts.dart';
import 'package:conres_app/elements/logout-alert.dart';
import 'package:conres_app/profile/profile-ls.dart';
import 'package:conres_app/profile/profile-no-ls.dart';
import 'package:conres_app/testimony/info-pu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../chats/chats.dart';
import '../claims/claims.dart';
import '../claims/new-claim/new-claim-step-1.dart';
import '../consts.dart';
import '../elements/bloc-screen.dart';
import '../icons.dart';
import '../login/login-main.dart';
import '../model/profile.dart';
import '../shared-preferences/shared-preferences.dart';

class MainPage extends StatefulWidget{
  const MainPage({Key? key, this.loginData, this.profile}) : super(key: key);
  final List<dynamic>? loginData;
  final Profile? profile;

  @override
  State<StatefulWidget> createState() => _MainPage();
}
class _MainPage extends State<MainPage>{
  int _selectedPage = 0;
  List<Widget> pageList = [];
  late SharedPreferences preferences;
  AuthBloc? authBloc;
  ProfileBloc? profileBloc;
  WebSocketChannel? webSocketChannel;

  void _onItemTapped(int index) {
    setState(() {
      if(index == 4){
        showMenu<String>(
          context: context,
          position: const RelativeRect.fromLTRB(550.0, 550.0, 0.0, 0.0),
          items: <PopupMenuItem<String>>[
            PopupMenuItem<String>(
                child: const Text('Информация о ПУ'),
                onTap: (){
                  setState(() {
                    _selectedPage = 4;
                  });

            }),
            PopupMenuItem<String>(
                child: const Text('Заявление на тех. присоединение'),
                onTap: (){
            }),
            PopupMenuItem<String>(
                child: const Text('Информация'), onTap:() {
            }),
            PopupMenuItem<String>(
                child: const Text('Выход'), onTap:() {
                  authBloc!.logout();
            }),
          ],
          elevation: 8.0,
      );
      } else {
        _selectedPage = index;
      }

    });
  }

  @override
  void initState() {
    if(widget.loginData != null){
      pageList.add(ProfilePage(loginData: widget.loginData));
    }
    if(widget.profile != null){
      pageList.add(ProfilePage(profile: widget.profile));
    }
    pageList.add(Contracts());
    pageList.add(const Claims());
    pageList.add(Chats());
    pageList.add(InfoPU());
    pageList.add(NewClaimStep1());
    initSharedPreferences();
    super.initState();
  }

  void initSharedPreferences() async{
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return BlocScreen<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) => _listener(context, state),
    builder: (context, state) {
      return Scaffold(
        body: IndexedStack(
          index: _selectedPage,
          children: pageList,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    const Icon(CustomIcons.home),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.red,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 12,
                          maxHeight: 12
                        ),
                        child: const Text("10", style: TextStyle(
                          color: Colors.white,
                          fontSize: 8
                        ),
                        textAlign: TextAlign.center,),
                      ),
                    )
                  ],
                ),
                label: mainPage),
            BottomNavigationBarItem(
                icon: const Icon(CustomIcons.contracts),
                label: contractsPage),
            BottomNavigationBarItem(
                icon: const Icon(CustomIcons.reports),
                label: reportsPage),
            BottomNavigationBarItem(
                icon: const Icon(CustomIcons.chat),
                label: chatPage),
            BottomNavigationBarItem(
                icon: const Icon(CustomIcons.dot_3),
                label: moreAction
            )
          ],
          currentIndex: _selectedPage,
          selectedItemColor: colorMain,
          onTap: _onItemTapped,
        ),
      );
    });

  }

  _listener(BuildContext context, AuthState state){
    if(state.loading == true){
      return;
    }
    if(state.loginData!.isEmpty){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
    }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc ??= DependencyProvider.of(context)!.authBloc;
    webSocketChannel ??= DependencyProvider.of(context)!.webSocketChannel;

    webSocketChannel?.sink.add(data)
  }
}