import 'dart:convert';
import 'dart:developer' as devtools show log;

class DevService {
  final JsonEncoder jsonEncoder = const JsonEncoder();

  void log(Object message) {
    devtools.log(jsonEncoder.convert(message));
  }
}

DevService devService = DevService();
