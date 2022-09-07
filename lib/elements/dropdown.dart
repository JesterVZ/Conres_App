import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({Key? key, required this.title, required this.items, this.selectedItem})
      : super(key: key);

  final String title;
  final List items;
  final TextEditingController? selectedItem;

  @override
  State<StatefulWidget> createState() => _CustomDropDown();
}

class _CustomDropDown extends State<CustomDropDown> {
  late String valueChoose;
  @override
  void initState() {
    valueChoose = widget.items[0];
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
                //widget.selectedItem!.text = valueChoose;
              });
            },
            items: widget.items.map((valueItem) {
              return DropdownMenuItem(
                  value: valueItem, child: Center(child: Text(valueItem)));
            }).toList()));
  }
}
