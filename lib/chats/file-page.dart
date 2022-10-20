import 'dart:io';

import 'package:conres_app/DI/dependency-provider.dart';
import 'package:conres_app/UI/image-for-pick.dart';
import 'package:conres_app/elements/bloc/bloc-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../bloc/profile/profile-bloc.dart';
import '../bloc/profile/profile-state.dart';
import '../consts.dart';

class FilePage extends StatefulWidget {
  ValueChanged<List<File>>? func;
  FilePage({required this.func});
  @override
  State<StatefulWidget> createState() => _FilePage();
}

class _FilePage extends State<FilePage> {
  ProfileBloc? profileBloc;
  List<ImageForPick> pickImages = [];
  bool isLoadingFiles = true;
  List<File> files = []; //все файлы из альбома
  List<File> selectedFiles = []; //выбранные файлы

  @override
  void dispose() {
    //закрываем панель
    widget.func!.call(selectedFiles);
    print("dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocScreen<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.all(31),
              child: Column(
                children: [
                  Expanded(
                      child: Scrollbar(
                    child: SingleChildScrollView(
                        child: Wrap(
                            direction: Axis.horizontal, children: pickImages)),
                  )),
                  Container(
                    height: 55,
                    child: Row(
                      children: [
                        Container(
                          width: 160,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: colorMain,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {},
                            child: Row(
                              children: [
                                const Text("Галерея"),
                                const Spacer(),
                                Container(
                                  width: 32,
                                  height: 32,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.1)),
                                  child: SvgPicture.asset("assets/gallery.svg"),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 160,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: colorGray,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {},
                            child: Row(
                              children: [
                                const Text("Файлы"),
                                const Spacer(),
                                Container(
                                  width: 32,
                                  height: 32,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.1)),
                                  child: SvgPicture.asset("assets/gallery.svg"),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Visibility(
                child: Center(
                    child: Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(color: colorMain),
                )),
                visible: (isLoadingFiles == true) ? true : false)
          ],
        );
      },
    );
  }

  void _getFilesFromMedium(List<Medium> images) async {
    for (int i = 0; i < images.length; i++) {
      files.add(await images[i].getFile());
      setState(() {
        pickImages.add(ImageForPick(file: files[i], func: _addFile));
      });
    }
  }

  void _addFile(File file) {
    if (selectedFiles.contains(file)) {
      selectedFiles.remove(file);
    } else {
      selectedFiles.add(file);
    }
  }

  _listener(BuildContext context, ProfileState state) {
    if (state.loading == true) {
      return;
    }
    if (state.images != null &&
        state.images!.isNotEmpty &&
        pickImages.isEmpty) {
      isLoadingFiles = false;
      _getFilesFromMedium(state.images!);
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    profileBloc ??= DependencyProvider.of(context)!.profileBloc;
    List<Album> imageAlbums = await PhotoGallery.listAlbums(
        mediumType: MediumType.image); //получить список альбомов
    profileBloc!.getAllPhotos(imageAlbums[0]);
  }
}
