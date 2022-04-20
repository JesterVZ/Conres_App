import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DI/dependency-provider.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/contracts/contract-element.dart';
import 'new-ls/new-ls.dart';

class Contracts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Contracts();
}

class _Contracts extends State<Contracts>{
  ProfileBloc? profileBloc;
  List<Widget> contracts = [];

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
    builder: (context, state) {
      return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(17, 59, 17, 0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    contractsTitle,
                                    style: const TextStyle(fontSize: 24),
                                  )
                                ],
                              ),
                              //здесь договоры
                              Column(
                                children: contracts,
                              ),

                            ],
                          ))
                    ],
                  )
              ),
              Positioned(
                  width: MediaQuery.of(context).size.width,
                  bottom: 12,
                  child: Container(
                  margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: Padding(
                      padding: EdgeInsets.only(left: 18, right: 18),
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const NewLS()));
                        },
                        child: Text(linkNewLs, style: buttonTextStyle),
                        style: ElevatedButton.styleFrom(
                            primary: colorMain,shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                        ),
                      ),
                    ),
                  ))
              )



            ],
          )
      );
    });

  }

  _listener(BuildContext context, ProfileState state){
    if(state.loading == true){
      return;
    }
    if(state.contracts != null){
      for(int i = 0; i < state.contracts!.length; i++){
        contracts.add(
            ContractElement(
                thisLs: state.contracts![i].account_number!,
                thisAddress: state.contracts![i].account_address!,
                thisDateAdded: state.contracts![i].date_added!,
                status: int.parse(state.contracts![i].status!))
        );
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