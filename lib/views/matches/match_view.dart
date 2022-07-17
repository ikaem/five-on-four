import 'package:five_on_four/features/matches/models/player.dart';
import 'package:five_on_four/utils/app_bar/show_app_bar_popup_menu.dart';
import 'package:five_on_four/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MatchView extends StatelessWidget {
  const MatchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View match"),
        centerTitle: true,
        actions: <Widget>[showAppBarPopupMenu()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        // TODO not sure if this is good for all
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                key: Key("match-name"),
                "Match name goes here",
                style: Theme.of(context).textTheme.headline3,
              ),
              // TODO this text button needs styling
              TextButton(onPressed: () {}, child: Text("joined".toUpperCase())),
              Column(
                key: Key("match-info"),
                children: <Widget>[
                  // TODO probably should create some compount widget for text with icon or some such
                  TextWithIcon(
                    text: "Match info",
                    icon: Icons.info,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  TextWithIcon(
                    text: "22 July 2022",
                    icon: Icons.calendar_month,
                  ),
                  TextWithIcon(
                    text: "18:30 - 19:30",
                    icon: Icons.access_time_outlined,
                  ),
                  TextWithIcon(
                    text: "Zagreb, Sportski centar Trnje",
                    icon: Icons.location_on,
                  ),
                  TextWithIcon(
                    text: "12 players limit",
                    icon: Icons.people,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                key: Key("match-description"),
                children: <Widget>[
                  // TODO probably should create some compount widget for text with icon or some such
                  TextWithIcon(
                    text: "Match info",
                    icon: Icons.bookmark,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur")
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                key: Key("match-organizer-contact"),
                children: <Widget>[
                  // TODO probably should create some compount widget for text with icon or some such
                  TextWithIcon(
                    text: "Organizer's phone number",
                    icon: Icons.phone,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text("092 123 4567")
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                key: Key("match-players"),
                children: <Widget>[
                  // TODO probably should create some compount widget for text with icon or some such
                  TextWithIcon(
                    text: "Joined players",
                    icon: Icons.people,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  for (Player player in mockPlayers)
                    Row(
                      children: <Widget>[
                        Text(player.nickname),
                      ],
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
