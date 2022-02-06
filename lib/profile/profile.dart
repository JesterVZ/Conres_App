import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts.dart';

class Profile extends StatefulWidget{
  const Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Profile();

}

class _Profile extends State<Profile>{
  String thisInn = "19982215874";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(17, 59, 17, 0),
        child: Column(
          children: [
            Row(
              children: [
                Text(profile,  style: const TextStyle(fontSize: 24),)
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                
                color: profileColor,
                border: Border.all(
                  color: borderProfileColor
                ),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(19, 14, 19, 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(inn, style: TextStyle(color: profileLabelColor, fontSize: 15)),
                            Text(thisInn, style: const TextStyle(color: Colors.black, fontSize: 18))
                          ],
                        )
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(gpINN, style: TextStyle(color: profileLabelColor, fontSize: 15)),
                            Text(needDogovor, style: const TextStyle(color: Colors.black, fontSize: 18))
                          ],
                        )
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(emailProfile, style: TextStyle(color: profileLabelColor, fontSize: 15)),
                            const Text("Ahiro2011@gmail.com", style: TextStyle(color: Colors.black, fontSize: 18))
                          ],
                        )
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(address, style: TextStyle(color: profileLabelColor, fontSize: 15)),
                            const Text("-/-", style: TextStyle(color: Colors.black, fontSize: 18))
                          ],
                        )
                    )

                  ],
                )
              )

              ,
            ),
            Positioned(child:
            ElevatedButton(
              onPressed: () {  },
              child: Row(
                children: const [
                  Text("Заключитить договор с РСО")
                ],
              )
            ))
          ],

        )
      ),
       

    );
  }

}