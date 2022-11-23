import 'package:conres_app/consts.dart';
import 'package:conres_app/model/object_pu.dart';
import 'package:conres_app/testimony/tu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'object-pu-dialog.dart';

class ObjectPU extends StatefulWidget {
  ObjectPuModel objectPuModel;
  ObjectPU({required this.objectPuModel});
  @override
  State<StatefulWidget> createState() => _ObjectPU();
}

class _ObjectPU extends State<ObjectPU> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: defaultSidePadding, right: defaultSidePadding), child: Container(
      padding: EdgeInsets.all(17),
      margin: EdgeInsets.only(top: 14, bottom: 14),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Наименование объекта",
                    style: TextStyle(color: colorGrayClaim, fontSize: 15)),
                Text(widget.objectPuModel.name!)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Адрес объекта:",
                    style: TextStyle(color: colorGrayClaim, fontSize: 15)),
                Text(widget.objectPuModel.address!)
              ],
            ),
          ),
          Row(
            children: [
              Container(
                height: 50,
                width: 142,
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => ObjectPuDialog(
                              id: widget.objectPuModel.object_id,
                              title: "Редактировать объект"));
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: messageColor),
                    child: Text("Редактировать",
                        style: TextStyle(color: colorMain))),
              ),
              const Spacer(),
              Container(
                height: 50,
                width: 142,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PageTU()));
                    },
                    style: ElevatedButton.styleFrom(primary: messageColor),
                    child:
                        Text("Подробнее", style: TextStyle(color: colorMain))),
              ),
            ],
          )
        ],
      ),
    )
  );
    
  }
}
