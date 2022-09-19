import 'dart:io';

import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/UI/image-for-pick.dart';
import 'package:conres_app/elements/bloc/bloc-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';

class FilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FilePage();
}

class _FilePage extends State<FilePage> {
  ProfileBloc? profileBloc;
  List<ImageForPick> pickImages = [];
  List<File> files = [];

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(31),
          child: Column(
            children: [
              Expanded(
                  child: Scrollbar(
                child: SingleChildScrollView(
                    child:
                        Wrap(direction: Axis.horizontal, children: pickImages)),
              )),
              Container(
                height: 55,
                child: Row(
                  children: [],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _getFilesFromMedium(List<Medium> images) async {
    for (int i = 0; i < images.length; i++) {
      files.add(await images[i].getFile());
      setState(() {
        pickImages.add(ImageForPick(filepath: files[i].path));
      });
    }
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      return;
    }
    if (state.images != null &&
        state.images!.isNotEmpty &&
        pickImages.isEmpty) {
      _getFilesFromMedium(state.images!);
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    List<Album> imageAlbums = await PhotoGallery.listAlbums(
        mediumType: MediumType.image); //получить список альбомов
    profileBloc!.getAllPhotos(imageAlbums);
  }
}
