import 'dart:convert';

import 'package:five_on_four/features/matches/data/repositories/database/constants.dart';

class Match {
  late final int id;
  late final String date;
  late final String name;
  late final String time;
  // TODO this will probably be google coordinates later
  late final String location;
  late final int maxPlayers;
  late final String description;
  late final String organizerPhoneNumber;
// TODO will need to create model for players later
// inivted; joined, waiting list, declined - need to make statuses for those, too
  late final List<String> players;

  Match({
    required this.id,
    required this.date,
    required this.name,
    required this.time,
    required this.location,
    required this.maxPlayers,
    required this.description,
    required this.organizerPhoneNumber,
    required this.players,
  });

  // named cosntructor could return - this is just example to have both
  // which is better
  Match.fromDbRow(Map<String, Object?> row) {
    id = row[MatchColumn.id] as int;
    date = row[MatchColumn.date] as String;
    time = row[MatchColumn.time] as String;
    name = row[MatchColumn.name] as String;
    location = row[MatchColumn.location] as String;
    maxPlayers = row[MatchColumn.maxPlayers] as int;
    description = row[MatchColumn.description] as String;
    organizerPhoneNumber = row[MatchColumn.phoneNumber] as String;
    // TODO tis should probably be of some player type - so then just get all players data?
    //
    players = row[MatchColumn.players] as List<String>;
  }

// TODO factory does not necessarily have to return instance of the class
// TODO this is probably not a good choice to use factory constructor here - we need new instance, so shoukld use named cosntrutor
  factory Match.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final date = json['date'];
    final name = json['name'];
    final time = json['time'];
    final location = json['location'];
    final maxPlayers = json['maxPlayers'];
    final description = json['description'];
    final organizerPhoneNumber = json['organizerPhoneNumber'];
    // print('json players: ${json["players"]}');

    Iterable players = json["players"];
    // print("palyers again: $players");

    List<String> newPlayers = players.map<String>((p) {
      return p.toString();
    }).toList();

    return Match(
      id: id,
      name: name,
      date: date,
      time: time,
      location: location,
      maxPlayers: maxPlayers,
      description: description,
      organizerPhoneNumber: organizerPhoneNumber,
      players: newPlayers,
    );
  }
}

// TODO just for intial mock in dev
final List<dynamic> parsedJson = jsonDecode(testJson);

final testList = parsedJson.map<Match>((m) {
  return Match.fromJson(m);
}).toList();

const testJson =
    '[{"id": 1,"name": "Random match name","date":"7/1/2022","time":"12:18 AM","location":"Lacabamba","maxPlayers":12,"description":"Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.","organizerPhoneNumber":"844-746-3989","players":["Nélie","Dorothée","Anaël","Börje"]},{"id": 2,"name": "Random match name","date":"8/16/2021","time":"10:07 PM","location":"Křenovice","maxPlayers":12,"description":"Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.","organizerPhoneNumber":"871-116-8612","players":["Maëline","Börje","Mà","Solène"]}, {"id": 3,"name": "Random match name","date":"5/10/2022","time":"4:41 AM","location":"Santa Rosa","maxPlayers":8,"description":"Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.","organizerPhoneNumber":"855-747-9838","players":["Léana","Pélagie","Andréa","Måns"]}, {"id": 4,"name": "Random match name","date":"11/19/2021","time":"7:05 PM","location":"Lama","maxPlayers":9,"description":"Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.","organizerPhoneNumber":"183-616-9808","players":["Maëlla","Mélodie","Irène","Aimée"]}, {"id": 5,"name": "Random match name","date":"7/11/2021","time":"2:31 PM","location":"Pavia","maxPlayers":11,"description":"In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.","organizerPhoneNumber":"557-582-9659","players":["Léonie","Laurène","Josée","Josée"]}]';
