import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DI/dependency-provider.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/header/header-notification.dart';

class PageTU extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageTU();
}

class _PageTU extends State<PageTU> {
  ProfileBloc? profileBloc;
  List<Widget> objects = [];
  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Scaffold(
              body: Column(children: [
            Container(
                padding: EdgeInsets.only(
                    left: defaultSidePadding, right: defaultSidePadding),
                height: 100,
                child: HeaderNotification(
                  text: "Ваши точки учёта",
                ))
          ]));
        });
  }

  _listener(BuildContext context, ProfileState state) {}
  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileBloc!.getObjectsPU();
    super.didChangeDependencies();
  }
}
