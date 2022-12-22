import '../profile/tab-item.dart';
/* 
bottom-navigation-select-service.dart
Сервис для выбора элемента bottomnavigationbar извне

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class BottomNavigationSelectService {
  Function(TabItem tabItem)? function;
  bool? canLogin;
}
