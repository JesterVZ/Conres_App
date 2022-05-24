import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FileNameElement extends StatelessWidget{
  String? fileName;
  String? mimeType;

  FileNameElement({Key? key, required this.fileName, required this.mimeType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 50,
      child: Flex(
        direction: Axis.horizontal,
        children: [Flexible(flex: 1, child: Row(children: [Text(fileName!, overflow: TextOverflow.ellipsis)]))],
      ),
    );
  }
  String _parseMime(String source){
    List<String> result = source.split('/');
    return result.last;
  }
}