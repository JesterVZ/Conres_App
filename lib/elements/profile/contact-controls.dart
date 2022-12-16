import 'package:conres_app/Services/profile-service.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/profile/tabs/new-contact/new-contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../DI/dependency-provider.dart';

class ColtactColtrols extends StatefulWidget {
  bool IsLogin;
  bool IsClaims;
  bool IsTickets;
  String? contactType;
  String contact_id;
  bool isPhone;
  Function? delegateFunction;
  ColtactColtrols(
      {Key? key,
      required this.IsLogin,
      required this.IsClaims,
      required this.IsTickets,
      required this.contact_id,
      required this.isPhone,
      this.delegateFunction,
      this.contactType})
      : assert(contact_id != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => ColtactColtrolsState();
}

class ColtactColtrolsState extends State<ColtactColtrols> {
  ProfileService? profileService;

  bool isLock = true; //может ли пользователь нажимать на switch

  void _sendToastMessage(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: 'Понятно', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double textSize = MediaQuery.of(context).size.width * 0.04;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: widget.isPhone,
            child: Container(
                margin: EdgeInsets.only(bottom: 12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Тип контакта", style: labelTextStyle),
                      Text(widget.contactType ?? "",
                          style: TextStyle(fontSize: 18)),
                    ]))),
        Text("Логин", style: TextStyle(fontSize: 15, color: colorGrayClaim)),
        Container(
          margin: EdgeInsets.only(top: 12, bottom: 12),
          decoration: BoxDecoration(
              color: Color.fromARGB(108, 229, 232, 237),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
          child: Row(
            children: [
              Container(
                child: SvgPicture.asset('assets/lock_profile.svg'),
                margin: EdgeInsets.only(right: 18),
              ),
              Text(
                "Логин",
                style: TextStyle(fontSize: textSize),
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Switch(
                  value: widget.IsLogin,
                  onChanged: (value) {
                    if (!isLock) {
                      setState(() {
                        widget.IsLogin = value;
                      });
                    } else {
                      _sendToastMessage(context,
                          "Чтобы внести изменения разверните настройки  и нажмите кнопку “Изменить”");
                    }
                  })
            ],
          ),
        ),
        Text("Отправка уведомлений",
            style: TextStyle(fontSize: 15, color: colorGrayClaim)),
        Container(
          margin: EdgeInsets.only(top: 12, bottom: 12),
          decoration: BoxDecoration(
              color: Color.fromARGB(108, 229, 232, 237),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
          child: Row(
            children: [
              Container(
                child: SvgPicture.asset('assets/lock_profile.svg'),
                margin: EdgeInsets.only(right: 18),
              ),
              Text(
                "Заявления",
                style: TextStyle(fontSize: textSize),
              ),
              const Spacer(),
              Switch(
                  value: widget.IsClaims,
                  onChanged: (value) {
                    if (!isLock) {
                      setState(() {
                        widget.IsClaims = value;
                      });
                    } else {
                      _sendToastMessage(context,
                          "Чтобы внести изменения разверните настройки  и нажмите кнопку “Изменить”");
                    }
                  })
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 12, bottom: 12),
          decoration: BoxDecoration(
              color: Color.fromARGB(108, 229, 232, 237),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
          child: Row(
            children: [
              Container(
                child: SvgPicture.asset('assets/lock_profile.svg'),
                margin: EdgeInsets.only(right: 18),
              ),
              Text(
                "Обращения",
                style: TextStyle(fontSize: textSize),
              ),
              const Spacer(),
              Switch(
                  value: widget.IsTickets,
                  onChanged: (value) {
                    if (!isLock) {
                      setState(() {
                        widget.IsTickets = value;
                      });
                    } else {
                      _sendToastMessage(context,
                          "Чтобы внести изменения разверните настройки  и нажмите кнопку “Изменить”");
                    }
                  })
            ],
          ),
        ),
        Visibility(
            child: Column(children: [
          Row(
            children: [
              Container(
                  width: (MediaQuery.of(context).size.width / 3) - 5,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      isLock = !isLock;
                      widget.delegateFunction!.call(widget.contact_id);
                    },
                    child:
                        Text("Изменить", style: TextStyle(fontSize: textSize)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorMain,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  )),
              const Spacer(),
              Container(
                  width: (MediaQuery.of(context).size.width / 3) - 5,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewContact()));
                    },
                    child:
                        Text("Добавить", style: TextStyle(fontSize: textSize)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorMain,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ))
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Свернуть",
                    style: TextStyle(fontSize: textSize, color: colorGray)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: messageColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ))
        ])),
        Visibility(
            child: Container(
                margin: EdgeInsets.only(top: 15),
                width: MediaQuery.of(context).size.width,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Отмена",
                      style: TextStyle(fontSize: textSize, color: colorGray)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: messageColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                )))
      ],
    );
  }

  @override
  void didChangeDependencies() {
    profileService ??= DependencyProvider.of(context)!.profileService;

    super.didChangeDependencies();
  }
}
