import 'package:flutter/material.dart';

import '../../consts.dart';
import '../tab-item.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation(
      {required this.currentTab,
      required this.onSelectTab,
      required this.ticketCounter,
      required this.claimCounter});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  int? ticketCounter;
  int? claimCounter;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.main, false, null),
        _buildItem(TabItem.contracts, false, null),
        _buildItem(TabItem.claims, true, claimCounter),
        _buildItem(TabItem.chats, true, ticketCounter),
        _buildItem(TabItem.more, false, null)
      ],
      onTap: (index) => onSelectTab(TabItem.values[index]),
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
                    visible: counter != 0 ? true : false,
                    child: Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.only(left: 2, right: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
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
    return currentTab == item ? colorMain : Colors.grey;
  }
}
