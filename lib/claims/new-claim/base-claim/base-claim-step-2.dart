import 'package:conres_app/Services/base-claim-send-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../DI/dependency-provider.dart';
import '../../../UI/main-form.dart';
import '../../../bloc/profile/profile-bloc.dart';
import '../../../bloc/profile/profile-state.dart';
import '../../../consts.dart';
import '../../../elements/bloc/bloc-screen.dart';
import '../../../elements/header/header.dart';

class BaseClaimStep2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BaseClaimStep2();
}

class _BaseClaimStep2 extends State<BaseClaimStep2> {
  BaseClaimSendService? baseClaimSendService; 
  ProfileBloc? profileBloc;

  final _formKey = GlobalKey<FormState>();
  TextEditingController textarea = TextEditingController();
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
            header: HeaderRow(text: claimStep2, fontSize: 24),
            body: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Заявление о необходимости снятия показаний существующего прибора учета",
                            style: TextStyle(color: colorGray, fontSize: 16.0)),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Введите текст!";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.multiline,
                          controller: textarea,
                          maxLines: 4,
                          decoration: InputDecoration(
                              hintText: "Ваше заявление",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: inputBorder, width: 5.0),
                                  borderRadius: BorderRadius.circular(10))),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                        width: MediaQuery.of(context).size.width,
                        height: 55.0,
                        child: ElevatedButton(

                            onPressed: () {
                              baseClaimSendService!.claim_template = "claims/claim_2";
                              baseClaimSendService!.claim_type_id = "3";
                              baseClaimSendService!.claim_type= "ul";
                              baseClaimSendService!.claim_name = "3";
                              baseClaimSendService!.field_content_main = textarea.text;
                              profileBloc!.sendBaseClaim(baseClaimSendService!);
                            },
                            child: Text(
                              "Отправить",
                              style: buttonTextStyle,
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: colorMain))),
                  ],
                ))));
        });
    
  }
  _listener(BuildContext context, ProfileState state) {
    if(state.loading == true){
      return;
    }
  }
  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    baseClaimSendService ??= DependencyProvider.of(context)!.baseClaimSendService;
    super.didChangeDependencies();
  }
}
