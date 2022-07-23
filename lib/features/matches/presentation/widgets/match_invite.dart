import 'package:five_on_four/navigation/index.dart';
import "package:five_on_four/features/matches/index.dart" show Match;
import 'package:flutter/material.dart';

class MatchInvite extends StatelessWidget {
  final Match match;
  const MatchInvite({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final matchLabel =
        "${match.name}, ${match.location}, ${match.date}, ${match.time}";

    return TextButton(
      style: ButtonStyle(
        // padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(1)),

        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.only(top: 5, bottom: 5)),
        // fixedSize: MaterialStateProperty.<Size>(Size())
      ),
      onPressed: () {
        // this should eventually navigate to a match
        AppRouter.toMatch(context, match.id);
      },
      child: Text(
        matchLabel,
        // overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
