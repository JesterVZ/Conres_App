import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:conres_app/elements/route/def-page-router.dart';
import 'package:conres_app/loading/loading-page.dart';
import 'package:conres_app/model/contract.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DI/dependency-provider.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/contracts/contract-element.dart';
import 'new-ls/new-ls.dart';

class Contracts extends StatefulWidget {
  bool canLogin;
  ValueChanged<Contract> func;
  Contracts({required this.canLogin, required this.func});
  @override
  State<StatefulWidget> createState() => _Contracts();
}

class _Contracts extends State<Contracts> {
  ProfileBloc? profileBloc;
  List<Widget> contracts = [];

  Future<void> _refrash() async {
    contracts.clear();
    profileBloc!.getContracts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return MainForm(
            header: HeaderNotification(text: "Договоры", canGoBack: false),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding),
                    child: Column(
                      children: contracts,
                    ))),
            onRefrash: _refrash,
            footer: DefaultButton(
              onPressed: () {},
              isGetPadding: true,
              text: "Новый лицевой счет",
            ),
          );
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      return;
    }
    if (state.contracts != null) {
      if (contracts.isEmpty) {
        for (int i = 0; i < state.contracts!.length; i++) {
          contracts.add(ContractElement(
              contract: state.contracts![i],
              func: widget.func,
              canLogin: widget.canLogin));
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileBloc!.getContracts();
    super.didChangeDependencies();
  }
}
