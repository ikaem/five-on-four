// TODO temp stateless widget
import 'package:five_on_four/services/dev/dev_service.dart';
import 'package:five_on_four/widgets/app_bar_popup_menu/app_bar_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MatchEditScreen extends StatefulWidget {
  const MatchEditScreen({Key? key}) : super(key: key);

  @override
  State<MatchEditScreen> createState() => _MatchEditScreenState();
}

class _MatchEditScreenState extends State<MatchEditScreen> {
  List<TextEditingController> _invitedPlayersControllers = [];

  List<TextField> _invitedPlayerTextFields = [];

  @override
  void dispose() {
// TODO will need to dispose of all other conttrollers too

    for (final controller in _invitedPlayersControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO title will also be dynamic, based on whether we edit or create new item

        title: const Text("Create match"),
        centerTitle: true,
        actions: <Widget>[
          AppBarPopupMenu(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            TextField(
              style: Theme.of(context).textTheme.headline3,
              decoration: InputDecoration(
                hintText: "Name your match",
                hintStyle: Theme.of(context).textTheme.headline3,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: const <Widget>[
                Expanded(
                  // TODO this should be a button aynhow
                  // and the one below, too
                  child: TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.calendar_month),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.alarm_rounded),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.people),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      // TODO this does not seem to do anything
                      // width: 5,
                      ),
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Column(
              key: const Key("organizer-phone-number"),
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    Icon(Icons.phone),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Organizer's phone number")
                  ],
                ),
                const TextField(),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              key: const Key("invite-players"),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // TODO i should probably use that ttext with icon widget i have created
                    Icon(Icons.person_add_alt),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Invite players"),
                    SizedBox(
                      width: 10,
                    ),

                    IconButton(
                      onPressed: () {
                        devService.log("creating new text field");
                        _addInvitedPlayerTextField();
                      },
                      icon: Icon(Icons.add_circle_rounded),
                    )
                  ],
                ),

                for (final invitedPlayerTextField in _invitedPlayerTextFields)
                  invitedPlayerTextField
                // TextField(
                //     // decoration: InputDecoration(
                //     //   suffix: IconButton(
                //     //     icon: const Icon(Icons.add_circle_rounded),
                //     //     onPressed: () {
                //     //       // TODO this should programmatically add another input
                //     //       // or if the input already exists, there is value in it, we render the icon button and remove icon, and also logic is remove
                //     //     },
                //     //   ),
                //     // ),
                //     )

                // ListView.builder(itemBuilder: (context, index) {
                //   return Container(
                //     child: _invitedPlayerTextFields[index],
                //   );
                // })

                // TextField(
                //   decoration: InputDecoration(
                //     suffix: IconButton(
                //       icon: const Icon(Icons.add_circle_rounded),
                //       onPressed: () {
                //         // TODO this should programmatically add another input
                //         // or if the input already exists, there is value in it, we render the icon button and remove icon, and also logic is remove
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        )),
      ),
    );
  }

  void _addInvitedPlayerTextField() {
    final controller = TextEditingController();
    final textField = TextField(
      controller: controller,
    );

    setState(() {
      _invitedPlayersControllers.add(controller);
      _invitedPlayerTextFields.add(textField);
    });
  }
}
