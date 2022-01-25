import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupModel {
  String text;
  int index;
  bool selected;

  GroupModel({required this.text, required this.index, required this.selected});
}

class CustomRadio extends StatefulWidget {
  const CustomRadio({Key? key}) : super(key: key);

  @override
  _CustomRadio createState() => _CustomRadio();
}

class _CustomRadio extends State<CustomRadio>{
  List<GroupModel> _group = [
    GroupModel(text: "Andorid", index: 1, selected: true),
    GroupModel(text: "IOS", index: 2, selected: false),
    GroupModel(text: "Flutter", index: 3, selected: false),
  ];
  @override
  void initState() {

  }

  Widget makeRadioTiles(){
    late List<Widget> list;
    for(int i = 0; i < _group.length; i++){
      list.add(Container(margin: const EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: _group[i].selected ? Colors.purple : Colors.green,
            borderRadius: BorderRadius.all(
                Radius.circular(10.0) //         <--- border radius here
            )),
      child: RadioListTile(
        value: _group[i].index,
          selected: _group[i].selected,
    onChanged: (val) {
      setState(() {
        for (int i = 0; i < _group.length; i++) {
          _group[i].selected = false;
        }
        _value2 = val;
        _group[i].selected = true;
      });
    },
      ),))
    }
  }

  @override
  Widget build(BuildContext context) {
    return
  }

}