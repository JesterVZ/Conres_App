import 'package:conres_app/elements/bloc/bloc-screen.dart';
import 'package:conres_app/registration/privacy-policy.dart';
import 'package:conres_app/registration/seccessful-registration.dart';
import 'package:conres_app/registration/validate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../consts.dart';
import '../elements/alert.dart';
import '../elements/header/header.dart';
import '../elements/masks.dart';
import '../elements/registration/password-textfield.dart';
import '../elements/registration/sliding-up.dart';
import '../login/change-type.dart';
import '../model/model.dart';
import '../validation/validation.dart';

class RegFL extends StatefulWidget {
  RegFL({Key? key}) : super(key: key);
  bool isLoading = false;

  @override
  State<StatefulWidget> createState() => _RegFL();
}

class _RegFL extends State<RegFL> {
  final controllerList = List<TextEditingController>.generate(
      9, (index) => TextEditingController());
  bool _agree = false;
  bool _isEmailValidation = false;
  PanelController panelController = PanelController();
  AuthBloc? authBloc;
  final _formKey = GlobalKey<FormState>();

  void _push() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ChangeType(isReg: false)));
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
                body: SlidingUpElement(
                  onClose: _push,
                  panelController: panelController,
                  body: Scaffold(
                    body: SingleChildScrollView(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(21, 74, 21, 54),
                                  child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          HeaderRow(
                                              text:
                                                  "Регистрация физического лица",
                                              fontSize: 34),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 38, 0, 18),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(family,
                                                      style: TextStyle(
                                                          color: colorGray,
                                                          fontSize: 16.0)),
                                                  TextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Введите имя";
                                                      }
                                                      return null;
                                                    },
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    controller:
                                                        controllerList[0],
                                                    decoration: InputDecoration(
                                                        hintText: "Иванов",
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    inputBorder,
                                                                width: 5.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                  )
                                                ],
                                              )),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 18),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(name,
                                                      style: TextStyle(
                                                          color: colorGray,
                                                          fontSize: 16.0)),
                                                  TextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Введите фамилию";
                                                      }
                                                      return null;
                                                    },
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    controller:
                                                        controllerList[1],
                                                    decoration: InputDecoration(
                                                        hintText: "Иван",
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    inputBorder,
                                                                width: 5.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                  )
                                                ],
                                              )),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 18),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(patronymic,
                                                      style: TextStyle(
                                                          color: colorGray,
                                                          fontSize: 16.0)),
                                                  TextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Введите отчество";
                                                      }
                                                      return null;
                                                    },
                                                    controller:
                                                        controllerList[2],
                                                    decoration: InputDecoration(
                                                        hintText: "Иванович",
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    inputBorder,
                                                                width: 5.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                  )
                                                ],
                                              )),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 18),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(inn,
                                                      style: TextStyle(
                                                          color: colorGray,
                                                          fontSize: 16.0)),
                                                  MaskInput(
                                                    textController:
                                                        controllerList[3],
                                                    formatter:
                                                        MaskTextInputFormatter(
                                                            mask:
                                                                "############"),
                                                    hint: "000000000000",
                                                    type: "inn",
                                                  )
                                                ],
                                              )),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 18),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(snils,
                                                      style: TextStyle(
                                                          color: colorGray,
                                                          fontSize: 16.0)),
                                                  MaskInput(
                                                    textController:
                                                        controllerList[4],
                                                    formatter:
                                                        MaskTextInputFormatter(
                                                            mask:
                                                                "###-###-###-##"),
                                                    hint: "000-000-000-00",
                                                    type: "snils",
                                                  )
                                                ],
                                              )),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 18),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(contacts,
                                                      style: TextStyle(
                                                          color: colorGray,
                                                          fontSize: 16.0)),
                                                  MaskInput(
                                                    textController:
                                                        controllerList[5],
                                                    formatter:
                                                        MaskTextInputFormatter(
                                                            mask:
                                                                "+7 (###) ###-##-##"),
                                                    hint:
                                                        "+7 (___) - ___ - __ - __",
                                                    type: "phone",
                                                  ),
                                                ],
                                              )),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 18),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(email,
                                                      style: TextStyle(
                                                          color: colorGray,
                                                          fontSize: 16.0)),
                                                  TextFormField(
                                                    style: TextStyle(
                                                        color:
                                                            _isEmailValidation
                                                                ? Colors.green
                                                                : Colors.red),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Введите Email";
                                                      } else if (_isEmailValidation ==
                                                          false) {
                                                        return "Email некорректен";
                                                      }
                                                      return null;
                                                    },
                                                    controller:
                                                        controllerList[6],
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "example@email.ru",
                                                        border:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color:
                                                                      borderProfileColor,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: _isEmailValidation
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .red))),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _isEmailValidation =
                                                            isEmailValidate(
                                                                value);
                                                      });
                                                    },
                                                  )
                                                ],
                                              )),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 18),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(lkPasswordText,
                                                      style: TextStyle(
                                                          color: colorGray,
                                                          fontSize: 16.0)),
                                                  PasswordTextField(
                                                    controller:
                                                        controllerList[7],
                                                    hintText: "Введите пароль",
                                                  )
                                                ],
                                              )),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 18),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(repeatPassword,
                                                      style: TextStyle(
                                                          color: colorGray,
                                                          fontSize: 16.0)),
                                                  PasswordTextField(
                                                    controller:
                                                        controllerList[8],
                                                    hintText:
                                                        "Повторите пароль",
                                                  )
                                                ],
                                              )),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 18),
                                              child: CheckboxListTile(
                                                  title: RichText(
                                                      text: TextSpan(children: [
                                                    TextSpan(
                                                        text:
                                                            "Я согласен на обработку ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black)),
                                                    TextSpan(
                                                        text:
                                                            "персональных данных",
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
                                                                        builder:
                                                                            (context) =>
                                                                                PrivacyPolicy(func: checkAgree)));
                                                              })
                                                  ])),
                                                  value: _agree,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _agree = !_agree;
                                                    });
                                                  })),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 55,
                                            child: ElevatedButton(
                                                onPressed: (_agree)
                                                    ? () {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          submitData(state);
                                                        }
                                                      }
                                                    : null,
                                                child: Text(
                                                    "Зарегистрироваться",
                                                    style: buttonTextStyle),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        colorMain)),
                                          ),
                                          Visibility(
                                              visible: widget.isLoading,
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                child: Image.asset(
                                                    'assets/loading.gif'),
                                              ))
                                        ],
                                      )))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  panel: Center(
                      child: Padding(
                    padding: EdgeInsets.fromLTRB(27, 20, 27, 36),
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
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colorMain),
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

  void submitData(AuthState state) {
    Fl flObj = Fl(
        Family: controllerList[0].text,
        Name: controllerList[1].text,
        Patronymic: controllerList[2].text,
        Password: controllerList[7].text,
        RepeatPassword: controllerList[8].text,
        Inn: controllerList[3].text,
        Snils: controllerList[4].text,
        Email: controllerList[6].text,
        Tel: controllerList[5].text,
        User_lk_type_id: '1');
    _handleRegistration(state, flObj);
  }

  _handleRegistration(AuthState state, Object sender) {
    if (controllerList[0].text == "" ||
        controllerList[1].text == "" ||
        controllerList[2].text == "" ||
        controllerList[3].text == "" ||
        controllerList[4].text == "" ||
        controllerList[5].text == "" ||
        controllerList[6].text == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              Alert(title: "Ошибка", text: "Заполните все поля"));
      return;
    } else {
      authBloc!.register(sender, 1);
    }
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
      //Navigator.push(context, MaterialPageRoute(builder: (context) => const RegSuccess()));
    } else {
      if (state.error is Map<dynamic, dynamic>) {
        showDialog(
            context: context,
            builder: (BuildContext context) => Alert(
                title: "Ошибка!",
                text: validate(
                    (state.error as Map<dynamic, dynamic>).values.first)));
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc ??= DependencyProvider.of(context)!.authBloc;
  }
}
