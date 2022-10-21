import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/bloc/profile/profile-state.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/elements/header/header-notification.dart';
import 'package:conres_app/model/object_pu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../DI/dependency-provider.dart';
import '../bloc/auth/auth-block.dart';
import '../bloc/auth/auth-state.dart';
import '../elements/bloc/bloc-screen.dart';
import '../elements/testimony/object-pu-dialog.dart';
import '../elements/testimony/object-pu.dart';
import 'link-pu/link-pu-step-1.dart';

class ObjectsPU extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _ObjectsPU();
}

class _ObjectsPU extends State<ObjectsPU>{

  void _editPU(){

  }
  ProfileBloc? profileBloc;
  List<Widget> objects = [];
  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                    padding: EdgeInsets.only(
                        left: defaultSidePadding, right: defaultSidePadding),
                    height: 100,
                    child: HeaderNotification(
                      text: "Ваши объекты",
                    )),
              Expanded(
                    child: Scrollbar(
                        child: SingleChildScrollView(
                            child: Column(
                  children: [
                    Column(
                      children: [
                        //здесь объекты
                        Column(
                          children: objects,
                        ),
                      ],
                    )
                  ],
                )))),
                Container(
                  padding: EdgeInsets.only(left: defaultSidePadding, right: defaultSidePadding),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: Row(
                    children: [
                      Container(
                        width: 160,
                        height: 55,
                        child: ElevatedButton(
                        onPressed: () {
                          showDialog(context: context, builder: (BuildContext context) => ObjectPuDialog(title: "Новый объект", function: _editPU,));
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              padding: EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                              ),
                              child: SvgPicture.asset("assets/plus.svg"),
                            ),
                            Text("Новый объект", style: TextStyle(fontSize: 11)),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: colorMain,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                      )
                      ),
                  const Spacer(),
                  Container(
                        width: 160,
                        height: 55,
                        child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LinkPUStep1()));
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              padding: EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                              ),
                              child: SvgPicture.asset("assets/plus.svg"),
                            ),
                            
                            Text("Новый ПУ", style: TextStyle(fontSize: 11)),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: colorMain,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                      )
                      ),
                    ],
                  )
                )
            ],
          ),
        );
      }
    );
}
_listener(BuildContext context, ProfileState state){
  if(state.loading == true){
    return;
  }
  if(state.objectsPU != null){
    if(objects.isEmpty){
      for(int i = 0; i < state.objectsPU!.length; i++){
        objects.add(ObjectPU(objectPuModel: state.objectsPU![i],));
      }
    }

  }
}
  @override
  void didChangeDependencies() {
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    profileBloc!.getObjectsPU();
    super.didChangeDependencies();
  }
}