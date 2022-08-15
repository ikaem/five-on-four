import 'package:five_on_four/features/matches/domain/models/index.dart'
    show Match;
import 'package:five_on_four/features/matches/index.dart';
import 'package:five_on_four/navigation/app_router.dart';
import 'package:flutter/material.dart';

class MatchBrief extends StatelessWidget {
  final Match match;
  final String playerMatchActionLabel;
  final HandlePlayerMatchAction handlePlayerMatchAction;

  const MatchBrief({
    Key? key,
    required this.match,
    required this.playerMatchActionLabel,
    required this.handlePlayerMatchAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final matchLabel = "${match.name}, ${match.datetime}";
    final playersLabel =
        "${match.maxPlayers} players max, ${match.players.length} joined";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TextButton(
          onPressed: () {
            AppRouter.toMatch(context, match.id);
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
              match.location,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                playersLabel,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              TextButton(
                onPressed: handlePlayerMatchAction,
                child: Text(
                  playerMatchActionLabel.toUpperCase(),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
