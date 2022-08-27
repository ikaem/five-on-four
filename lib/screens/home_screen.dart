import 'package:five_on_four/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:five_on_four/features/matches/domain/models/match.dart';
import 'package:five_on_four/features/matches/index.dart';
import 'package:five_on_four/features/matches/presentation/controllers/matches_controller.dart';
import 'package:five_on_four/features/matches/presentation/widgets/match_brief.dart';
import 'package:five_on_four/features/users/domain/models/user.dart';
import 'package:five_on_four/navigation/app_router.dart';
import 'package:five_on_four/services/dev/dev_service.dart';
import 'package:five_on_four/widgets/app_bar_popup_menu/app_bar_popup_menu.dart';
import 'package:five_on_four/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final MatchesController _matchesController = MatchesController();
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    final User? currentUser = _authController.authState(context)?.user;

// TODO this could be separated into tab navigation, for my profile, so not everything it crammed into one page
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
                    _renderInvitedMatchesFromSteam(currentUser),
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
                          datetime: "20/08/2022",
                          duration: 1,
                          name: "Test upcoming match",
                          location: "Location",
                          maxPlayers: 12,
                          description: "QQuick Lorem Ipsum here",
                          organizerPhoneNumber: "123456789",
                          players: []
                          // players: ["Luka", "Ivan", "Martina"],
                          ),
                      playerMatchActionLabel: PlayerMatchActionLabel.unjoin,
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
              // child: _renderFilteredMatches(),
              child: _renderFilteredMatchesFromStream(context),
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
                playerMatchActionLabel: PlayerMatchActionLabel.join,
                handlePlayerMatchAction: () async {},
              ),
            ],
          );
        });
  }

  // TODO all of these streams should probably using just one, and data should passed as arugments
  // TODO better just pass matches
  Widget _renderInvitedMatchesFromSteam(User? user) {
    // TODO this will be a future builder, not stream builder
    // TODO should probably swtich to bloc later, or that provider thing - check that website where folder structure is explained
    final streamBuilder = StreamBuilder(
        // stream: _matchesController.allMatchesStream,
        stream: _matchesController.getMyInvitedMatchesStream(user),
        builder: (BuildContext context, AsyncSnapshot<List<Match>> snapshot) {
          final matches = snapshot.data;

          if (matches == null) {
            return const LoadingIndicator();
          }

// TODO this should be a different request i think - where it would jsut return matches that i am invited too

          final lastRenderedInvitationIndex =
              matches.length < 3 ? matches.length : 3;

// TODO should be fitlered by creation date
          final newestInvitations =
              matches.sublist(0, lastRenderedInvitationIndex);

          return Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              key: const Key("matches-invited"),
              children: <Widget>[
                Text(
                  "You have ${matches.length} match invitations",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(
                  // TODO height is bad here too
                  height: 3,
                ),
// TODO should probably use list view builder later
                for (Match invitedMatch in newestInvitations)
                  MatchInvite(
                      key: Key(invitedMatch.id.toString()),
                      match: invitedMatch),
              ],
            ),
          );
        });

    return streamBuilder;
  }

  // TODO what does this return
  _renderFilteredMatchesFromStream(BuildContext context) {
    final streamBuilder = StreamBuilder(
      stream: _matchesController.allMatchesStream,
      builder: (
        // TODO context might not need to be passed
        BuildContext context,
        AsyncSnapshot<List<Match>> snapshot,
      ) {
        // TODO good link here
        // https: //stackoverflow.com/a/55528778
        final matches = snapshot.data;

        if (matches == null) {
          // SPIN SOMEHOW
          return const LoadingIndicator();
        }

        return ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, index) {
              // TODO dont need this, but not sure if this is mandatory
              // return ListTile();

              final match = matches[index];

              return Column(
                children: [
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  MatchBrief(
                    match: match,
                    playerMatchActionLabel: PlayerMatchActionLabel.join,
                    handlePlayerMatchAction: () async {},
                  ),
                ],
              );
            });
      },
    );

    return streamBuilder;
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
}
