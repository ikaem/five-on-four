import 'package:date_time_picker/date_time_picker.dart';
import 'package:five_on_four/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:five_on_four/features/matches/presentation/controllers/matches_controller.dart';
import 'package:five_on_four/features/users/domain/models/user.dart';
import 'package:five_on_four/features/users/presentation/controllers/users_controller.dart';
import 'package:five_on_four/navigation/app_router.dart';
import 'package:five_on_four/services/dev/dev_service.dart';
import 'package:five_on_four/widgets/app_bar_popup_menu/app_bar_popup_menu.dart';
import 'package:flutter/material.dart';

class MatchEditScreen extends StatefulWidget {
  MatchEditScreen({Key? key}) : super(key: key);

  final UsersController _usersController = UsersController();
  final AuthController _authController = AuthController();

  @override
  State<MatchEditScreen> createState() => _MatchEditScreenState();
}

class _MatchEditScreenState extends State<MatchEditScreen> {
  User? currentUser;

  List<User?> _invitedUsers = [];
  final _formKey = GlobalKey<FormState>();
  final _matchesController = MatchesController();

  final TextEditingController _matchNameController = TextEditingController();
  final TextEditingController _dateTimeController =
      TextEditingController(text: "");
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _maxPlayersController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _organizerPhoneNumberController =
      TextEditingController();

  @override
  void initState() {
    // this is if we want the datetiem input to intially show something
    // _dateTimeController.value =
    //     TextEditingValue(text: DateTime.now().toString());

    super.initState();
  }

  @override
  void dispose() {
    _matchNameController.dispose();
    _dateTimeController.dispose();
    _durationController.dispose();
    _locationController.dispose();
    _maxPlayersController.dispose();
    _descriptionController.dispose();
    _organizerPhoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO test - this is probably not the best practice

    final User? user = widget._authController.authState(context)?.user;

    devService
        .log("THIS IS USER FROM INHERITED WIDGET PROVIDER: ${user?.nickname}");
    devService.log(
        "this is value in the datetime controller: ${_dateTimeController.text}");

    devService
        .log("this is invited users: ${_invitedUsers.map((u) => u?.nickname)}");
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
            child: Form(
          key: _formKey,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                key: Key("form-input-match-name"),
                controller: _matchNameController,
                style: Theme.of(context).textTheme.headline3,
                decoration: InputDecoration(
                  hintText: "Name your match",
                  hintStyle: Theme.of(context).textTheme.headline3,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Match name is required";
                  }

                  return null;
                },
              ),

// TODO old
              // TextField(
              //   controller: _matchNameController,
              //   style: Theme.of(context).textTheme.headline3,
              //   decoration: InputDecoration(
              //     hintText: "Name your match",
              //     hintStyle: Theme.of(context).textTheme.headline3,
              //   ),
              // ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              // TODO test
              DateTimePicker(
                type: DateTimePickerType.dateTime,
                dateMask: 'd MMMM, yyyy - hh:mm a',
                controller: _dateTimeController,
                //initialValue: _initialValue,
                // TODO
                /* 
                but this does not solve issue of time not being correct 
                so this should be handled 
                manually somehow
                to create date now now if time before now
                and it should be validated properyl in the controller maybe, or in the handler for create in UI
                 */
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                //icon: Icon(Icons.event),
                // dateLabelText: 'Date Time',
                dateHintText: 'Match date and time',
                use24HourFormat: false,
                locale: Locale('en', 'US'),
                // onChanged: (val) => setState(() => _valueChanged2 = val),
                icon: Icon(Icons.calendar_month),
                validator: (val) {
                  // setState(() => _valueToValidate2 = val ?? '');
                  if (val == null || val.isEmpty) {
                    return "Match date and time are requuired";
                  }
                  return null;
                },
                // onSaved: (val) => setState(() => _valueSaved2 = val ?? ''),
              ),
              TextFormField(
                controller: _durationController,
                decoration: InputDecoration(
                  icon: Icon(Icons.timelapse),
                  hintText: "Duration",
                  suffix: Text("hours"),
                ),
                keyboardType: TextInputType.number,
                // TODO this could be a function
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Match duration is required";
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  icon: Icon(Icons.location_on),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Match location is required";
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                key: Key("match-max-players"),
                controller: _maxPlayersController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: Icon(Icons.numbers),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Match players limit is required";
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 60,
              ),
              TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Match description is required";
                  }

                  return null;
                },
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
                  TextFormField(
                    controller: _organizerPhoneNumberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Match organizer's phone number is required";
                      }

                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              // Checkbox(
              //   value: true,
              //   onChanged: (isChecked) {
              //     devService.log("checkbox is checked: $isChecked");
              //   },
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: Checkbox(
                      value: true,
                      onChanged: (isChecked) {
                        devService.log("checkbox is checked: $isChecked");
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text("Join match"),
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
                  for (final user in _invitedUsers)
                    _renderSingleUserAutocomplete(user),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      devService.log("Submitting new match");
                      _handleSubmitNewMatch();
                    },
                    child: Text("Create match"),
                    style: TextButton.styleFrom(
                        primary: Colors.white, backgroundColor: Colors.blue),
                  ),
                  TextButton(
                    onPressed: () {
                      devService.log("Submitting new match");
                    },
                    child: Text("Cancel"),
                    style: TextButton.styleFrom(
                        primary: Colors.white, backgroundColor: Colors.black),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }

  void _handleSubmitNewMatch() async {
    final state = _formKey.currentState;
    if (state == null) return;

    devService.log("tis is form state: ${state}");
    // TODO this will redraw widget it things are not valid
    final isFormValid = state.validate();

    if (isFormValid == false) return;

    int? matchId;

    devService.log("Now we are creating new match");

    // todo should probably have a function to format all this nicely and pass on to the controller?
    // or maybe controller can handle formatting, converting to date, time, milliseconds and so on, grab only ids from users and so on...

    final matchName = _matchNameController.text;
    final matchDateTime = _dateTimeController.text;
    final matchDuration = _durationController.text;
    final matchLocation = _locationController.text;
    final matchMaxPlayers = _maxPlayersController.text;
    final matchDescription = _descriptionController.text;
    final matchOrganizerPhoneNumber = _organizerPhoneNumberController.text;

    final invitedUsers = _invitedUsers;

    final messageForShow = '''
      matchName: $matchName, 
      matchDateTime: $matchDateTime,
      matchDuration: $matchDuration,
      matchLocation: $matchLocation,
      matchMaxPlayers: $matchMaxPlayers,
      matchDescription: $matchDescription,
      matchOrganizerPhoneNumber: $matchOrganizerPhoneNumber,
      invitedUsers: ${_invitedUsers.map((u) => u?.id)}
      ''';

    devService.log(messageForShow);

// TODO where should error handling happen? - here or in the controller?

    try {
      matchId = await _matchesController.createMatch(
        matchName: matchName,
        matchDateTime: matchDateTime,
        matchDuration: matchDuration,
        matchLocation: matchLocation,
        matchMaxPlayers: matchMaxPlayers,
        matchDescription: matchDescription,
        matchOrganizerPhoneNumber: matchOrganizerPhoneNumber,
        matchInvitedUsers: invitedUsers,
      );

      // AppRouter.toMatch(context, matchId);
      // routeToMatch(context, matchId);
    } catch (e) {
      devService.log("this is error: $e");
    }

    if (matchId == null) return;
    // TODO return to this
    // make app router class taht actually returns instance, and intiailize it before get to this async gaps, so cotnext is defined earlier
    AppRouter.toMatch(context, matchId);
  }

  void _addInvitedPlayerAutocomplete() {
    // check if any of the users in the array is null

    final nullUser = _invitedUsers.any((element) => element == null);

    if (nullUser == true) {
      return;
    }

    // now we know that no users are null, so we can add a new element
    final newUsers = [..._invitedUsers, null];

    setState(() {
      _invitedUsers = newUsers;
    });
  }

  void _removeInvitedUserAutocomplete(
      User? user, TextEditingController autocompleteController) {
    // final users = invitedUsers.where((element) => element != user).toList();
    final users = _invitedUsers.where((element) {
      return element != user;
    }).toList();

    devService.log(
        "printing elements remaining after filtering out removed user: ${users.map((u) => u?.nickname)}");

    // autocompleteController.dispose();
    setState(() {
      _invitedUsers = users;
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

// TODO here should create a function to filter out any user that might already be added
// TODO this is pretty naive, loop withing loop - should probably handle it better

        final filteredUsers = users.where((userForInvite) {
          // TODO this is loop in a loop - this will lag a lot when a lot of users
          // so should probably solve this in future by passing a list of invited ids to the query, so sql can handle that with something like NOT ANY (LIST OF Ids)

          final isUserAlreadyInvited = _invitedUsers
              .any((invitedUser) => invitedUser?.id == userForInvite.id);

          if (isUserAlreadyInvited) return false;

          return true;
        });

        return filteredUsers;
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
        return Row(
          children: [
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
        final users = _invitedUsers;

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
          _invitedUsers = users;
        });
      },
    );

    return autocomplete;
  }
}
