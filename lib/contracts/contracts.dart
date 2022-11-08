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
import '../Services/bottom-navigation-select-service.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/contracts/contract-element.dart';
import 'new-ls/new-ls.dart';

class Contracts extends StatefulWidget {
  ValueChanged<Contract> func;
  Contracts({required this.func});
  @override
  State<StatefulWidget> createState() => _Contracts();
}

class _Contracts extends State<Contracts> {
  ProfileBloc? profileBloc;
  List<Widget> contracts = [];
  BottomNavigationSelectService? bottomNavigationSelectService;

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
            body: ListView.builder(
                  itemCount: claimsMap.length,
                  itemBuilder: (context, int index) {
                    return ContractElement(
                      contract: contract, 
                      func: widget.func, 
                      bottomNavigationSelectService: bottomNavigationSelectService!);
                  }),
            onRefrash: _refrash,
            footer: DefaultButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => NewLS()));
              },
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
              bottomNavigationSelectService: bottomNavigationSelectService!,
              contract: state.contracts![i],
              func: widget.func));
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    bottomNavigationSelectService ??=
        DependencyProvider.of(context)!.bottomNavigationSelectService;
    profileBloc!.getContracts();
    super.didChangeDependencies();
  }
}
