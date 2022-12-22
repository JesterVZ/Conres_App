
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
/*
locator.dart
(устарел) DI-контейнер

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
*/
void setup(){
  locator.registerLazySingleton<List>(() => []);
}