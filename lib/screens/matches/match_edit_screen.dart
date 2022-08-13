import 'package:five_on_four/features/users/doman/models/user.dart';
import 'package:five_on_four/features/users/presentation/controllers/users_controller.dart';
import 'package:five_on_four/services/dev/dev_service.dart';
import 'package:five_on_four/widgets/app_bar_popup_menu/app_bar_popup_menu.dart';
import 'package:flutter/material.dart';

class MatchEditScreen extends StatefulWidget {
  MatchEditScreen({Key? key}) : super(key: key);

  final UsersController _usersController = UsersController();

  @override
  State<MatchEditScreen> createState() => _MatchEditScreenState();
}

class _MatchEditScreenState extends State<MatchEditScreen> {
  List<User?> invitedUsers = [];

  final TextEditingController _matchNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _matchNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    devService
        .log("this is invited users: ${invitedUsers.map((u) => u?.nickname)}");
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
              controller: _matchNameController,
              style: Theme.of(context).textTheme.headline3,
              decoration: InputDecoration(
                hintText: "Name your match",
                hintStyle: Theme.of(context).textTheme.headline3,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // TODO test
            // TextButton(
            //     onPressed: () {
            //       DatePicker.showDatePicker(
            //         context,
            //         showTitleActions: true,
            //         minTime: DateTime(2018, 3, 5),
            //         maxTime: DateTime(2019, 6, 7),
            //         onChanged: (date) {
            //           print('change $date');
            //         },
            //         onConfirm: (date) {
            //           print('confirm $date');
            //         },
            //         currentTime: DateTime.now(),
            //       );
            //     },
            //     child: Text(
            //       'Date and time',
            //     )),
            const SizedBox(
              height: 30,
            ),
            // TODO test
            Row(
              children: <Widget>[
                Expanded(
                  // TODO this should be a button aynhow
                  // and the one below, too
                  child: TextField(
                    keyboardType: TextInputType.none,
                    // onTap: () {
                    //   DatePicker.showDatePicker(
                    //     context,
                    //     showTitleActions: true,
                    //     minTime: DateTime(2018, 3, 5),
                    //     maxTime: DateTime(2019, 6, 7),
                    //     onChanged: (date) {
                    //       devService.log('change $date');
                    //     },
                    //     onConfirm: (date) {
                    //       devService.log('confirm $date');
                    //     },
                    //     currentTime: DateTime.now(),
                    //   );
                    // },
                    decoration: InputDecoration(
                        icon: Icon(Icons.calendar_month),
                        hintText: "Date and time"),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.timelapse), hintText: "Duration"),
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
                        _addInvitedPlayerAutocomplete();
                      },
                      icon: Icon(Icons.add_circle_rounded),
                    )
                  ],
                ),
                for (final user in invitedUsers)
                  _renderSingleUserAutocomplete(user),
                SizedBox(
                  height: 200,
                )
              ],
            ),
          ],
        )),
      ),
    );
  }

  void _addInvitedPlayerAutocomplete() {
    // check if any of the users in the array is null

    final nullUser = invitedUsers.any((element) => element == null);

    if (nullUser == true) {
      return;
    }

    // now we know that no users are null, so we can add a new element
    final newUsers = [...invitedUsers, null];

    setState(() {
      invitedUsers = newUsers;
    });
  }

  void _removeInvitedUserAutocomplete(
      User? user, TextEditingController autocompleteController) {
    // final users = invitedUsers.where((element) => element != user).toList();
    final users = invitedUsers.where((element) {
      return element != user;
    }).toList();

    devService.log(
        "printing elements remaining after filtering out removed user: ${users.map((u) => u?.nickname)}");

    // autocompleteController.dispose();
    setState(() {
      invitedUsers = users;
    });
  }

  Widget _renderSingleUserAutocomplete(User? user) {
    devService.log("this is user in render single user: ${user?.nickname}");
    final autocomplete = Autocomplete<User>(
      key: Key(user?.nickname ?? "null-user"),
      initialValue: TextEditingValue(text: user?.nickname ?? ""),
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return [];
        }

        final users = await widget._usersController
            .searchUsersByNickname(textEditingValue.text);
        return users;
      },
      displayStringForOption: (option) {
        return option.nickname;
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController fieldTextEditingController,
        FocusNode fieldFocusNode,
        VoidCallback onFieldSubmitted,
      ) {
        devService
            .log("this is controller: ${fieldTextEditingController.text}");

        devService.log("this is hash: ${fieldTextEditingController.hashCode}");

        // fieldTextEditingController.text = user?.nickname ?? "";
        // fieldTextEditingController.value = TextEditingValue()

        return Row(
          children: [
            Icon(Icons.cloud_circle),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: fieldTextEditingController,
                focusNode: fieldFocusNode,
                style: const TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    suffix: IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () {
                    _removeInvitedUserAutocomplete(
                        user, fieldTextEditingController);
                  },
                )),
              ),
            ),
          ],
        );
      },
      onSelected: (selection) {
        // devService.log("selection: ${selection.nickname}");

        final users = invitedUsers;

        User? foundUser = users.firstWhere((element) => element == user);

        devService.log("this is selection: $selection");
        devService.log("this is found user: $foundUser");
        devService.log("are they same?: ${foundUser == user}");

        // now i have to set user to this

        foundUser = selection;

        final indexOfUser = users.indexWhere((element) => element == user);

        users[indexOfUser] = selection;

        devService.log("index of current user in users: $indexOfUser");

        devService.log("users after user adjust: $users");

        setState(() {
          invitedUsers = users;
        });
      },
    );

    return autocomplete;
  }
}
