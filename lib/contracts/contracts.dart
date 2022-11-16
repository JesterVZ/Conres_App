import 'dart:convert';

import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:conres_app/elements/route/def-page-router.dart';
import 'package:conres_app/loading/loading-page.dart';
import 'package:conres_app/model/contract.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../DI/dependency-provider.dart';
import '../Services/bottom-navigation-select-service.dart';
import '../Services/update-account-service.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/contracts/contract-element.dart';
import '../websocket/message-send.dart';
import 'new-ls/new-ls.dart';

class Contracts extends StatefulWidget {
  ValueChanged<Contract> func;
  Contracts({required this.func});
  @override
  State<StatefulWidget> createState() => _Contracts();
}

class _Contracts extends State<Contracts> {
  ProfileBloc? profileBloc;
  List<Contract> contracts = [];
  Map<String, dynamic> contractsMap = {};
  BottomNavigationSelectService? bottomNavigationSelectService;
  UpdateAccountService? updateAccountService;
  WebSocketChannel? webSocketChannel;

  bool isLoaded = false;

  Future<void> _refrash() async {
    isLoaded = false;
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
                  itemCount: contractsMap.length,
                  itemBuilder: (context, int index) {
                    return ContractElement(
                      contract: contractsMap.values.elementAt(index), 
                      func: widget.func,
                      remove: removeContract,
                      bottomNavigationSelectService: bottomNavigationSelectService!);
                  }),
            onRefrash: _refrash,
            footer: DefaultButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => NewLS(refrash: _refrash)));
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
    if (state.contracts != null && state.contracts!.isNotEmpty && isLoaded == false) {
      contractsMap = {for (var e in state.contracts!) e.account_id!: e};
      isLoaded = true;
    }
  }

  void updateStatus(String id, String status, String? comment){
    Contract newContract = contractsMap[id];
    newContract.approve = status;
    if(comment != null){
      newContract.comments = comment;
    }
    setState(() {
      contractsMap.update(id, (value) => newContract);
    });
  }

  void removeContract(Contract contract){
    profileBloc!.hiddenAccout(contract.account_id!);
    dynamic message = MessageSend(
                    cmd: "publish",
                    subject: "store-${store_id}",
                    event: "account_hidden",
                    data: AccountHidden(account_id: contract.account_id),
                    to_id: int.parse(user_id!)
                  );
      String data = jsonEncode(message.toJson());
      webSocketChannel!.sink.add(data);
    setState(() {
      contractsMap.remove(contract.account_id);
    });
    
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    webSocketChannel ??= DependencyProvider.of(context)!.webSocketChannel(false);
    bottomNavigationSelectService ??=
        DependencyProvider.of(context)!.bottomNavigationSelectService;
    updateAccountService ??= DependencyProvider.of(context)!.updateAccountService;
    updateAccountService!.update = updateStatus;
    profileBloc!.getContracts();
    super.didChangeDependencies();
  }
}
