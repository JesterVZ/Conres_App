import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../consts.dart';

class ContractElement extends StatelessWidget{
  final String thisLs;
  final String thisDateAdded;
  final String thisAddress;
  final int status;

  ContractElement({required this.thisLs, required this.thisDateAdded, required this.thisAddress, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: profileColor,
          border: Border.all(color: borderProfileColor),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
          padding: EdgeInsets.fromLTRB(19, 14, 19, 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(currentLs,
                              style: TextStyle(
                                  color: profileLabelColor,
                                  fontSize: 15)),
                          Text(thisLs,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18))
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 40,
                        height: 40,
                        child: SvgPicture.asset("assets/fire.svg"),
                      )
                    ],
                  )
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dateAdded,
                          style: TextStyle(
                              color: profileLabelColor,
                              fontSize: 15)),
                      Text(thisDateAdded.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18))
                    ],
                  )),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(objectAddress,
                          style: TextStyle(
                              color: profileLabelColor,
                              fontSize: 15)),
                      Text(thisAddress,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18))
                    ],
                  )),
            ],
          )),
    );
  }
}