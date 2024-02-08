import 'package:cloud_firestore/cloud_firestore.dart';

class DayModel {
  final String name;
  final Timestamp timestamp;

  DayModel({required this.name, required this.timestamp});
}