import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/elements/header/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Services/main-claim-send-service.dart';
import '../../UI/default-input.dart';
import '../../UI/main-form.dart';
import '../../consts.dart';
import '../../elements/claims/claim-step5-object.dart';
import '../../elements/dropdown.dart';
import '../../model/claims/claim-step-5-staging.dart';
import 'new-claim-step-6.dart';

class NewClaimStep5 extends StatefulWidget {
  const NewClaimStep5({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewClaimStep5();
}

class _NewClaimStep5 extends State<NewClaimStep5> {
  final controllerList = List<TextEditingController>.generate(
      5, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  List<ClaimStep5Object> objects = [];
  MainClaimSendService? mainClaimSendService;

  void _addNewObject() {
    setState(() {
      objects.add(ClaimStep5Object(id: objects.length, deleteFunc: _delete));
    });
  }

  void _delete(int id) {
    setState(() {
      objects.removeWhere((element) => element.id == id);
    });
  }

  Future<void> _refrash() async {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MainForm(
            onRefrash: _refrash,
            header: HeaderRow(text: claimStep5, fontSize: 24),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 25, 0, 24),
                              child: Text(
                                  "Сроки проектирования и поэтапного введения в эксплуатацию объекта (в том числе по этапам и очередям), планируемое поэтапное распределение максимальной мощности:",
                                  style: claimTextStyle),
                            ),
                            Container(
                              child: DefaultInput(
                                  controller: controllerList[0],
                                  keyboardType: TextInputType.number,
                                  labelText: "Этап (очередь) строительства",
                                  hintText: "",
                                  validatorText: "Введите серию"),
                            ),
                            Container(
                              child: DefaultInput(
                                  controller: controllerList[1],
                                  keyboardType: TextInputType.number,
                                  labelText:
                                      "Планируемый срок проектирования энергоприниюмающих устройств месяц, год) ",
                                  hintText: "",
                                  validatorText: "Введите серию"),
                            ),
                            Container(
                              child: DefaultInput(
                                  controller: controllerList[2],
                                  keyboardType: TextInputType.number,
                                  labelText:
                                      "Планируемый срок введения энергопринимающих устройств в эксплуатацию(месяц, год) ",
                                  hintText: "",
                                  validatorText: "Введите серию"),
                            ),
                            Container(
                              child: DefaultInput(
                                  controller: controllerList[3],
                                  keyboardType: TextInputType.number,
                                  labelText:
                                      "Максимальная мощность энергопринимаю-щих устройств (кВт)",
                                  hintText: "",
                                  validatorText: "Введите серию"),
                            ),
                            Container(
                              child: DefaultInput(
                                  controller: controllerList[4],
                                  keyboardType: TextInputType.number,
                                  labelText:
                                      "Категория надежности энергопринимаю-щих устройств ",
                                  hintText: "",
                                  validatorText: "Введите серию"),
                            ),
                            Column(
                              children: objects,
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 24, 0, 24),
                                height: 55,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        _addNewObject();
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 10, 0),
                                            child: SvgPicture.asset(
                                                'assets/plus.svg')),
                                        Text(addObject,
                                            style: TextStyle(
                                                color: colorMain, fontSize: 18))
                                      ],
                                    ))),
                            DefaultButton(
                                text: "Далее",
                                onPressed: () {
                                  List<ClaimStep5Staging> tableStagings = [];
                                  tableStagings.add(ClaimStep5Staging(
                                    stage: controllerList[0].text,
                                    projectTerm: controllerList[1].text,
                                    inputTerm: controllerList[2].text,
                                    power: controllerList[3].text,
                                    category: controllerList[4].text,
                                  ));
                                  mainClaimSendService!.step5Stage =
                                      tableStagings;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewClaimStep6()));
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewClaimStep6()));
                                  }
                                },
                                isGetPadding: false)
                          ],
                        ))))));
  }

  @override
  void didChangeDependencies() {
    mainClaimSendService ??=
        DependencyProvider.of(context)!.mainClaimSendService;
    super.didChangeDependencies();
  }
}
