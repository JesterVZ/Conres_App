import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/model/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../DI/dependency-provider.dart';
import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../consts.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/chat/m-element.dart';
import '../elements/chat/mesage-row.dart';
import '../elements/header/header.dart';

class MessagesPage extends StatefulWidget {
  List<dynamic>? messages;
  MessagesPage({
    required this.messages
});
  @override
  State<StatefulWidget> createState() =>_MessagesPage();
}

class _MessagesPage extends State<MessagesPage>{
  ProfileBloc? profileBloc;
  List<Widget> messagesList = [];
  TextEditingController controller = TextEditingController();
  void _send(){
    setState(() {
      messagesList.add(MessageRow(text: controller.text, isOwn: true));
      controller.text = "";
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocScreen<ProfileBloc, ProfileState>(
          bloc: profileBloc,
          listener: (context, state) => _listener(context, state),
          builder: (context, state) {
              return Scaffold(
                body: Column(
                  children: [
                    Container(
                        height: 100,
                        child: HeaderNotification(text: "Сообщения")
                    ),
                    Expanded(child: Scrollbar(child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                //здесь сообщения
                                Column(
                                  children: messagesList,
                                ),

                              ],
                            )
                          ],
                        )
                    ))),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      child: Padding(
                          padding: EdgeInsets.only(left: 18, right: 18),
                          child: Row(
                            children: [
                              GestureDetector(
                                  child: SvgPicture.asset('assets/clip.svg')
                              ),
                              const Spacer(),
                              Container(
                                width: 245,
                                child: TextField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                      hintText: "Сообщение...",
                                      fillColor: messageColor,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30)
                                      )
                                  ),
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: (){
                                  _send();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(14),
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colorMain,
                                  ),
                                  child: Container(
                                    width: 18,
                                    height: 14,
                                    child: SvgPicture.asset('assets/arrow-type2.svg'),
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                    )
                  ],
                ),
              );
          })
    );

  }
  _listener(BuildContext context, ProfileState state) {

  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    for(int i = 0; i < widget.messages!.length; i++){
      messagesList.add(MessageRow(text: widget.messages![i].message, isOwn: true));
    }

  }
}