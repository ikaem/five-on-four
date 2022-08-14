import 'package:date_time_picker/date_time_picker.dart';
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
  List<User?> _invitedUsers = [];

  final _formKey = GlobalKey<FormState>();

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
                firstDate: DateTime(2000),
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
                controller: _maxPlayersController,
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

  void _handleSubmitNewMatch() {
    final state = _formKey.currentState;
    if (state == null) return;

    devService.log("tis is form state: ${state}");
    // TODO this will redraw widget it things are not valid
    final isFormValid = state.validate();

    if (isFormValid == false) return;

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
      ''';

    devService.log(messageForShow);
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
