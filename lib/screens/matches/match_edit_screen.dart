// TODO temp stateless widget
import 'package:five_on_four/features/users/doman/models/user.dart';
import 'package:five_on_four/features/users/presentation/controllers/users_controller.dart';
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

// TODO test
// class InvitedUserController {
//   User? user;

// }

class _MatchEditScreenState extends State<MatchEditScreen> {
// TODO another test
  List<User?> invitedUsers = [];

  // TODO test
  List<User> _matchingUsersForInvite = [];

  UsersController _usersController = UsersController();

  List<TextEditingController> _invitedPlayersControllers = [];
  List<TextField> _invitedPlayerTextFields = [];

  TextEditingController _testAutocompleteController = TextEditingController();

  // TODO test
  TextEditingController _testControllerForOnChangedInput =
      TextEditingController();

  @override
  void initState() {
    // _testControllerForOnChangedInput.addListener(() async {
    //   // devService.log(_testControllerForOnChangedInput.text);

    //   await Future.delayed(Duration(milliseconds: 500));

    //   final input = _testControllerForOnChangedInput.text;

    //   final users = await _usersController.searchUsersByNickname(input);

    //   // devService.log("this is users: $users");

    //   // devService.log("this is lenght: ${users.length}");

    //   for (var user in users) {
    //     // devService.log("user name: ${user.nickname}");
    //   }
    // });

    super.initState();
  }

  @override
  void dispose() {
// TODO will need to dispose of all other conttrollers too

    for (final controller in _invitedPlayersControllers) {
      controller.dispose();
    }

    _testControllerForOnChangedInput.dispose();

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

// TODO test from here

            // for (final user in invitedUsers)
            //   _renderSingleUserAutocomplete(user),

// TODO test to here

            // _renderOnChangedValueAutocomplete(),
            _renderTestInputFetchOnType(),
            _renderInvitedPlayerAutocomplete(),
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
                        // devService.log("creating new text field");
                        // _addInvitedPlayerTextController();
                        _addInvitedPlayerAutocomplete();
                      },
                      icon: Icon(Icons.add_circle_rounded),
                    )
                  ],
                ),

/*                 for (final controller in _invitedPlayersControllers)
                  _renderInvitedPlayerTextField(controller) */

                for (final user in invitedUsers)
                  _renderSingleUserAutocomplete(user),

                SizedBox(
                  height: 200,
                )

                // _invitedPlayerTextFields.map((f) {
                //   return f;
                // }).toList(),
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

  // void _doSomethingOnEachInputType () {
  //   print
  // }

  Widget _renderTestInputFetchOnType() {
    return Column(
      key: const Key("fetch-on-type-test"),
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.construction),
            SizedBox(
              width: 10,
            ),
            Text("Test fetch")
          ],
        ),
        TextField(
          // onChanged: (value) {
          //   devService.log(value);
          // },
          controller: _testControllerForOnChangedInput,
        ),
      ],
    );
  }

  Widget _renderOnChangedValueAutocomplete() {
// TODO test
    List<User> testUsers = [];

    final autocomplete = Autocomplete<User>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        // devService.log("this is test users in options builder: $testUsers");
        // devService.log(
        //     "this is text editing value in options builder: $textEditingValue");

        if (textEditingValue.text.isEmpty) {
          return [];
        }

        final users =
            await _usersController.searchUsersByNickname(textEditingValue.text);
        return users;

        // return testUsers;
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
        // devService.log("this is focus: ${fieldFocusNode.hasFocus}");

        // fieldTextEditingController.addListener(() async {
        //   // devService.log(fieldTextEditingController.text);

        //   // await Future.delayed(Duration(milliseconds: 500));

        //   final input = fieldTextEditingController.text;

        //   if (input.isEmpty) {
        //     testUsers = [];
        //     // devService.log("this is set users: $testUsers");
        //     return;
        //   }

        //   final users = await _usersController.searchUsersByNickname(input);

        //   // devService.log("this is users: $users");

        //   // devService.log("this is lenght: ${users.length}");

        //   // for (var user in users) {
        //   //   devService.log("user name: ${user.nickname}");
        //   // }

        //   // setState(() {
        //   //   _matchingUsersForInvite = users;
        //   // });

        //   // devService.log("this is set users: $_matchingUsersForInvite");
        //   testUsers = users;
        //   // devService.log("this is set users: $testUsers");
        // });

        return Row(
          children: [
            Icon(Icons.construction),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: fieldTextEditingController,
                focusNode: fieldFocusNode,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
      onSelected: (selection) {
        // devService.log("selection: ${selection.nickname}");
      },
    );

    return autocomplete;
  }

  Widget _renderInvitedPlayerAutocomplete() {
    final autocomplete = Autocomplete<Country>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return countryOptions;
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        // devService.log("this is focus: ${fieldFocusNode.hasFocus}");

        return TextField(
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          style: const TextStyle(fontWeight: FontWeight.bold),
        );
      },
      onSelected: (selection) {
        // devService.log("selection: ${selection.name}");
      },
      // optionsViewBuilder: (
      //   BuildContext context,
      //   AutocompleteOnSelected<Country> onSelected,
      //   options,
      // ) {
      //   return Align(
      //     alignment: Alignment.topLeft,
      //     child: Container(
      //       child: ListView.builder(
      //           itemCount: options.length,
      //           itemBuilder: (context, index) {
      //             // TODO options is iterable, so need element at
      //             final country = options.elementAt(index);
      //             return Text(country.name);
      //           }),
      //     ),
      //   );
      // },
    );

    // return autocomplete;

    return Stack(
      children: [
        Positioned(
          child: autocomplete,
          // right: 0,
          // bottom: 15,
        ),
      ],
    );
  }

// and now we render text field for
  TextField _renderInvitedPlayerTextField(TextEditingController controller) {
    final textField = TextField(
      controller: controller,
      decoration: InputDecoration(
          suffix: IconButton(
        icon: const Icon(Icons.remove_circle),
        onPressed: () {
          _removeInvitedPlayerTextController(controller);
        },
      )),
    );

    return textField;
  }

// we are actually adding a controller
  void _addInvitedPlayerTextController() {
    final controller = TextEditingController();

    setState(() {
      // probably should not mutate it
      _invitedPlayersControllers.add(controller);
    });

    // devService.log("all controllers: $_invitedPlayersControllers");
    // devService.log("all fields: $_invitedPlayerTextFields");
  }

// TODO test
  void _removeInvitedPlayerTextController(TextEditingController controller) {
    // now find the text field
    // final controller = textField.controller;

// TODO not sure if this should come after removing it from list
    controller.dispose();

    final controllers =
        _invitedPlayersControllers.where((c) => c != controller).toList();

    // final textFields =
    //     _invitedPlayerTextFields.where((f) => f != textField).toList();

    setState(() {
      // _invitedPlayerTextFields = textFields;
      _invitedPlayersControllers = controllers;
      //
    });
  }

  /////////////// TODO from here function to render single autocomplete
  ///

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

        final users =
            await _usersController.searchUsersByNickname(textEditingValue.text);
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

class Country {
  const Country({
    required this.name,
    required this.size,
  });

  final String name;
  final int size;

  @override
  String toString() {
    return '$name ($size)';
  }
}

const List<Country> countryOptions = <Country>[
  Country(name: 'Africa', size: 30370000),
  Country(name: 'Asia', size: 44579000),
  Country(name: 'Australia', size: 8600000),
  Country(name: 'Bulgaria', size: 110879),
  Country(name: 'Canada', size: 9984670),
  Country(name: 'Denmark', size: 42916),
  Country(name: 'Europe', size: 10180000),
  Country(name: 'India', size: 3287263),
  Country(name: 'North America', size: 24709000),
  Country(name: 'South America', size: 17840000),
];
