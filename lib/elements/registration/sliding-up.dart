import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUpElement extends StatelessWidget{
  PanelController panelController;
  Widget body;
  Widget panel;
  VoidCallback? onClose;

  SlidingUpElement({required this.panelController, required this.body, required this.panel, this.onClose});

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      onPanelClosed: onClose,
      minHeight: 0,
      maxHeight: 400,
      backdropEnabled: true,
      controller: panelController,
      panel: panel,
      body: body,
      collapsed: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
      ),
    );
  }
}
