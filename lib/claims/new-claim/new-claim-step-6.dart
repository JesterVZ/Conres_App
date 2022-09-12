import 'dart:io';
import 'dart:ui';
import 'package:conres_app/elements/header/header.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../UI/default-input.dart';
import '../../UI/main-form.dart';
import '../../consts.dart';
import '../../elements/registration/sliding-up.dart';

class NewClaimStep6 extends StatefulWidget {
  const NewClaimStep6({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewClaimStep6();
}

class _NewClaimStep6 extends State<NewClaimStep6> {
  List<FilePickerResult> images = [];
  List<Widget> documents = [];
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String?, FilePickerResult?> imagesMap = {"1": null, "2": null, "3": null};
  PanelController panelController = PanelController();
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          body: SlidingUpPanel(
            maxHeight: 250,
            minHeight: 0,
            controller: panelController,
            collapsed: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
              ),
            ),
            body: MainForm(
            header: HeaderRow(text: claimStep6, fontSize: 24),
            body: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 25, 0, 24),
                      child: Text(
                          "Укажите гарантирующего поставщика и тип договора",
                          style: claimTextStyle),
                    ),
                    Container(
                      child: DefaultInput(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          labelText: "Наименование Гарантирующего Поставщика",
                          hintText: "ООО Светлячок",
                          validatorText: "Введите поставщика"),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Тип договора:"),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            child: ElevatedButton(
                            onPressed: (){
                              panelController.open();
                            }, 
                            style: ElevatedButton.styleFrom(
                              backgroundColor: messageColor,
                            ),
                            child: Text("Выберите договор", style: TextStyle(color: colorMain, fontSize: 18),))
                          )
                          
                        ],
                      ),
                    )
                  ],
                ))),
            panel: Column(
              children: [
                Container(
                  height: 78,
                  alignment: Alignment.center,
                  child: Text("Выберите договор", style: TextStyle(fontSize: 20)),
                ),
                
                const Divider(),
                GestureDetector(
                  child: Container(
                    height: 40,
                    child: Text("Договор электроснабжения"),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 40,
                    child: Text("Договор купли-продажи"),
                  ),
                ),
              ],
            ),
          )
        )
        );
  }
}
