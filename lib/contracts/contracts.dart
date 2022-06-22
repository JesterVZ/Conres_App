import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/elements/header/header.dart';
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
  @override
  State<StatefulWidget> createState() => _Contracts();
}

class _Contracts extends State<Contracts> {
  ProfileBloc? profileBloc;
  List<Widget> contracts = [];

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                Container(
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding),
                    height: 100,
                    child: HeaderNotification(
                      text: "Договоры",
                    )),
                Expanded(
                    child: Scrollbar(
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
                )))),
                Container(
                  padding: EdgeInsets.only(left: defaultSidePadding, right: defaultSidePadding),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewLS()));
                    },
                    child: Text(linkNewLs, style: buttonTextStyle),
                    style: ElevatedButton.styleFrom(
                        primary: colorMain,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                )
              ],
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
              thisLs: state.contracts![i].account_number!,
              thisAddress: state.contracts![i].account_address!,
              thisDateAdded: state.contracts![i].date_added!,
              status: int.parse(state.contracts![i].status!)));
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
