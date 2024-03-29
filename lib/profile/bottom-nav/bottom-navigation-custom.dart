import 'package:flutter/material.dart';

import '../../Services/bottom-navigation-select-service.dart';
import '../../consts.dart';
import '../tab-item.dart';
/* 
bottom-navigation-custom.dart
Нижний бар навигации
TODO перенести в друой раздел

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
class BottomNavigation extends StatelessWidget {
  //основной  сэтап
  BottomNavigation(
      {required this.currentTab,
      required this.onSelectTab,
      required this.ticketCounter,
      required this.claimCounter,
      required this.bottomNavigationSelectService});
  TabItem currentTab;
  Function(TabItem tabItem) onSelectTab;
  int? ticketCounter;
  int? claimCounter;
  BottomNavigationSelectService bottomNavigationSelectService;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 10,
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.main, false, null),
        _buildItem(TabItem.contracts, false, null),
        _buildItem(TabItem.claims, true, claimCounter),
        _buildItem(TabItem.chats, true, ticketCounter),
        _buildItem(TabItem.more, false, null)
      ],
      onTap: (index) {
        bottomNavigationSelectService.canLogin = false;
        onSelectTab(TabItem.values[index]);
      },
      currentIndex: currentTab.index,
    );
  }

  BottomNavigationBarItem _buildItem(
      TabItem tabItem, bool isCanGetWsData, int? counter) {
    return BottomNavigationBarItem(
      icon: isCanGetWsData
          ? Stack(
              children: [
                Icon(
                  TabIcons[tabItem],
                  color: _colorMatching(tabItem),
                ),
                Visibility(
                    visible: (counter != 0 && counter != null) ? true : false,
                    child: Positioned(
                      right: 0,
                      top: -3,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        constraints: const BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          counter != null ? counter.toString() : "",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ))
              ],
            )
          : Icon(
              TabIcons[tabItem],
              color: _colorMatching(tabItem),
            ),
      label: tabName[tabItem],
    );
  }

  Color _colorMatching(TabItem item) {
    return currentTab == item ? colorMain : colorGray;
  }
}
