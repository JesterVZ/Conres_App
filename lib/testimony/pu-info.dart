import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/profile/profile-state.dart';
import '../elements/bloc/bloc-screen.dart';

class PuFullInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PuFullInfo();
}

class _PuFullInfo extends State<PuFullInfo> {
  ProfileBloc? profileBloc;
  Widget body = Container();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return MainForm(
            header:
                HeaderNotification(text: "Информация о ПУ", canGoBack: false),
            body: body,
            onRefrash: _refrash,
          );
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      return;
    }
    if (state.meters != null) {
      /*
      body = ListView.builder(
          controller: scrollController,
          itemCount: state.meters!.length,
          itemBuilder: (context, int index) {
            return ObjectPU(
                objectPuModel: objects[index], remove: removeObject);
          }); */
    }
  }

  Future<void> _refrash() async {}
}
