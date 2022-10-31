import 'package:conres_app/Services/base-claim-send-service.dart';
import 'package:conres_app/claims/claims.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../DI/dependency-provider.dart';
import '../../../UI/main-form.dart';
import '../../../bloc/profile/profile-bloc.dart';
import '../../../bloc/profile/profile-state.dart';
import '../../../consts.dart';
import '../../../elements/alert.dart';
import '../../../elements/bloc/bloc-screen.dart';
import '../../../elements/claims/file-element.dart';
import '../../../elements/header/header.dart';

class BaseClaimStep2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BaseClaimStep2();
}

class _BaseClaimStep2 extends State<BaseClaimStep2> {
  BaseClaimSendService? baseClaimSendService;
  ProfileBloc? profileBloc;
  bool isLoading = false;

  bool isSent = false; //отправлено ли

  final _formKey = GlobalKey<FormState>();
  TextEditingController textarea = TextEditingController();

  Future<void> _refrash() async {}
  Map<int?, FilePickerResult?> imagesMap = {0: null, 1: null};
  void _pickDocument(int id, FilePickerResult? result) {
    setState(() {
      imagesMap.update(id, (value) => result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: MainForm(
                  onRefrash: _refrash,
                  header: HeaderRow(text: claimStep2, fontSize: 24),
                  body: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: defaultSidePadding,
                              right: defaultSidePadding),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Заявление о необходимости снятия показаний существующего прибора учета",
                                          style: TextStyle(
                                              color: colorGray,
                                              fontSize: 16.0)),
                                      TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Введите текст!";
                                          }
                                          return null;
                                        },
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        keyboardType: TextInputType.multiline,
                                        controller: textarea,
                                        maxLines: 4,
                                        decoration: InputDecoration(
                                            hintText: "Ваше заявление",
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: inputBorder,
                                                    width: 5.0),
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 13),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("Приложение",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: colorGray, fontSize: 16.0)),
                                  ),
                                  DocElement(id: 0, result: _pickDocument),
                                  Container(
                                    margin: EdgeInsets.only(top: 13),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("Приложение",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: colorGray, fontSize: 16.0)),
                                  ),
                                  DocElement(id: 1, result: _pickDocument),
                                  Container(
                                      margin: EdgeInsets.only(top: 12),
                                      width: MediaQuery.of(context).size.width,
                                      height: 55.0,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            baseClaimSendService!
                                                    .claim_template =
                                                "claims/claim_2";
                                            baseClaimSendService!
                                                .claim_type_id = "3";
                                            baseClaimSendService!.claim_type =
                                                "ul";
                                            baseClaimSendService!.claim_name =
                                                "3";
                                            baseClaimSendService!
                                                    .field_content_main =
                                                textarea.text;
                                            baseClaimSendService!.files =
                                                imagesMap;
                                            profileBloc!.sendBaseClaim(
                                                baseClaimSendService!);
                                            isSent = true;
                                          },
                                          child: Text(
                                            "Отправить",
                                            style: buttonTextStyle,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: colorMain))),
                                ],
                              ))))));
        });
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      isLoading = true;
      return;
    }
    if (state.loading == false && state.error == null && isSent == true) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              Alert(title: "Успешно!", text: "Заявление успешно отправлено!"));
      isSent = false;
      baseClaimSendService!.delegateFunc!.call();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else if (state.loading == false && state.error != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              Alert(title: "Ошибка!!", text: "Ошибка отправки заявления!"));
    }
  }

  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    baseClaimSendService ??=
        DependencyProvider.of(context)!.baseClaimSendService;
    super.didChangeDependencies();
  }
}
