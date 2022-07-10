import 'package:five_on_four/enums/app_bar_menu_action.dart';
import 'package:five_on_four/extensions/formatting/string.dart';
import 'package:flutter/material.dart';

PopupMenuButton<AppBarMenuAction> showAppBarPopupMenu() {
  return PopupMenuButton<AppBarMenuAction>(
    itemBuilder: (context) {
      return [
        PopupMenuItem(
          value: AppBarMenuAction.settings,
          child: Text(AppBarMenuAction.settings.name.capitalize()),
        ),
        PopupMenuItem(
          value: AppBarMenuAction.logout,
          child: Text(AppBarMenuAction.logout.name.capitalize()),
        ),
      ];
    },
    onSelected: (value) {
      // TODO here should login or go to settings page
    },
  );
}
