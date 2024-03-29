import 'package:conres_app/consts.dart';
import 'package:conres_app/model/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/* 
store-element.dart
Кнопка выбора компании (в экране, который нужен для тестировщика)

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class StoreElement extends StatelessWidget{
  Store? store;
  ValueChanged<Store>? choose;
  StoreElement({required this.store, required this.choose});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width,
      height: 55,
      child: ElevatedButton(
        onPressed: (){
          choose!.call(store!);
        },
        style: ElevatedButton.styleFrom(
          primary: colorMain
        ),
        child: Text(store!.name!),
      ),
    );
  }
}