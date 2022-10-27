import 'package:conres_app/profile/main-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DI/dependency-provider.dart';
import '../UI/main-form.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../consts.dart';
import '../elements/TU/TU-element.dart';
import '../elements/TU/edit-tu-dialog.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/header/header-notification.dart';
import '../elements/testimony/object-pu-dialog.dart';

class PageTU extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageTU();
}

class _PageTU extends State<PageTU> {
  ProfileBloc? profileBloc;
  List<Widget> objects = []; // ТУ
  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return MainForm(
            header: HeaderNotification(text: "Точки учета"),
            body: Column(
              children: objects,
            ),
          );
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      return;
    }
    if (objects.isEmpty) {
      if (state.TuPoints != null && state.TuPoints!.isNotEmpty) {
        for (int i = 0; i < state.TuPoints!.length; i++) {
          objects.add(TuElement(
            currentTu: state.TuPoints![i],
            editFunc: _edit,
          ));
        }
      }
    }
  }

  void _edit() {
    showDialog(
        context: context,
        builder: (BuildContext context) => EditTuDialog(
              title: "Редактировать ТУ",
              function: () {},
            ));
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileBloc!.getTuPoints();
    super.didChangeDependencies();
  }
}
