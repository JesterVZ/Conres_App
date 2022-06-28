import 'package:conres_app/elements/header/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../DI/dependency-provider.dart';
import '../../bloc/profile/profile-bloc.dart';
import '../../bloc/profile/profile-state.dart';
import '../../consts.dart';
import '../../elements/alert.dart';
import '../../elements/bloc/bloc-screen.dart';
import '../../elements/masks.dart';

class NewLS extends StatefulWidget{
  const NewLS({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewLS();
}

class _NewLS extends State<NewLS>{
  ProfileBloc? profileBloc;
  TextEditingController lsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  void _validate(bool validate){

  }
  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) => _listener(context, state),
    builder: (context, state) {
      return GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            body: Padding(padding: EdgeInsets.fromLTRB(19, 59, 19, 23),
                child:
                Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderRow(text: newLs, fontSize: 24),
                        Container(margin: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                          child: Text(linkNewLs, style: claimTextStyle),),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(numberLS,
                                    style: labelTextStyle),
                                MaskInput(
                                  formatter: MaskTextInputFormatter(
                                                  mask: "#########"),
                                  textController: lsController,
                                  isValidate: _validate,
                                  type: "kpp",
                                  hint: "000000000",
                                )
                              ],
                            )
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(objectAddress,
                                style: labelTextStyle),
                            TextField(
                              controller: addressController,
                              decoration: InputDecoration(
                                  hintText: "Город, Улица, Дом, Квартира",
                                  border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: inputBorder))),
                            )
                          ],
                        ),


                      ],
                    ),
                    Positioned(
                        width: MediaQuery.of(context).size.width - 44,
                        bottom: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: (){
                              profileBloc!.bindNewLS(lsController.text, addressController.text);
                            },
                            child: Text(sendLinkRequest, style: buttonTextStyle),
                            style: ElevatedButton.styleFrom(
                                primary: colorMain,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                )
                            ),
                          ),
                        ))
                  ],
                ))
        ),
      );
    });

  }
  _listener(BuildContext context, ProfileState state){
    if(state.loading == true){
      return;
    }
    if(state.bindLsData != null){
      showDialog(
          context: context,
          builder: (BuildContext context) => Alert(title: "Успешно!", text: state.bindLsData!.code_msg!.msg!));

    }
    if(state.error != null){
      showDialog(
          context: context,
          builder: (BuildContext context) => Alert(title: "Ошибка!", text: state.error.toString()));
    }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
  }
  
}