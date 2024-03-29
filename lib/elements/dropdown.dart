import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
/* 
dropdown.dart
Кастомный dropdown
TODO deprecated

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class CustomDropDown extends StatefulWidget {
   CustomDropDown(
      {Key? key, required this.title, required this.items, this.selectedItem, this.onClick})
      : super(key: key);

  final String title;
  final List items;
  final TextEditingController? selectedItem;
  Function? onClick;

  @override
  State<StatefulWidget> createState() => _CustomDropDown();
}

class _CustomDropDown extends State<CustomDropDown> {
  late String valueChoose;
  @override
  void initState() {
    valueChoose = widget.items[0];
    widget.selectedItem!.text = valueChoose;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(
              color: borderProfileColor,
            ),
            borderRadius: BorderRadius.circular(8)),
        child: DropdownButton(
            hint: Text(widget.title),
            isExpanded: true,
            underline: const SizedBox(),
            value: valueChoose,
            onChanged: (value) {
              setState(() {
                valueChoose = value.toString();
                widget.selectedItem!.text = valueChoose;
                
                if(widget.onClick != null){
                  widget.onClick!.call(valueChoose);
                }
              });
            },
            items: widget.items.map((valueItem) {
              return DropdownMenuItem(
                  value: valueItem, child: Center(child: Text(valueItem)));
            }).toList()));
  }
}
