// TODO player will effectively be an app user's membership on a match
import 'dart:convert';

class Player {
  final String id;
  final String nickname;
  // TODO this shold later be some kind of enum type
  final String matchStatus;

  Player({
    required this.id,
    required this.nickname,
    required this.matchStatus,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final nickname = json["nickname"];
    final matchStatus = json["match_status"];

    return Player(
      id: id,
      nickname: nickname,
      matchStatus: matchStatus,
    );
  }
}

final List<dynamic> parsedJson = jsonDecode(mockPlayersJson);
final mockPlayers = parsedJson.map<Player>((p) => Player.fromJson(p)).toList();

const mockPlayersJson =
    '[{"id": "fb4d4b89-f95d-4074-9786-2fafd3016387","nickname": "cmaddy0","match_status": "on_waiting_list"},{"id": "050e5f1b-f73c-434b-aa9d-2a1af66b69ed","nickname": "ovasyushkhin1","match_status": "invited"},{"id": "9dc09567-bc74-4e3e-91f0-7db60a4de015","nickname": "bpowter2","match_status": "invited"},{"id": "65f51280-1b5e-4496-b4f9-810036501463","nickname": "ependergrast3","match_status": "invited"},{"id": "bc559595-2da8-405d-a86c-a24c79e29e3c","nickname": "tnoyes4","match_status": "on_waiting_list"},{"id": "d6445d0b-ffea-4791-884a-d852675fed56","nickname": "garlidge6","match_status": "on_waiting_list"},{"id": "ebaf0e1d-ec39-4f96-9a85-71e9f0323927","nickname": "mmccorkindale7","match_status": "on_waiting_list"},{"id": "c2d4f0e7-cb97-4f18-9ae9-b0457b0549a7","nickname": "rlutzmann8","match_status": "joined"},{"id": "20cb130c-9d8b-427d-bd4b-ccb0818a0d5b","nickname": "smoscon9","match_status": "joined"}]';
