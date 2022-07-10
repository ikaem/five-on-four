import 'dart:convert';

class Match {
  final String id;
  final String date;
  final String name;
  final String time;
  // TODO this will probably be google coordinates later
  final String location;
  final int maxPlayers;
  final String description;
  final String organizerPhoneNumber;
// TODO will need to create model for players later
// inivted; joined, waiting list, declined - need to make statuses for those, too
  List<String> players;

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

final List<dynamic> parsedJson = jsonDecode(testJson);

final testList = parsedJson.map<Match>((m) {
  return Match.fromJson(m);
}).toList();

const testJson =
    '[{"id":"f2a32020-754f-4d7a-9d2d-f8f6f56528af","name": "Random match name","date":"7/1/2022","time":"12:18 AM","location":"Lacabamba","maxPlayers":12,"description":"Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.","organizerPhoneNumber":"844-746-3989","players":["Nélie","Dorothée","Anaël","Börje"]},{"id":"0dc67337-372a-4cea-ab43-e895009a2fe2","name": "Random match name","date":"8/16/2021","time":"10:07 PM","location":"Křenovice","maxPlayers":12,"description":"Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.","organizerPhoneNumber":"871-116-8612","players":["Maëline","Börje","Mà","Solène"]}, {"id":"c72c5af0-2e2a-49fc-9185-a456b91289ad","name": "Random match name","date":"5/10/2022","time":"4:41 AM","location":"Santa Rosa","maxPlayers":8,"description":"Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.","organizerPhoneNumber":"855-747-9838","players":["Léana","Pélagie","Andréa","Måns"]}, {"id":"43cd399f-3bcb-459d-962e-968932b92d8c","name": "Random match name","date":"11/19/2021","time":"7:05 PM","location":"Lama","maxPlayers":9,"description":"Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.","organizerPhoneNumber":"183-616-9808","players":["Maëlla","Mélodie","Irène","Aimée"]}, {"id":"3ec0300c-efbc-4d84-89e8-566d28daf887","name": "Random match name","date":"7/11/2021","time":"2:31 PM","location":"Pavia","maxPlayers":11,"description":"In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.","organizerPhoneNumber":"557-582-9659","players":["Léonie","Laurène","Josée","Josée"]}]';
