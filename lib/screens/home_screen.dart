import 'package:five_on_four/features/matches/domain/models/match.dart';
import 'package:five_on_four/features/matches/index.dart';
import 'package:five_on_four/features/matches/presentation/widgets/match_brief.dart';
import 'package:five_on_four/navigation/app_router.dart';
import 'package:five_on_four/widgets/app_bar_popup_menu/app_bar_popup_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Home"),
          centerTitle: true,
          actions: <Widget>[
// TODO build a function to create this popup menu to be reused for all screens
// and put it in utils folder somewhere
            AppBarPopupMenu(),
          ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // TODO here we should also provide info whether we want to create new or edit
          // Navigator.of(context).pushNamed(matchEditRoute);
          AppRouter.toMatchEdit(context, "3");
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
                    Flexible(
                      flex: 1,
                      child: Column(
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
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
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
                          MatchInvite(match: testList[0]),
                          MatchInvite(match: testList[1]),
                          MatchInvite(match: testList[2]),
                        ],
                      ),
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
                    MatchBrief(
                      match: Match(
                        id: 1,
                        date: "20/08/2022",
                        name: "Test upcoming match",
                        time: "18:30",
                        location: "Location",
                        maxPlayers: 12,
                        description: "QQuick Lorem Ipsum here",
                        organizerPhoneNumber: "123456789",
                        players: ["Luka", "Ivan", "Martina"],
                      ),
                      playerMatchActionLabel: PlayerMatchAction.unjoin,
                      handlePlayerMatchAction: () async {},
                    )
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

          return Column(
            children: [
              Divider(),
              SizedBox(
                height: 10,
              ),
              MatchBrief(
                match: match,
                playerMatchActionLabel: PlayerMatchAction.join,
                handlePlayerMatchAction: () async {},
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

  Widget _renderMatchBrief(
    BuildContext context, {
    required int matchId,
    required String matchName,
    required String city,
    required String dateString,
    required String timeString,
    required int maxPlayers,
    required int joinedPlayers,
    required String actionLabel,
    required HandlePlayerMatchAction userMatchAction,
  }) {
    final matchLabel = "$matchName, $dateString, $timeString";
    final playersLabel = "$maxPlayers players max, $joinedPlayers joined";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TextButton(
          onPressed: () {
            AppRouter.toMatch(context, matchId);
          },
          child: Text(matchLabel, style: Theme.of(context).textTheme.headline6),
          style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
        ),
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
