import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUpPanelPage<P extends Widget, B extends Widget> extends StatefulWidget{
  P? panel;
  B? body;
  PanelController panelController;
  SlidingUpPanelPage({this.panel, this.body, required this.panelController});
  @override
  State<StatefulWidget> createState() => _SlidingUpPanelPage();
}

class _SlidingUpPanelPage extends State<SlidingUpPanelPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        controller: widget.panelController,
        minHeight: 0,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        panel: Container(
          child: widget.panel,
        ),
        body: widget.body,
      ),
    );
  }
}