import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
/* 
sliding-up-panel-page.dart
Панель

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class SlidingUpPanelPage<P extends Widget, B extends Widget>
    extends StatefulWidget {
  P? panel;
  B? body;
  PanelController panelController;
  SlidingUpPanelPage({this.panel, this.body, required this.panelController});
  @override
  State<StatefulWidget> createState() => _SlidingUpPanelPage();
}

class _SlidingUpPanelPage extends State<SlidingUpPanelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        controller: widget.panelController,
        backdropEnabled: true,
        minHeight: 0,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        panel: Container(
          child: widget.panel,
        ),
        body: widget.body,
      ),
    );
  }
}
