import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/cupertino.dart';

import '../../../UI/default-button.dart';
import '../../../UI/main-form.dart';
import '../../../bloc/profile/profile-bloc.dart';
import '../../../bloc/profile/profile-state.dart';
import '../../../consts.dart';
import '../../../elements/bloc/bloc-screen.dart';

class NewContact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewContact();
}

class _NewContact extends State<NewContact> {
  ProfileBloc? profileBloc;
  final _formKey = GlobalKey<FormState>();
  Future<void> _refrash() async {}
  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return MainForm(
            onRefrash: _refrash,
            header: HeaderNotification(text: "Новый контакт", canGoBack: true),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding),
                    child: Form(key: _formKey, child: Column(children: [])))),
            footer: DefaultButton(
              text: "Отправить запрос на привязку",
              isGetPadding: true,
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
            ),
          );
        });
  }

  _listener(BuildContext context, ProfileState state) {}
  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    super.didChangeDependencies();
  }
}
