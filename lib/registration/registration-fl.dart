import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conres_app/UI/default-button.dart';
import 'package:conres_app/UI/default-input.dart';
import 'package:conres_app/elements/bloc/bloc-screen.dart';
import 'package:conres_app/registration/privacy-policy.dart';
import 'package:conres_app/registration/validate.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
import '../elements/route/def-page-router.dart';
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
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      defaultSidePadding,
                                      74,
                                      defaultSidePadding,
                                      54),
                                  child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          HeaderRow(
                                              text:
                                                  "Регистрация физического лица",
                                              fontSize: 34),
                                          DefaultInput(
                                              labelText: "Фамилия",
                                              keyboardType: TextInputType.text,
                                              controller: controllerList[0],
                                              hintText: "Иванов",
                                              validatorText: "Введите фамилию"),
                                          DefaultInput(
                                              labelText: "Имя",
                                              keyboardType: TextInputType.text,
                                              controller: controllerList[1],
                                              hintText: "Иван",
                                              validatorText: "Введите имя"),
                                          DefaultInput(
                                              labelText: "Отчество",
                                              keyboardType: TextInputType.text,
                                              controller: controllerList[2],
                                              hintText: "Иванович",
                                              validatorText:
                                                  "Введите отчество"),
                                          DefaultInput(
                                              labelText: "ИНН",
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: controllerList[3],
                                              hintText: "000000000000",
                                              validatorText: "Введите инн",
                                              textInputFormatter:
                                                  MaskTextInputFormatter(
                                                      mask: "############"),
                                              regExp: r'[0-9]{12}$'),
                                          DefaultInput(
                                              labelText: "СНИЛС",
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: controllerList[4],
                                              hintText: "000-000-000-00",
                                              validatorText: "Введите СНИЛС",
                                              textInputFormatter:
                                                  MaskTextInputFormatter(
                                                      mask: "###-###-###-##"),
                                              regExp:
                                                  r'^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$'),
                                          DefaultInput(
                                              labelText: "Телефон",
                                              keyboardType: TextInputType.phone,
                                              controller: controllerList[5],
                                              hintText:
                                                  "+7 (___) - ___ - __ - __",
                                              validatorText: "Введите телефон",
                                              textInputFormatter:
                                                  MaskTextInputFormatter(
                                                      mask:
                                                          "+7 (###) ###-##-##"),
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
                                          DefaultInput(
                                              labelText: "Пароль",
                                              keyboardType: TextInputType.text,
                                              obscureText: true,
                                              controller: controllerList[7],
                                              hintText: "*********",
                                              validatorText: "Введите пароль"),
                                          DefaultInput(
                                              labelText: "Повторите пароль",
                                              keyboardType: TextInputType.text,
                                              obscureText: true,
                                              controller: controllerList[8],
                                              hintText: "*********",
                                              validatorText:
                                                  "Повторите пароль"),
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
                                          DefaultButton(
                                              text: "Зарегистрироваться",
                                              onPressed: (_agree)
                                                  ? () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        submitData(state);
                                                      }
                                                    }
                                                  : null,
                                              isGetPadding: false),
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
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        title: "Ошибка!",
        btnOkColor: Colors.red,
        desc: "Заполните все поля",
        btnOkOnPress: () {},
      ).show();

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
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          headerAnimationLoop: false,
          title: "Ошибка!",
          btnOkColor: Colors.red,
          desc: validate((state.error as Map<dynamic, dynamic>).values.first),
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
