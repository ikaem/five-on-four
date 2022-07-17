import 'package:five_on_four/constants/routes.dart';
import 'package:five_on_four/constants/user_match_action_labels.dart';
import 'package:five_on_four/enums/app_bar_menu_action.dart';
import 'package:five_on_four/extensions/formatting/string.dart';
import 'package:five_on_four/models/match.dart';
import 'package:five_on_four/typedefs/user_match_action.dart';
import 'package:five_on_four/utils/app_bar/show_app_bar_popup_menu.dart';
import 'package:flutter/cupertino.dart';
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
// and put it in utils folder somewhere
            showAppBarPopupMenu(),
          ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // TODO here we should also provide info whether we want to create new or edit
          Navigator.of(context).pushNamed(matchEditRoute);
        },
      ),
      // TODO body matches does need to be scrollable
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // TODO this should be extracted to a function
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
                    _renderMatchBrief(context,
                        matchName: "Some match",
                        city: "Zagreb",
                        dateString: "20/08/2022",
                        timeString: "18:30",
                        maxPlayers: 12,
                        joinedPlayers: 7,
                        // TODO this labl will need to be calculated eventually
                        actionLabel: userMatchUnjoinLabel,
                        userMatchAction: () async {
                      // action to unjoin here
                    }),
                  ],
                )
                // this is a match widget now
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              key: Key("matches-filter"),
              children: <Widget>[
                Text("Matches", style: Theme.of(context).textTheme.labelMedium),
                _renderMatchesFilter(context),
              ],
            ),
          ),
          Expanded(
            key: Key("matches-filtered"),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: _renderFilteredMatches(),
            ),
          ),
        ],
      ),
    );
  }

  ListView _renderFilteredMatches() {
    return ListView.builder(
        itemCount: testList.length,
        itemBuilder: (context, index) {
          // TODO dont need this, but not sure if this is mandatory
          // return ListTile();

          final match = testList[index];

          // return Text(match.name);

          return Column(
            children: [
              Divider(),
              SizedBox(
                height: 10,
              ),
              _renderMatchBrief(
                context,
                matchName: match.name,
                city: match.location,
                dateString: match.date,
                timeString: match.time,
                maxPlayers: match.maxPlayers,
                joinedPlayers: match.players.length,
                actionLabel: userMatchJoinLabel,
                // TODO label and action will need to be calculated
                userMatchAction: () async {},
              ),
            ],
          );
        });
  }

  Widget _renderMatchesFilter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // TODO somehow, this should have a default entry of current location, or if not allowed position data, then just empty and hitn
        // TextField()
        // this should be like a thid of a screen here
        const SizedBox(
          height: 50,
          width: 100,
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Set location",
                icon: Icon(
                  Icons.location_on,
                  size: 16,
                )

                // prefixIcon: Icon(
                //   Icons.location_on,
                //   size: 16,
                // ),
                ),
          ),
        ),
        TextButton.icon(
            label: Text("20-07-2022 - 21-07-2022"),
            onPressed: () async {
              final response = await showDateRangePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );

              print("start: ${response?.start}");
              print("end: ${response?.end}");

              print("response: $response");

              //
            },
            icon: Icon(
              Icons.calendar_month,
              size: 16,
            )),

        DropdownButton(
            // underline: Container(height: 0),
            value: "All",
            items: <String>["All", "Joined", "Invited"]
                .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem<String>(
                      child: Text(value), value: value),
                )
                .toList(),
            onChanged: (String? value) {
              // here set on changed
            })
      ],
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

  Widget _renderMatchBrief(
    BuildContext context, {
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
        Text(matchLabel, style: Theme.of(context).textTheme.headline6),
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
            icon: const Icon(Icons.location_on, size: 16),
            label: Text(
              city,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(playersLabel,
                  style: Theme.of(context).textTheme.labelMedium),
              TextButton(
                  onPressed: userMatchAction,
                  child: Text(actionLabel.toUpperCase()))
            ],
          ),
        )
      ],
    );
  }
}
