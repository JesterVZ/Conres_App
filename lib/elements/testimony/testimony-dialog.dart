import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';

class TestimonyDialog extends StatefulWidget {
  String time;
  String coefficient;
  String consumption;
  String previousReadings;

  TestimonyDialog(
      this.time, this.coefficient, this.consumption, this.previousReadings,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestimonyDialog();
}

class _TestimonyDialog extends State<TestimonyDialog> {
  double? value;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget labelTitle = Row(
      children: [
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(right: 9),
          decoration: BoxDecoration(color: yellowColor, shape: BoxShape.circle),
        ),
        Text(widget.time)
      ],
    );
    return AlertDialog(
        title: labelTitle,
        content: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            height: 280,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Column(children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Новое показание",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: inputBorder))),
                  )),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(children: [
                  const Text("Расчётный коэфициент:"),
                  const Spacer(),
                  Text(widget.coefficient)
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 17),
                child: Row(
                  children: [
                    const Text("Расход:"),
                    const Spacer(),
                    Text(widget.consumption)
                  ],
                ),
              ),
              Divider(
                color: borderProfileColor,
                thickness: 2,
              ),
              Container(
                  margin: const EdgeInsets.only(top: 17),
                  child: Row(
                    children: [
                      const Text("Предыдущие показания:"),
                      const Spacer(),
                      Text(widget.previousReadings)
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(top: 17),
                width: MediaQuery.of(context).size.width,
                height: 55,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (controller.text != "") {
                          value = double.tryParse(controller.text);
                        } else {
                          value = 0;
                        }
                      });
                      Navigator.pop(context, value);
                    },
                    child: Text("Принять", style: buttonTextStyle),
                    style: ElevatedButton.styleFrom(primary: colorMain)),
              )
            ]),
          ),
        ));
  }
}
