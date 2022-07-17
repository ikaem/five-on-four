import 'package:five_on_four/utils/enums/app_bar_menu_action.dart';
import 'package:five_on_four/utils/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppBarPopupMenu extends StatelessWidget {
  const AppBarPopupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
