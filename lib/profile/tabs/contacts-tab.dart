import 'package:accordion/accordion.dart';
import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../elements/full-profile/ExpansionTileElement.dart';


class ContactsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContactsTab();
}

class _ContactsTab extends State<ContactsTab> {
  bool canLogin = false;
  bool claimNotification = false;
  bool ticketNotification = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Телефоны",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    ExpansionTileElement(),
                    /*
                    const Text("E-mail",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    ContactBlock(),
                    const Text("Мессенджеры",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    ContactBlock(),
                    */
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
