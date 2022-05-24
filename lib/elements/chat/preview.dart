import 'package:flutter/cupertino.dart';

class Preview extends StatefulWidget{
  String? uri;
  Preview({required this.uri});
  
  @override
  State<StatefulWidget> createState() => _Preview();
}

class _Preview extends State<Preview>{
  @override
  Widget build(BuildContext context) {
    if(widget.uri != ""){
      try{
        return Image(image: NetworkImage(widget.uri!));
      }catch(e){
        return Image.asset('assets/loading.gif');
      }
    } else {
      return Container();
    }
  }
}