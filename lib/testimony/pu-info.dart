import 'package:conres_app/UI/main-form.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:flutter/cupertino.dart';

class PuFullInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PuFullInfo();
}

class _PuFullInfo extends State<PuFullInfo> {
  @override
  Widget build(BuildContext context) {
    return MainForm(
        onRefrash: _refrash,
        header: HeaderNotification(text: "Информация о ПУ", canGoBack: true),
        body: Column(
          children: [],
        ));
  }

  Future<void> _refrash() async {}
}
