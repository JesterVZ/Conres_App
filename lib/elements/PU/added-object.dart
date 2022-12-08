import 'package:conres_app/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../model/object_pu.dart';

class AddedObject extends StatelessWidget{
  ObjectPuModel? object;
  Function remove;
  AddedObject({required this.object, required this.remove});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
      width: MediaQuery.of(context).size.width,
      height: 55,
      decoration: BoxDecoration(
        color: messageColor,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Center(
            child: Text(object == null ? "" : object!.name!, style: TextStyle(color: colorMain, fontSize: 18)),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => remove.call(object),
            child: SvgPicture.asset("assets/list-close.svg"),
          )
        ],
      )
      
    );
  }
}