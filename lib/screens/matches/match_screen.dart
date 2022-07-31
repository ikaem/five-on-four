import 'package:five_on_four/features/matches/domain/index.dart';
import 'package:five_on_four/features/matches/domain/models/player.dart';
import 'package:five_on_four/features/matches/presentation/controllers/matches_controller.dart';
import 'package:five_on_four/navigation/extensions.dart';
import 'package:five_on_four/widgets/app_bar_popup_menu/app_bar_popup_menu.dart';
import 'package:five_on_four/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MatchScreen extends StatelessWidget {
  MatchScreen({Key? key}) : super(key: key);

  final MatchesController _matchesController = MatchesController();

  @override
  Widget build(BuildContext context) {
// TODO this all might need to be turned into a stateful widget
// and then just create

    return Scaffold(
      appBar: AppBar(
        title: const Text("View match"),
        centerTitle: true,
        actions: <Widget>[
          AppBarPopupMenu(),
        ],
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
                  // TODO here rendered players
                  // for (Player player in mockPlayers)
                  //   Row(
                  //     children: <Widget>[
                  //       Text(player.nickname),
                  //     ],
                  //   ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Match?> _handleLoadMatch(BuildContext context) async {
    // TODO later, erros should be just propagated from here
    int? matchId = context.getRouteArgument<int>();

    if (matchId == null) {
      // in this case, we would also probably return some error later
      // this would work with just returning null too
      return Future.value(null);
      // return null;
    }

    final match = await _matchesController.loadMatch(matchId);

    return match;
  }
}
