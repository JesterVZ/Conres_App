import 'package:conres_app/consts.dart';
import 'package:conres_app/model/object_pu.dart';
import 'package:conres_app/testimony/tu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'object-pu-dialog.dart';

class ObjectPU extends StatefulWidget {
  ObjectPuModel objectPuModel;
  Function remove;
  ObjectPU({required this.objectPuModel, required this.remove});
  @override
  State<StatefulWidget> createState() => _ObjectPU();
}

class _ObjectPU extends State<ObjectPU> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: defaultSidePadding, right: defaultSidePadding),
        child: Container(
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
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.fromLTRB(11, 6, 11, 6),
                    decoration: BoxDecoration(
                        color: widget.objectPuModel.status == "0"
                            ? redColor
                            : widget.objectPuModel.status == "1"
                                ? yellowColor
                                : greenColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      widget.objectPuModel.status == "0"
                          ? "Заявка на привязку ПУ отклонена"
                          : widget.objectPuModel.status == "1"
                              ? "Проходит проверку"
                              : "Активный",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  const Spacer(),
                  Visibility(
                    visible: widget.objectPuModel.status == "0" ? true : false,
                    child: Material(
                        child: InkWell(
                      onTap: () {
                        widget.remove.call(widget.objectPuModel);
                      },
                      child: SvgPicture.asset(
                        'assets/remove-file.svg',
                        color: colorGrayClaim,
                      ),
                    )),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Наименование объекта",
                        style: TextStyle(
                          color: colorGrayClaim,
                          fontSize: 15,
                        )),
                    Text(
                      widget.objectPuModel.name!,
                    )
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
              Visibility(
                  visible: widget.objectPuModel.comments != null ? true : false,
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Комментарий",
                              style: TextStyle(
                                  color: profileLabelColor, fontSize: 15)),
                          Text(
                              widget.objectPuModel.comments == null
                                  ? ""
                                  : widget.objectPuModel.comments!,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15))
                        ],
                      ))),
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
                        style: ElevatedButton.styleFrom(
                            backgroundColor: messageColor),
                        child: Text("Редактировать",
                            style: TextStyle(color: colorMain))),
                  ),
                  const Spacer(),
                  Container(
                    height: 50,
                    width: 142,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PageTU()));
                        },
                        style: ElevatedButton.styleFrom(primary: messageColor),
                        child: Text("Подробнее",
                            style: TextStyle(color: colorMain))),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
