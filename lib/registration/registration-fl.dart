import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../consts.dart';

class RegFL extends StatefulWidget {
  const RegFL({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegFL();
}

class _RegFL extends State<RegFL> {
  TextEditingController lkController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Widget svg = SvgPicture.asset('assets/background_image.svg',
      color: colorLogo, semanticsLabel: 'Acme Logo');
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return
        Scrollbar(
          controller: _controller,
          isAlwaysShown: true,
            child: Scaffold(
            appBar: AppBar(),
            resizeToAvoidBottomInset: false,
            body: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                    width: 375,
                    left: 26,
                    top: 26,
                    child: Text(regTitle,
                        style: const TextStyle(
                            fontFamily: 'Bubicon-Bold', fontSize: 36.0))),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          family,
                          style: TextStyle(color: colorGrayText, fontSize: 16.0),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: inputBorder))),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(color: colorGrayText, fontSize: 16.0),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: inputBorder))),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patronymic,
                          style: TextStyle(color: colorGrayText, fontSize: 16.0),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: inputBorder))),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          inn,
                          style: TextStyle(color: colorGrayText, fontSize: 16.0),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: inputBorder))),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snils,
                          style: TextStyle(color: colorGrayText, fontSize: 16.0),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: inputBorder))),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contacts,
                          style: TextStyle(color: colorGrayText, fontSize: 16.0),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: inputBorder))),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          email,
                          style: TextStyle(color: colorGrayText, fontSize: 16.0),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: inputBorder))),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lkPasswordText,
                          style: TextStyle(color: colorGrayText, fontSize: 16.0),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: inputBorder))),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          repeatPassword,
                          style: TextStyle(color: colorGrayText, fontSize: 16.0),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: inputBorder))),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          repeatPassword,
                          style: TextStyle(color: colorGrayText, fontSize: 16.0),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: inputBorder))),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          repeatPassword,
                          style: TextStyle(color: colorGrayText, fontSize: 16.0),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: inputBorder))),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          repeatPassword,
                          style: TextStyle(color: colorGrayText, fontSize: 16.0),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: inputBorder))),
                        )
                      ],
                    ),

                  ],
                ),
                /*
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  top: 320,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 55.0,
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  clearPassword,
                                  style: const TextStyle(fontSize: 18.0),
                                ),
                                style:
                                ElevatedButton.styleFrom(primary: colorMain))),
                      ),

                      //ElevatedButton(onPressed: (){}, child: Text(login)),
                    ],
                  ),
                ),
                 */
              ],
            )));
  }
}
