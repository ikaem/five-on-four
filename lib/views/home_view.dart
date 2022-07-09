import 'package:five_on_four/enums/app_bar_menu_action.dart';
import 'package:five_on_four/extensions/formatting/string.dart';
import 'package:five_on_four/typedefs/user_match_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Home"),
          centerTitle: true,
          actions: <Widget>[
// TODO build a function to create this popup menu to be reused for all screens
            PopupMenuButton<AppBarMenuAction>(
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
            )
          ]),
      // TODO body matches does need to be scrollable
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              key: const Key("user-info"),
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Karlo",
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  key: const Key("matches-user"),
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      key: const Key("matches-joined"),
                      children: <Widget>[
                        Text(
                          "Joined matches",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Today: 2"),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("This week: 4"),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      key: const Key("matches-invited"),
                      children: <Widget>[
                        Text(
                          "You have 3 match invitations",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        _renderMatchInviteNotification(
                            matchName: "MatchName",
                            city: "city",
                            dateString: "22/07/2022",
                            timeString: "18:30"),
                        _renderMatchInviteNotification(
                            matchName: "MatchName",
                            city: "city",
                            dateString: "22/07/2022",
                            timeString: "18:30"),
                        _renderMatchInviteNotification(
                            matchName: "MatchName",
                            city: "city",
                            dateString: "22/07/2022",
                            timeString: "18:30"),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  key: const Key("match-next"),
                  children: <Widget>[
                    Text(
                      "Next match",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // this should be a widget or a function that returns widget, we will see
                    _renderMatchBrief(
                        matchName: "Some match",
                        city: "Zagreb",
                        dateString: "20/08/2022",
                        timeString: "18:30",
                        maxPlayers: 12,
                        joinedPlayers: 7,
                        actionLabel: "",
                        userMatchAction: userMatchAction)
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: <Widget>[
                    //     const Text("Match name, 22/06/2022, 18:30"),
                    //     // this will eventually be a button to open maps or something like that
                    //     // TextButton(onPressed: () {}, child: Text("Zagreb, Sportski centar Trnje"))
                    //     TextButton.icon(
                    //       onPressed: () {},
                    //       icon: const Icon(Icons.location_on),
                    //       label: const Text("Zagreb, Sportski centar Trnje"),
                    //     ),
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         const Text("10 players max, 3 remaining"),
                    //         TextButton(
                    //             onPressed: () {},
                    //             child: const Text("ACCEPT / JOIN / UNJOIN"))
                    //       ],
                    //     )
                    //   ],
                    // )
                  ],
                )
                // this is a match widget now
              ],
            ),
          )
        ],
      ),
    );
  }

  // this should also actually bi clickable - so probably better text button
  Widget _renderMatchInviteNotification({
    required String matchName,
    required String city,
    required String dateString,
    required String timeString,
  }) {
    final matchLabel = "$matchName, $city, $dateString, $timeString";

    return SizedBox(
      height: 30,
      child: TextButton(
        style: ButtonStyle(
          // padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(1)),
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.only(top: 5, bottom: 5)),
          // fixedSize: MaterialStateProperty.<Size>(Size())
        ),
        onPressed: () {
          // this should eventually navigate to a match
        },
        child: Text(matchLabel),
      ),
    );
  }

  Widget _renderMatchBrief({
    required String matchName,
    required String city,
    required String dateString,
    required String timeString,
    required int maxPlayers,
    required int joinedPlayers,
    required String actionLabel,
    required UserMatchAction userMatchAction,
  }) {
    final matchLabel = "$matchName, $dateString, $timeString";
    final playersLabel = "$maxPlayers players max, $joinedPlayers joined";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(matchLabel),
        // this will eventually be a button to open maps or something like that
        // TextButton(onPressed: () {}, child: Text("Zagreb, Sportski centar Trnje"))
        SizedBox(
          height: 30,
          child: TextButton.icon(
            style: ButtonStyle(
              // padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(1)),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.only(top: 5, bottom: 5)),
              // fixedSize: MaterialStateProperty.<Size>(Size())
            ),
            onPressed: () {
              // this should open maps
            },
            icon: const Icon(Icons.location_on),
            label: Text(city),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(playersLabel),
            TextButton(onPressed: userMatchAction, child: Text(actionLabel))
          ],
        )
      ],
    );
  }
}
