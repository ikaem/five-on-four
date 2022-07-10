// TODO temp stateless widget
import 'package:five_on_four/utils/app_bar/show_app_bar_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MatchEditView extends StatelessWidget {
  const MatchEditView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO title will also be dynamic, based on whether we edit or create new item

        title: const Text("Create match"),
        centerTitle: true,
        actions: <Widget>[
          showAppBarPopupMenu(),
        ],
      ),
    );
  }
}
