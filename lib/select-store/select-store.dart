import 'package:conres_app/bloc/auth/auth-block.dart';
import 'package:conres_app/bloc/auth/auth-state.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/elements/bloc/bloc-screen.dart';
import 'package:conres_app/elements/store/store-element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../DI/dependency-provider.dart';
import '../elements/splash/splash-screen.dart';
import '../model/store.dart';

class SelectStore extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SelectStore();
}

class _SelectStore extends State<SelectStore>{
  List<Widget> stors = [];
  AuthBloc? authBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocScreen<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: stors
            ),
          ),
        );
      })
    );
  }
  _listener(BuildContext context, AuthState state){
    if(state.loading == true){
      return;
    }
    if(state.stors != null){
      if(stors.isEmpty){
        for(int i = 0; i < state.stors!.length; i++){
          stors.add(StoreElement(store: state.stors![i], choose: choose,));
        }
        
      }
    }
  }
  void choose(Store store) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('store', store.name!);
    domain = store.url!;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SplashScreen()), (route) => false);
  }
  @override
  void didChangeDependencies() {
    authBloc ??= DependencyProvider.of(context)!.authBloc;
    authBloc!.getStores();
    super.didChangeDependencies();
  }
}