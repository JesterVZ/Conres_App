import 'package:conres_app/Services/profile-service.dart';
import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../DI/dependency-provider.dart';

class ColtactColtrols extends StatefulWidget {
  bool IsLogin;
  bool IsClaims;
  bool IsTickets;
  ColtactColtrols({required this.IsLogin, required this.IsClaims, required this.IsTickets});


  @override
  State<StatefulWidget> createState() => _ColtactColtrols();
}

class _ColtactColtrols extends State<ColtactColtrols> {
  ProfileService? profileService;
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              const Text(
                "Вход в качестве логина",
                style: TextStyle(fontSize: 16),
              ),
              const Spacer(),
              Switch(
                  value: widget.IsLogin,
                  onChanged: (value) {
                    setState(() {
                      widget.IsLogin = value;
                    });
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
              const Text(
                "Заявления",
                style: TextStyle(fontSize: 16),
              ),
              const Spacer(),
              Switch(
                  value: widget.IsClaims,
                  onChanged: (value) {
                    setState(() {
                      widget.IsClaims = value;
                    });
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
              const Text(
                "Обращения",
                style: TextStyle(fontSize: 16),
              ),
              const Spacer(),
              Switch(
                  value: widget.IsTickets,
                  onChanged: (value) {
                    setState(() {
                      widget.IsTickets = value;
                    });
                  })
            ],
          ),
        ),
        Row(
          children: [
            Container(
                width: 142,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Изменить", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colorMain,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                )),
            const Spacer(),
            Container(
                width: 142,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Добавить", style: TextStyle(fontSize: 18)),
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
                  style: TextStyle(fontSize: 18, color: colorGray)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: messageColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ))
      ],
    );
  }
  @override
  void didChangeDependencies() {
    profileService ??= DependencyProvider.of(context)!.profileService;

    super.didChangeDependencies();
  }
}
