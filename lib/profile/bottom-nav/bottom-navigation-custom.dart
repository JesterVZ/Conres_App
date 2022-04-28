import 'package:flutter/material.dart';

import '../../consts.dart';
import '../tab-item.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({required this.currentTab, required this.onSelectTab, required this.ticketCounter});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final int? ticketCounter;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.main, false),
        _buildItem(TabItem.contracts, false),
        _buildItem(TabItem.claims, true),
        _buildItem(TabItem.chats, true),
        _buildItem(TabItem.more, false)
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index]
      ),
      currentIndex: currentTab.index,
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem, bool isCanGetWsData) {
    return BottomNavigationBarItem(
      icon: isCanGetWsData ? Stack(
        children: [
          Icon(
            TabIcons[tabItem],
            color: _colorMatching(tabItem),
          ),
          Positioned(
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
              child: const Text(
                "0",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10
                ),
              ),
            ),
          )
        ],
      )  : Icon(
        TabIcons[tabItem],
        color: _colorMatching(tabItem),
      ),
      label: tabName[tabItem],
    );
  }

  Color _colorMatching(TabItem item){
    return currentTab == item ? colorMain : Colors.grey;
  }
}