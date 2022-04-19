import 'package:conres_app/icons.dart';
import 'package:flutter/cupertino.dart';

enum TabItem{
  main,
  contracts,
  claims,
  chats,
  more
}

const Map<TabItem, String> tabName = {
  TabItem.main: 'Главная',
  TabItem.contracts: 'Договоры',
  TabItem.claims: 'Заявления',
  TabItem.chats: 'Обращения',
  TabItem.more: 'Ещё'
};

const Map<TabItem, IconData> TabIcons = {
  TabItem.main: CustomIcons.home,
  TabItem.contracts: CustomIcons.contracts,
  TabItem.claims: CustomIcons.reports,
  TabItem.chats: CustomIcons.chat,
  TabItem.more: CustomIcons.dot_3
};