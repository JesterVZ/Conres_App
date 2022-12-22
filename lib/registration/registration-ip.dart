import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/elements/registration/sliding-up.dart';
import 'package:conres_app/model/model.dart';
import 'package:conres_app/registration/privacy-policy.dart';
import 'package:conres_app/registration/validate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../DI/dependency-provider.dart';
import '../UI/default-input.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/header/header.dart';
import '../elements/masks.dart';
import '../elements/registration/password-textfield.dart';
import '../elements/route/def-page-router.dart';
import '../login/change-type.dart';
import '../validation/validation.dart';

class RegIP extends StatefulWidget {
  RegIP({Key? key}) : super(key: key);
  bool isLoading = false;

  @override
  State<StatefulWidget> createState() => _RegIP();
}

class _RegIP extends State<RegIP> {
  final controllerList = List<TextEditingController>.generate(
      //список контроллеров основных полей
      9,
      (index) => TextEditingController());
  final controllerDlList = List<TextEditingController>.generate(
      //список контроллеров полей ДЛ
      5,
      (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  late bool _agree = false; //согласен ли
  late bool _visabillity = false; //показать/скрыть ДЛ
  bool _isEmailValidation = false;
  bool _isEmailDlValidation = false;
  PanelController panelController = PanelController();
  AuthBloc? authBloc;

  void _addNewConfidant() {
    _visabillity = !_visabillity;
  }

  void _push() {
    Navigator.push(context, DefaultPageRouter(const ChangeType(isReg: false)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocScreen<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                body: SlidingUpElement(
                  onClose: _push,
                  panelController: panelController,
                  body: Scaffold(
                    backgroundColor: Colors.white,
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                defaultSidePadding, 70, defaultSidePadding, 54),
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    HeaderRow(
                                        text: "Регистрация ИП", fontSize: 34),
                                    DefaultInput(
                                        labelText: "Фамилия руководителя",
                                        keyboardType: TextInputType.text,
                                        controller: controllerList[0],
                                        hintText: "Иванов",
                                        validatorText:
                                            "Введите фамилию руководителя"),
                                    DefaultInput(
                                        labelText: "Имя руководителя",
                                        keyboardType: TextInputType.text,
                                        controller: controllerList[1],
                                        hintText: "Иван",
                                        validatorText:
                                            "Введите имя руководителя"),
                                    DefaultInput(
                                        labelText: "Отчество руководителя",
                                        keyboardType: TextInputType.text,
                                        controller: controllerList[2],
                                        hintText: "Иванович",
                                        validatorText:
                                            "Введите отчество руководителя"),
                                    DefaultInput(
                                        labelText: "ИНН",
                                        keyboardType: TextInputType.number,
                                        controller: controllerList[3],
                                        hintText: "000000000000",
                                        validatorText: "Введите ИНН",
                                        textInputFormatter:
                                            MaskTextInputFormatter(
                                                mask: "############"),
                                        regExp: r'[0-9]{12}$'),
                                    DefaultInput(
                                        labelText: "ОГРНИП",
                                        keyboardType: TextInputType.number,
                                        controller: controllerList[4],
                                        hintText: "000000000000000",
                                        validatorText: "Введите ОГРНИП",
                                        textInputFormatter:
                                            MaskTextInputFormatter(
                                                mask: "###############"),
                                        regExp: r'[0-9]{15}$'),
                                    DefaultInput(
                                        labelText: "Телефон",
                                        keyboardType: TextInputType.phone,
                                        controller: controllerList[5],
                                        hintText: "+7 (___) - ___ - __ - __",
                                        validatorText: "Введите телефон",
                                        textInputFormatter:
                                            MaskTextInputFormatter(
                                                mask: "+7 (###) ###-##-##"),
                                        regExp:
                                            r'^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$'),
                                    DefaultInput(
                                        labelText: "Email",
                                        keyboardType: TextInputType.emailAddress,
                                        controller: controllerList[6],
                                        hintText: "example@email.ru",
                                        validatorText: "Введите телефон",
                                        regExp:
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'),
                                    Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 18),
                                        child: Column(
                                          children: [
                                            Container(
                                                height: 55,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.white),
                                                    onPressed: () {
                                                      setState(() {
                                                        _addNewConfidant();
                                                      });
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0,
                                                                    0,
                                                                    10,
                                                                    0),
                                                            child: _visabillity
                                                                ? SvgPicture.asset(
                                                                    'assets/minus.svg')
                                                                : SvgPicture.asset(
                                                                    'assets/plus.svg')),
                                                        Text(confidant,
                                                            style: TextStyle(
                                                                color:
                                                                    colorMain,
                                                                fontSize: 18))
                                                      ],
                                                    ))),
                                            Visibility(
                                                visible: _visabillity,
                                                child: Column(
                                                  children: [
                                                    DefaultInput(
                                                        labelText: "Фамилия ДЛ",
                                                        keyboardType:
                                                            TextInputType.text,
                                                        controller:
                                                            controllerDlList[0],
                                                        hintText: "Иванов",
                                                        validatorText:
                                                            "Введите фамилию доверенного лица"),
                                                    DefaultInput(
                                                        labelText: "Имя ДЛ",
                                                        keyboardType:
                                                            TextInputType.text,
                                                        controller:
                                                            controllerDlList[1],
                                                        hintText: "Иванов",
                                                        validatorText:
                                                            "Введите имя доверенного лица"),
                                                    DefaultInput(
                                                        labelText:
                                                            "Отчество ДЛ",
                                                        keyboardType:
                                                            TextInputType.text,
                                                        controller:
                                                            controllerDlList[2],
                                                        hintText: "Иванов",
                                                        validatorText:
                                                            "Введите отчество доверенного лица"),
                                                    DefaultInput(
                                                        labelText: "Телефон",
                                                        keyboardType:
                                                            TextInputType.phone,
                                                        controller:
                                                            controllerDlList[3],
                                                        hintText:
                                                            "+7 (___) - ___ - __ - __",
                                                        validatorText:
                                                            "Введите телефон",
                                                        textInputFormatter:
                                                            MaskTextInputFormatter(
                                                                mask:
                                                                    "+7 (###) ###-##-##"),
                                                        regExp:
                                                            r'^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$'),
                                                    DefaultInput(
                                                        labelText: "Email",
                                                        keyboardType:
                                                            TextInputType.phone,
                                                        controller:
                                                            controllerDlList[4],
                                                        hintText:
                                                            "example@email.ru",
                                                        validatorText:
                                                            "Введите телефон",
                                                        regExp:
                                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'),
                                                    Container(
                                                      height: 6,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: colorMain),
                                                    )
                                                  ],
                                                ))
                                          ],
                                        )),
                                    DefaultInput(
                                        labelText: "Пароль",
                                        keyboardType: TextInputType.text,
                                        controller: controllerList[7],
                                        hintText: "*********",
                                        validatorText: "Введите пароль"),
                                    DefaultInput(
                                        labelText: "Повторите пароль",
                                        keyboardType: TextInputType.text,
                                        controller: controllerList[8],
                                        hintText: "*********",
                                        validatorText: "Повторите пароль"),
                                    Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 18),
                                        child: CheckboxListTile(
                                          activeColor: colorMain,
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                            title: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text:
                                                        "Я согласен на обработку ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black)),
                                                TextSpan(
                                                    text: "персональных данных",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.blue,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        PrivacyPolicy(
                                                                            func:
                                                                                checkAgree)));
                                                          })
                                              ]),
                                            ),
                                            value: _agree,
                                            onChanged: (value) {
                                              setState(() {
                                                _agree = !_agree;
                                              });
                                            })),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 55,
                                      child: ElevatedButton(
                                          onPressed: _agree
                                              ? () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    submitData();
                                                  }
                                                }
                                              : null,
                                          child: Text(
                                            "Зарегистрироваться",
                                            style: buttonTextStyle,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: colorMain)),
                                    ),
                                    Visibility(
                                        visible: widget.isLoading,
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          child:
                                              Image.asset('assets/loading.gif'),
                                        ))
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  panel: Center(
                      child: Padding(
                    padding: EdgeInsets.fromLTRB(27, 36, 27, 36),
                    child: Container(
                      margin: EdgeInsets.only(top: 36),
                      child: Column(
                        children: [
                          const Text("Регистрация прошла успешно!",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("Ваш логин и пароль отправлен\nВам на почту.",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: profileLabelColor)),
                          Image.asset('assets/mail.png'),
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                _push();
                              },
                              child: Text("Далее"),
                              style:
                                  ElevatedButton.styleFrom(primary: colorMain),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
                ),
              ));
        });
  }

  void checkAgree(bool value) {
    setState(() {
      _agree = value;
    });
  }

  void submitData() {
    Dl dl = Dl(
        Family: controllerDlList[0].text,
        Name: controllerDlList[1].text,
        Patronymic: controllerDlList[2].text,
        TelDL: controllerDlList[3].text,
        EmailDL: controllerDlList[4].text);

    Ip ipObj = Ip(
        Family: controllerList[0].text,
        Name: controllerList[1].text,
        Patronymic: controllerList[2].text,
        inn: controllerList[3].text,
        ogrnip: controllerList[4].text,
        tel: controllerList[5].text,
        email: controllerList[6].text,
        Password: controllerList[7].text,
        RepeatPassword: controllerList[8].text,
        dl: dl,
        User_lk_type_id: '');
    _handleRegistration(ipObj);
  }

  _handleRegistration(Object sender) {
    authBloc!.register(sender, 2);
  }

  _listener(BuildContext context, AuthState state) {
    if (state.loading!) {
      widget.isLoading = true;
      return;
    } else {
      widget.isLoading = false;
    }
    if (state.error == null) {
      panelController.open();
    } else {
      if (state.error is Map<dynamic, dynamic>) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          headerAnimationLoop: false,
          title: "Ошибка!",
          btnOkColor: Colors.red,
          desc: (validate((state.error as Map<dynamic, dynamic>).values.first)),
          btnOkOnPress: () {},
        ).show();
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc ??= DependencyProvider.of(context)!.authBloc;
  }
}
