import 'package:flutter/foundation.dart';

class Task {
  String id;
  String description;
  DateTime time;

  Task({
    @required this.id,
    @required this.description,
    @required this.time,
  });
}
