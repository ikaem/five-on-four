import 'package:five_on_four/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:five_on_four/features/matches/constants/player_match_action_label.dart';
import 'package:five_on_four/features/matches/constants/player_match_status_label.dart';
import 'package:five_on_four/features/matches/domain/index.dart';
import 'package:five_on_four/features/matches/domain/models/player.dart';
import 'package:five_on_four/features/matches/presentation/controllers/matches_controller.dart';
import 'package:five_on_four/features/players/presentation/players_controller.dart';
import 'package:five_on_four/features/users/domain/models/user.dart';
import 'package:five_on_four/features/users/presentation/controllers/users_controller.dart';
import 'package:five_on_four/navigation/extensions.dart';
import 'package:five_on_four/services/dev/dev_service.dart';
import 'package:five_on_four/widgets/app_bar_popup_menu/app_bar_popup_menu.dart';
import 'package:five_on_four/widgets/centered_message.dart';
import 'package:five_on_four/widgets/loading_indicator.dart';
import 'package:five_on_four/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MatchScreen extends StatefulWidget {
  final int matchId;

  MatchScreen(this.matchId, {Key? key}) : super(key: key);

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  List<User> _users = [];

  final MatchesController _matchesController = MatchesController();
  final PlayersController _playersController = PlayersController();

  final UsersController _usersController = UsersController();
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
// TODO this all might need to be turned into a stateful widget
// and then just create

    final User? currentUser = _authController.authState(context)?.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("View match"),
        centerTitle: true,
        actions: <Widget>[
          AppBarPopupMenu(),
        ],
      ),
      body: FutureBuilder(
        future: _handleLoadMatch(context),
        builder: (context, AsyncSnapshot<Match?> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingIndicator();
          }

// TODO test this to see how it looks like
          if (snapshot.hasError) {
            return CenteredMessage(
                message: "There was an issue fetchig the match");
          }

          final match = snapshot.data;

          if (match == null) {
            return CenteredMessage(message: "There is no such match");
          }

          return _renderLoadedMatchData(context, match, currentUser);
        },
      ),
    );
  }

  Padding _renderLoadedMatchData(
      BuildContext context, Match match, User? user) {
    return Padding(
      padding: const EdgeInsets.all(10),
      // TODO not sure if this is good for all
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              key: Key("match-name"),
              match.name,
              style: Theme.of(context).textTheme.headline3,
            ),
            // TODO this text button needs styling
            // TODO this will eventually also need to to fetch info about user if they joined
            // or, we can get the user, and check against the joined users
            // TextButton(onPressed: () {}, child: Text("joined".toUpperCase())),
            _renderPlayerMatchStatusAndAction(user, match),
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
                  text: match.datetime,
                  icon: Icons.calendar_month,
                ),
                TextWithIcon(
                  text: match.datetime,
                  icon: Icons.access_time_outlined,
                ),
                TextWithIcon(
                  text: match.location,
                  icon: Icons.location_on,
                ),
                TextWithIcon(
                  text: "${match.maxPlayers} players limit",
                  icon: Icons.people,
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              key: Key("match-description"),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // TODO probably should create some compount widget for text with icon or some such
                TextWithIcon(
                  text: "Match description",
                  icon: Icons.bookmark,
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                Text(match.description)
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
                Text(match.organizerPhoneNumber)
              ],
            ),
            SizedBox(
              height: 30,
            ),
            _renderTabbableStatusedPlayers(match.players),
          ],
        ),
      ),
    );
  }

  // TODO define actions here for user - or elsewhere, somewhere in helpers
  // TODO also define some function that will do the choosing of which action to call for current user status
  // and also define function what label to sho

  Widget _renderPlayerMatchStatusAndAction(User? user, Match match) {
    final spotsAvailable = match.maxPlayers -
        match.players
            .where((p) => p.matchStatus == PlayerMatchStatusLabel.joined)
            .length;

    final isSpotsAvailable = spotsAvailable > 0 ? true : false;
    final matchAvailabilityStatus = isSpotsAvailable
        ? "$spotsAvailable Spots available".toUpperCase()
        : "Full".toUpperCase();

    final playerMatchStatus = _getPlayerMatchStatus(user, match);
    final playerMatchAction =
        _getPlayerMatchAction(playerMatchStatus, user, match, isSpotsAvailable);

    return Row(
      children: <Widget>[
        Expanded(child: Text(matchAvailabilityStatus)),
        // SizedBox(
        //     // width: 10,
        //     // width: double.maxFinite,
        //     ),
        Text(playerMatchStatus.toUpperCase()),
        TextButton(
            onPressed: () =>
                // TODO this should get a player somwhow

                playerMatchAction.playerMatchActionCallback(),
            child:
                Text(playerMatchAction.playerMatchActionLabel.toUpperCase())),
      ],
    );
  }

  String _getPlayerMatchStatus(User? user, Match match) {
    final userPlayers = match.players.where((p) => p.userId == user?.id);

    if (userPlayers.isEmpty) return PlayerMatchStatusLabel.notJoined;

    final userPlayer = userPlayers.first;

    return userPlayer.matchStatus;
  }

// TODO probably should not be void
  PlayerMatchAction _getPlayerMatchAction(String playerMatchStatus, User? user,
      Match match, bool isSpotsAvailable) {
// check if we are on waiting list

    devService.log("player match status: $playerMatchStatus");
    devService.log("player match status: $isSpotsAvailable");

    final userPlayers = match.players.where((p) => p.userId == user?.id);

    // if there is no spots available, we can either go to join or join waiting list
    // so if

    if (userPlayers.isEmpty) {
      return PlayerMatchAction(PlayerMatchActionLabel.join, () async {
        devService.log("Join match function");
      });
      // TODO we will have to make it available to decline the invite too

    }

    if (playerMatchStatus == PlayerMatchStatusLabel.onWaitingList) {
      return PlayerMatchAction(
        PlayerMatchActionLabel.unjoinWaitingList,
        () async {
          devService.log("Unjoin waiting list function");
          await _playersController.unjoinPlayerMatchWaitingList(player);
        },
      );
    }

// from this point, we are not on waiting list
    if (playerMatchStatus == PlayerMatchStatusLabel.joined) {
      return PlayerMatchAction(
        PlayerMatchActionLabel.unjoin,
        () async {
          devService.log("Unjoin waiting list function");
        },
      );
    }

// TODO need to rething this, but leave it buggy for now
// from this point, we are not joined
    if (!isSpotsAvailable) {
      return PlayerMatchAction(
        PlayerMatchActionLabel.joinWaitingList,
        () async {
          devService.log("Join waiting list function");
        },
      );
    }

    // from this point on spots ae available - and only option left if to accept invite
    if (playerMatchStatus == PlayerMatchStatusLabel.invited) {
      return PlayerMatchAction(
        PlayerMatchActionLabel.acceptInvite,
        () async {
          devService.log("Accept invite function");
        },
        // TODO we will have to make it available to decline the invite too
      );
    }

    // from this point, user is no longer invited
    // if(play)
  }

  // TODO test
  Widget _renderTabbableStatusedPlayers(List<Player> players) {
    final test = double.maxFinite;
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          TabBar(
            tabs: [
              Tab(
                text: "Joined players",
              ),
              Tab(
                text: "Invited players",
              )
            ],
          ),
          SizedBox(
            // TODO this does not seem correct - need to have some way to expand the size dynamically
            height: 100,
            child: TabBarView(children: <Widget>[
              Column(
                children:
                    _renderPlayers(players, PlayerMatchStatusLabel.joined),
              ),
              Column(
                children:
                    _renderPlayers(players, PlayerMatchStatusLabel.invited),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  List<Widget> _renderPlayers(List<Player> players, String playerMatchStatus) {
    final playerRows = players
        .where((p) => p.matchStatus == playerMatchStatus)
        .map<Widget>((p) {
      // TODO probablys not the best approach, since no key assign to any row
      return Row(
        children: <Widget>[
          Text(p.nickname),
        ],
      );
    }).toList();

    return playerRows;
  }

  Future<Match?> _handleLoadMatch(BuildContext context) async {
    // TODO later, erros should be just propagated from here

    final matchId = widget.matchId;

    if (matchId == null) {
      // in this case, we would also probably return some error later
      // this would work with just returning null too
      return Future.value(null);
      // return null;
    }

    try {
      final match = await _matchesController.loadMatch(matchId);
      return match;
    } catch (e) {
      // TODO i would not want to handle stuff here - i there is error, should it be handled in the controller isntead
      devService.log(e);
      return null;
    }
  }
}

// TODO this should go elsewhere - maybe some types, or models or something, not sure

// typedef PlayerMatchActionCallback = void Function(Player player, Match match);
typedef PlayerMatchActionCallback = Future<void> Function();

class PlayerMatchAction {
  final String playerMatchActionLabel;
  final PlayerMatchActionCallback playerMatchActionCallback;

  PlayerMatchAction(
      this.playerMatchActionLabel, this.playerMatchActionCallback);
}
