import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../DI/dependency-provider.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';

class PrivacyPolicy extends StatefulWidget {
  ValueChanged<bool> func;
  PrivacyPolicy({required this.func});
  
  @override
  State<StatefulWidget> createState() => _PrivacyPolicy();
}

class _PrivacyPolicy extends State<PrivacyPolicy>{
  ProfileBloc? profileBloc;
  String data = "";
  bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(
                left: defaultSidePadding,
                right: defaultSidePadding,
                bottom: defaultSidePadding),
            child: Scrollbar(
                child: SingleChildScrollView(
              child: Column(children: [
                Visibility(
                          child: Center(
                              child: Container(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(color: colorMain),
                          )),
                          visible: (isLoading == true) ? true : false),
                Html(
                  data: data,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: ElevatedButton(
                      onPressed: () {
                        widget.func.call(true);
                        Navigator.pop(context);
                      },
                      child: Text("Согласен", style: buttonTextStyle),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: colorMain)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: ElevatedButton(
                      onPressed: () {
                        widget.func.call(false);
                        Navigator.pop(context);
                      },
                      child: Text("Не согласен",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: colorGray)),
                ),
              ]),
            ))));

      }
    );
      
  }

  _listener(BuildContext context, ProfileState state) {
    isLoading = state.loading;
    if(state.loading == true){
      return;
    }

    if(state.privatePolicyString != null){
      data = state.privatePolicyString!;
    }

  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    super.didChangeDependencies();
    profileBloc!.getPrivatePolicy();
  }
}
