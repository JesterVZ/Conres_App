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
import 'link-pu/link-pu-step-1.dart';
import 'link-tu/link-tu.dart';

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
              onRefrash: _refrash,
              header: HeaderNotification(canGoBack: true, text: "Точки учета"),
              body: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: defaultSidePadding, right: defaultSidePadding),
                      child: Column(
                        children: objects,
                      ))),
              footer: Container(
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                          left: defaultSidePadding,
                        ),
                        width: 160,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LinkTu()));
                          },
                          child: const Text("Новый ТУ",
                              style: TextStyle(fontSize: 14)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colorMain,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        )),
                    const Spacer(),
                    Container(
                        padding: EdgeInsets.only(right: defaultSidePadding),
                        width: 160,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LinkPUStep1()));
                          },
                          child: const Text("Новый ПУ",
                              style: TextStyle(fontSize: 14)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colorMain,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ))
                  ],
                ),
              ));
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

  Future<void> _refrash() async {}

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
