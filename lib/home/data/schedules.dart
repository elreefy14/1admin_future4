import 'package:admin_future/registeration/data/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleModel {

  String? branchId;
  Timestamp? startTime;
  Timestamp? endTime;
  Timestamp? nearestDay;
  Timestamp? nearestDayUser;
  String? date;

  bool? finished;
  List<String?>? usersList;
  List<String?>? coachList;
  List<String?>? coachIds;
  List<String?>? userIds; // new field
  // new field

  String? scheduleId;
  String? pId;
//maxUsers
  String? maxUsers;
  //group_id
  String? group_id;
  List<UserModel>? users;
  ScheduleModel({
    required this.pId,
    required this.branchId,
    required this.startTime,
    required this.endTime,
    required this.finished,
    //  List<String?>? coachList;
    //List<String?>? coachIds;
    this.coachList,
    this.coachIds,
    this.usersList,
    this.userIds, // new field
    this.scheduleId,
    this.date,
    required this.nearestDay,
    this.nearestDayUser,

    List<UserModel>? users, this.maxUsers
    , this.group_id


  });

  Map<String, dynamic> toJson2() {
    return {
      'branch_id': branchId,
      'start_time': startTime,
      'end_time': endTime,
      'finished': finished,
      'usersList': usersList,
      'userIds': userIds, // new field
      //  List<String?>? coachList;
//  List<String?>? coachIds;
      'coachList': coachList,
      'coachIds': coachIds,
      'nearest_day': nearestDay,
      'nearest_day_user': nearestDay,
      'schedule_id': scheduleId,
      'date': date,
      'pId': pId,
      'users': users,
      'maxUsers': maxUsers,
      'group_id': group_id,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'pId': pId,
      'branch_id': branchId,
      'start_time': startTime?.toDate().toIso8601String(),
      'end_time': endTime?.toDate().toIso8601String(),
      'finished': finished,
      'userIds': userIds, // new field
      'schedule_id': scheduleId,
      'date': date,
      'nearest_day': nearestDay,
      'nearest_day_user': nearestDay,
      'users': users,
      'maxUsers': maxUsers,
      'coachList': coachList,
      'coachIds': coachIds,
      'group_id': group_id,
    };
  }

  factory ScheduleModel.fromJson2(Map<String, dynamic> json) {
    return ScheduleModel(
      branchId: json['branch_id'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      pId: json['pId'],
      finished: json['finished'],
      usersList: json['usersList'] != null ? List<String>.from(json['usersList']) : null,
      userIds: json['userIds'] != null ? List<String>.from(json['userIds']) : null, // new field
      nearestDay: json['nearest_day'],
      nearestDayUser: json['nearest_day_user'],
      scheduleId: json['schedule_id'],
      date: json['date'],
      //group_id
      group_id: json['group_id'],
      users: json['users'] != null ? List<UserModel>.from(json['users'].map((x) => UserModel.fromJson(x))) : null,
      maxUsers: json['maxUsers'],
      coachList: json['coachList'] != null ? List<String>.from(json['coachList']) : null,
      coachIds: json['coachIds'] != null ? List<String>.from(json['coachIds']) : null,


    );
  }

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      pId: json['pId'],
      branchId: json['branch_id'],
      nearestDay: json['nearest_day'] != null ? Timestamp.fromMillisecondsSinceEpoch((json['nearestDay'] as Timestamp).millisecondsSinceEpoch) : null,
      nearestDayUser: json['nearest_day_user'] != null ? Timestamp.fromMillisecondsSinceEpoch((json['nearestDay'] as Timestamp).millisecondsSinceEpoch) : null,
      startTime: json['start_time'] != null ? Timestamp.fromMillisecondsSinceEpoch(DateTime.parse(json['start_time']).millisecondsSinceEpoch) : null,
      endTime: json['end_time'] != null ? Timestamp.fromMillisecondsSinceEpoch(DateTime.parse(json['end_time']).millisecondsSinceEpoch) : null,
      finished: json['finished'],
      userIds: json['userIds'] != null ? List<String>.from(json['userIds']) : null, // new field
      scheduleId: json['schedule_id'],
      date: json['date'],
      users: json['users'] != null ? List<UserModel>.from(json['users'].map((x) => UserModel.fromJson(x))) : null,
      maxUsers: json['maxUsers'],
      coachList: json['coachList'] != null ? List<String>.from(json['coachList']) : null,
      coachIds: json['coachIds'] != null ? List<String>.from(json['coachIds']) : null,
      //group_id
      group_id: json['group_id'],
    );
  }
}
