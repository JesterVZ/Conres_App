import 'package:conres_app/model/contract.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Services/bottom-navigation-select-service.dart';
import '../../consts.dart';
/* 
contract-element.dart
Виджеты договоров

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class ContractElement extends StatelessWidget {
  final Contract contract;
  Function remove;
  ValueChanged<Contract> func;
  BottomNavigationSelectService bottomNavigationSelectService;

  ContractElement(
      {required this.contract,
      required this.func,
      required this.remove,
      required this.bottomNavigationSelectService});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (bottomNavigationSelectService.canLogin == true) {
            func.call(contract);
          }
        },
        child: Padding(
          padding:
          EdgeInsets.only(left: defaultSidePadding, right: defaultSidePadding),
          child: Container(
          margin: EdgeInsets.only(top: 14, bottom: 14),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xFFD4D9E6),
                                        spreadRadius: 5,
                                        blurRadius: 16,
                                        offset: Offset(0, 8),
                                      )],
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                  defaultSidePadding, 14, defaultSidePadding, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.fromLTRB(11, 6, 11, 6),
                    decoration: BoxDecoration(
                        color: contract.approve == "0"
                            ? redColor
                            : contract.approve == "1"
                                ? yellowColor
                                : greenColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      contract.approve == "0"
                          ? "Не прошёл проверку"
                          : contract.approve == "1"
                              ? "Проходит проверку"
                              : "Активный",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  const Spacer(),
                  Visibility(
                    visible: contract.approve == "0" ? true : false,
                  child: Material(
                    child: InkWell(
                      onTap: (){
                        remove.call(contract);
                      },
                      child: SvgPicture.asset('assets/remove-file.svg', color: colorGrayClaim,),
                    )
                  ),
                  )
                  
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(currentLs,
                                  style: TextStyle(
                                      color: profileLabelColor, fontSize: 15)),
                              Text(contract.account_number!,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18))
                            ],
                          ),
                          const Spacer(),
                          Visibility(
                            child: Container(
                              width: 40,
                              height: 40,
                              child: SvgPicture.asset("assets/fire.svg"),
                            ),
                            visible: contract.isCurrent!,
                          )
                        ],
                      )),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dateAdded,
                              style: TextStyle(
                                  color: profileLabelColor, fontSize: 15)),
                          Text(contract.date_added!,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18))
                        ],
                      )),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(objectAddress,
                              style: TextStyle(
                                  color: profileLabelColor, fontSize: 15)),
                          Text(contract.account_address!,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18))
                        ],
                      )),
                  Visibility(
                    visible: contract.comments != "" ? true : false,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Комментарий",
                              style: TextStyle(
                                  color: profileLabelColor, fontSize: 15)),
                          Text(contract.comments!,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18))
                        ],
                      )))
                ],
              )),
        
        ))
        );
          
  }
}
