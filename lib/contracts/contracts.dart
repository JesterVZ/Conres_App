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
          return Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 52),
                  padding: EdgeInsets.only(
                      left: defaultSidePadding,
                      right: defaultSidePadding,
                      bottom: 12),
                  child: HeaderNotification(
                    text: "Договоры",
                  )),
              Expanded(
                  child: Scrollbar(
                      child: RefreshIndicator(
                          onRefresh: _refrash,
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              Column(
                                children: [
                                  //здесь договоры
                                  Column(
                                    children: contracts,
                                  ),
                                ],
                              )
                            ],
                          ))))),
              Container(
                padding: EdgeInsets.only(
                    left: defaultSidePadding, right: defaultSidePadding),
                width: MediaQuery.of(context).size.width,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const NewLS()));
                  },
                  child: Text(linkNewLs, style: buttonTextStyle),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colorMain,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              )
            ],
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
