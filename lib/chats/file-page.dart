import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/UI/image-for-pick.dart';
import 'package:conres_app/elements/bloc/bloc-screen.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';

class FilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FilePage();
}

class _FilePage extends State<FilePage>{
  ProfileBloc? profileBloc;
  List<ImageForPick> images = [];

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: Wrap(
                direction: Axis.horizontal,
                children: [

                ]))
          ],
        );
      },
    );
  }
  _listener(BuildContext context, ProfileState state) {

  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
  }

}