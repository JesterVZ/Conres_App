import 'dart:io';
import 'dart:ui';
import 'package:conres_app/elements/header/header.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../consts.dart';
class NewClaimStep6 extends StatefulWidget{
  const NewClaimStep6({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewClaimStep6();
}

class _NewClaimStep6 extends State<NewClaimStep6>{
  List<FilePickerResult> images = [];
  List<Widget> documents = [];
  Map<String?, FilePickerResult?> imagesMap = {
    "1": null,
    "2": null,
    "3": null
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(17, 59, 17, 0),
                child: Column(
                  children: [
                    HeaderRow(claimStep6, 24, true),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Приложите документы", style: TextStyle(
                          color: colorMain,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )),
                        Container(
                          margin: const EdgeInsets.only(bottom: 13),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Паспорт страницы 1-2", style: TextStyle(
                                  fontSize: 16,
                                  color: colorGrayText)),
                              GestureDetector(
                                onTap: (){
                                  _loadImage(1);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 18, right: 18),
                                  height: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: imagesMap["1"] != null ? Colors.white : contractBtnColor,
                                    border: imagesMap["1"] != null ? Border.all(color: borderProfileColor) : null
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white
                                        ),
                                        child:
                                        Padding(padding: EdgeInsets.all(10),
                                            child: SvgPicture.asset("assets/file-icon.svg", color: colorMain)),
                                      ),
                                      Text(imagesMap["1"] != null ? imagesMap["1"]!.names[0].toString() : "Выбрать файл", style: TextStyle(
                                          color: colorMain
                                      )),
                                      const Spacer(),
                                      Visibility(
                                        visible: imagesMap["1"] != null ? true : false,
                                          child: GestureDetector(
                                            onTap: (){
                                              _removeImage(1);
                                            },
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  child: SvgPicture.asset('assets/remove-file.svg'),
                                                ),
                                      ))

                                    ],
                                  ),
                                )
                              )

                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 13),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Паспорт страницы 3-4", style: TextStyle(
                                  fontSize: 16,
                                  color: colorGrayText)),
                              GestureDetector(
                                  onTap: (){
                                    _loadImage(2);
                                  },
                                child: Container(
                                  padding: EdgeInsets.only(left: 18, right: 18),
                                  height: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: imagesMap["2"] != null ? Colors.white : contractBtnColor,
                                      border: imagesMap["2"] != null ? Border.all(color: borderProfileColor) : null
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white
                                        ),
                                        child:
                                        Padding(padding: EdgeInsets.all(10),
                                            child: SvgPicture.asset("assets/file-icon.svg", color: colorMain)),
                                      ),
                                      Text(imagesMap["2"] != null ? imagesMap["2"]!.names[0].toString() : "Выбрать файл", style: TextStyle(
                                          color: colorMain
                                      )),
                                      const Spacer(),
                                      Visibility(
                                          visible: imagesMap["2"] != null ? true : false,
                                          child: GestureDetector(
                                            onTap: (){
                                              _removeImage(2);
                                            },
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              child: SvgPicture.asset('assets/remove-file.svg'),
                                            ),
                                          ))
                                    ],
                                  ),
                                )
                              )

                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 13),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Документ, подтверждающий право собственности", style: TextStyle(
                                  fontSize: 16,
                                  color: colorGrayText)),
                              GestureDetector(
                                onTap: (){
                                  _loadImage(3);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 18, right: 18),
                                  height: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: imagesMap["3"] != null ? Colors.white : contractBtnColor,
                                      border: imagesMap["3"] != null ? Border.all(color: borderProfileColor) : null
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white
                                        ),
                                        child:
                                        Padding(padding: EdgeInsets.all(10),
                                            child: SvgPicture.asset("assets/file-icon.svg", color: colorMain)),
                                      ),
                                      Text(imagesMap["3"] != null ? imagesMap["3"]!.names[0].toString() : "Выбрать файл", style: TextStyle(
                                          color: colorMain
                                      )),
                                      const Spacer(),
                                      Visibility(
                                          visible: imagesMap["3"] != null ? true : false,
                                          child: GestureDetector(
                                            onTap: (){
                                              _removeImage(3);
                                            },
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              child: SvgPicture.asset('assets/remove-file.svg'),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                        Column(
                          children: documents,
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 23),
                            height: 55,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: Colors.white),
                                onPressed: (){
                                  setState(() {
                                    _addNewObject();
                                  });

                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        child: SvgPicture.asset('assets/plus.svg')
                                    ),


                                    Text("Добавить документ", style: TextStyle(color: colorMain, fontSize: 18))
                                  ],
                                ))
                        )
                      ],
                    ),
                  ],
                ))
          ],
        ),
      )
    );
  }
  void _loadImage(int index) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      setState(() {
        //images.add(result);
        imagesMap.update(index.toString(), (value) => result);
      });
    }
  }
  void _removeImage(int index) {
    setState(() {
      imagesMap[index.toString()] = null;
    });
  }
  void _addNewObject(){
    Widget object = Container(
      margin: const EdgeInsets.only(bottom: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 26, bottom: 11),
            height: 6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: colorMain
            ),
          ),
          Text("Дополнительный документ", style: TextStyle(
              fontSize: 16,
              color: colorGrayText)),
          GestureDetector(
            onTap: (){
              _loadImage(3);
            },
            child: Container(
              padding: EdgeInsets.only(left: 18, right: 18),
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: imagesMap["3"] != null ? Colors.white : contractBtnColor,
                  border: imagesMap["3"] != null ? Border.all(color: borderProfileColor) : null
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                    ),
                    child:
                    Padding(padding: EdgeInsets.all(10),
                        child: SvgPicture.asset("assets/file-icon.svg", color: colorMain)),
                  ),
                  Text(imagesMap["3"] != null ? imagesMap["3"]!.names[0].toString() : "Выбрать файл", style: TextStyle(
                      color: colorMain
                  )),
                  const Spacer(),
                  Visibility(
                      visible: imagesMap["3"] != null ? true : false,
                      child: GestureDetector(
                        onTap: (){
                          _removeImage(3);
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          child: SvgPicture.asset('assets/remove-file.svg'),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
    documents.add(object);
  }

}