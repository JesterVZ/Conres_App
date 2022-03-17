import 'package:conres_app/elements/bloc-screen.dart';
import 'package:conres_app/registration/seccessful-registration.dart';
import 'package:conres_app/registration/validate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../consts.dart';
import '../elements/alert.dart';
import '../elements/header.dart';
import '../elements/masks.dart';
import '../model/model.dart';

class RegFL extends StatefulWidget {

  RegFL({Key? key}) : super(key: key);
  bool isLoading = false;

  @override
  State<StatefulWidget> createState() => _RegFL();
}

class _RegFL extends State<RegFL> {
  final controllerList = List<TextEditingController>.generate(
      9, (index) => TextEditingController());
  late bool _agree = false;
  AuthBloc? authBloc;

  final Widget svg = SvgPicture.asset('assets/background_image.svg',
      color: colorLogo, semanticsLabel: 'Acme Logo');

  @override
  Widget build(BuildContext context) {
    return BlocScreen<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return GestureDetector(
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(21, 70, 21, 54),
                        child: Column(
                          children: [
                            HeaderRow(regTitle, 34, false),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 38, 0, 18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(family,
                                        style: TextStyle(
                                            color: colorGray, fontSize: 16.0)),
                                    TextField(
                                      controller: controllerList[0],
                                      decoration: InputDecoration(
                                          hintText: "Иванов",
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: inputBorder))),
                                    )
                                  ],
                                )),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(name,
                                        style: TextStyle(
                                            color: colorGray, fontSize: 16.0)),
                                    TextField(
                                      controller: controllerList[1],
                                      decoration: InputDecoration(
                                          hintText: "Иван",
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: inputBorder))),
                                    )
                                  ],
                                )),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(patronymic,
                                        style: TextStyle(
                                            color: colorGray, fontSize: 16.0)),
                                    TextField(
                                      controller: controllerList[2],
                                      decoration: InputDecoration(
                                          hintText: "Иванович",
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: inputBorder))),
                                    )
                                  ],
                                )),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(inn,
                                        style: TextStyle(
                                            color: colorGray, fontSize: 16.0)),
                                    MaskInput(
                                      textController: controllerList[3],
                                      formatter: MaskTextInputFormatter(
                                          mask: "############"),
                                      hint: "000000000000",
                                    )
                                  ],
                                )),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snils,
                                        style: TextStyle(
                                            color: colorGray, fontSize: 16.0)),
                                    MaskInput(
                                      textController: controllerList[4],
                                      formatter: MaskTextInputFormatter(
                                          mask: "###-###-###-##"),
                                      hint: "000-000-000-00",
                                    )
                                  ],
                                )),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(contacts,
                                        style: TextStyle(
                                            color: colorGray, fontSize: 16.0)),
                                    MaskInput(
                                      textController: controllerList[5],
                                      formatter: MaskTextInputFormatter(
                                          mask: "+7 (###) ###-##-##"),
                                      hint: "+7 (___) - ___ - __ - __",
                                    ),
                                  ],
                                )),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(email,
                                        style: TextStyle(
                                            color: colorGray, fontSize: 16.0)),
                                    TextField(
                                      controller: controllerList[6],
                                      decoration: InputDecoration(
                                          hintText: "example@email.ru",
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: inputBorder))),
                                    )
                                  ],
                                )),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(lkPasswordText,
                                        style: TextStyle(
                                            color: colorGray, fontSize: 16.0)),
                                    TextField(
                                      controller: controllerList[7],
                                      autofocus: false,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          hintText: "Ваш пароль",
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: inputBorder))),
                                    )
                                  ],
                                )),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(repeatPassword,
                                        style: TextStyle(
                                            color: colorGray, fontSize: 16.0)),
                                    TextField(
                                      controller: controllerList[8],
                                      autofocus: false,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          hintText: "Повторите пароль",
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: inputBorder))),
                                    )
                                  ],
                                )),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                              child: CheckboxListTile(title: const Text(
                                  "Я согласен на обработку персональных данных",
                                  style: TextStyle(fontSize: 15)), value: _agree, onChanged: (value) {
                                setState(() {
                                  _agree = !_agree;
                                });
                              })
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 55,
                              child: ElevatedButton(
                                  onPressed: _agree ? () => submitData(state) : null,
                                  child: Text(login, style: buttonTextStyle),
                                  style: ElevatedButton.styleFrom(
                                      primary: colorMain)),
                            ),
                            Visibility(
                                visible: widget.isLoading,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  child: Image.asset('assets/loading.gif'),
                                ))
                          ],
                        ))
                  ],
                ),
              ),
            )
          );
        });

  }
  void submitData(AuthState state){
    Fl flObj = Fl(
        Family: controllerList[0].text,
        Name: controllerList[1].text,
        Patronymic: controllerList[2].text,
        Password: controllerList[7].text,
        RepeatPassword: controllerList[8].text,
        Inn: controllerList[3].text,
        Snils: controllerList[4].text,
        Email: controllerList[6].text,
        Tel: controllerList[5].text, User_lk_type_id: '1');
    _handleRegistration(state, flObj);
  }
  _handleRegistration(AuthState state, Object sender) {
    if(controllerList[0].text == ""
        || controllerList[1].text == ""
        || controllerList[2].text == ""
        || controllerList[3].text == ""
        || controllerList[4].text == ""
        || controllerList[5].text == ""
        || controllerList[6].text == ""){
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              Alert(title: "Ошибка", text: "Заполните все поля"));
      return;
    } else{
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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const RegSuccess()));
    } else {
      if (state.error is Map<dynamic, dynamic>) {
        showDialog(
            context: context,
            builder: (BuildContext context) => Alert(
                title: (state.error as Map<dynamic, dynamic>).keys.first,
                text: validate((state.error as Map<dynamic, dynamic>).values.first)));
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc ??= DependencyProvider.of(context)!.authBloc;
  }
}
