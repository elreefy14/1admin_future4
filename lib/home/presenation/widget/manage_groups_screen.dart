//
//use flutter_screenutil to make above ManageGroupsScreen responsive
//instead of height: 160 ,use height: 160.h,
//instead of width: 155, use width: 155.w,
//instead of SizedBox(height: 20), use SizedBox(height: 20.h),
//instead of SizedBox(width: 20), use SizedBox(width: 20.w),
//instead of fontSize: 16, use fontSize: 16.sp,
//instead of fontSize: 18, use fontSize: 18.sp, and so on for all sizes in the app
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/flutter_flow/flutter_flow_theme.dart';
import '../../../registeration/data/userModel.dart';
import '../../../manage_users_coaches/business_logic/manage_users_cubit.dart';

class BranchList extends StatelessWidget {
  const BranchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Call the function to get branches
    final manageSalaryCubit = ManageUsersCubit.get(context);
    // manageSalaryCubit.getBranches();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 65.h,
      decoration: BoxDecoration(
        color: Color.fromARGB(0, 195, 162, 162),
        border: Border.all(
          color: Colors.blue,
        ),
      ),
      child: BlocBuilder<ManageUsersCubit, ManageUsersState>(
        builder: (context, state) {
          // Check if branches are loaded
          if (manageSalaryCubit.branches.isEmpty) {
            return CircularProgressIndicator(); // Show a loading indicator while branches are being fetched
          } else {
            return ListView.builder(
              cacheExtent: 100,
              scrollDirection: Axis.horizontal,
              itemCount: manageSalaryCubit.branches.length,
              itemBuilder: (context, index) {
                final branch = manageSalaryCubit.branches[index];
                return GestureDetector(
                  onTap: () {
                    print('branch id is ${branch.name}\n\n\n\n\n\n');
                    manageSalaryCubit.changeSelectedBranchIndex(index);
                  },
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Container(
                      width: 95.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: manageSalaryCubit.selectedBranchIndex == index
                            ? Colors.blue
                            : Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(8),
                        shape: BoxShape.rectangle,
                      ),
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        branch.name ?? '',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color:
                                  manageSalaryCubit.selectedBranchIndex == index
                                      ? Color(0xFFF4F4F4)
                                      : Colors.black,
                              fontSize: 14.sp,
                            ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class BranchModel {
  String? name;

  BranchModel({
    this.name,
  });

  BranchModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name ?? '';
    return data;
  }
}

class GroupModel {
  final Map<String, Map<String, Timestamp>> days;
  final String groupId;
  final String maxUsers;
  final String name;
  final int numberOfCoaches;
  final int numberOfUsers;
  final String pid;

  //schedule_ids
  final List<String> schedulesIds;

//schedule_days
  final List<String> schedulesDays;

  // 'usersList': FieldValue.arrayUnion([user.name]),
  //                 'userIds': FieldValue.arrayUnion([user.uId]),
  //         'schedule_ids': FieldValue.arrayUnion([scheduleRef.id]),
  //               'schedule_days': FieldValue.arrayUnion([day]),
//  'coachList': FieldValue.arrayUnion([coach.name]),
//  'coachIds': FieldValue.arrayUnion([coach.uId]),
  final List<String> coachIds;
  final List<String> coachList;
  final List<String> userIds;
  final List<String> usersList;
  final List<UserModel> users;
  final List<UserModel> coaches;

  GroupModel({
    required this.days,
    required this.groupId,
    required this.maxUsers,
    required this.name,
    required this.numberOfCoaches,
    required this.numberOfUsers,
    required this.pid,
    required this.schedulesIds,
    required this.schedulesDays,
    required this.coachIds,
    required this.coachList,
    required this.userIds,
    required this.usersList,
    required this.users,
    required this.coaches,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    final daysJson = json['days'] as Map<String, dynamic>;
    final days = <String, Map<String, Timestamp>>{};

    daysJson.forEach((key, value) {
      days[key] = {
        'start': value['start'],
        'end': value['end'],
      };
    });

    return GroupModel(
      days: days,
      groupId: json['group_id'],
      maxUsers: json['max_users'],
      name: json['name'],
      numberOfCoaches: json['number_of_coaches'],
      numberOfUsers: json['number_of_users'],
      pid: json['pid'],
      schedulesIds: json['schedule_ids']?.cast<String>() ?? [],
      schedulesDays: json['schedule_days']?.cast<String>() ?? [],
      // 'usersList': FieldValue.arrayUnion([user.name]),
      //                 'userIds': FieldValue.arrayUnion([user.uId]),
      //         'schedule_ids': FieldValue.arrayUnion([scheduleRef.id]),
      //               'schedule_days': FieldValue.arrayUnion([day]),
//  'coachList': FieldValue.arrayUnion([coach.name]),
//  'coachIds': FieldValue.arrayUnion([coach.uId]),
      coachIds: json['coachIds']?.cast<String>() ?? [],
      coachList: json['coachList']?.cast<String>() ?? [],
      userIds: json['userIds']?.cast<String>() ?? [],
      usersList: json['usersList']?.cast<String>() ?? [],
      users: (json['users'] as List<dynamic>?)
              ?.map((json) => UserModel.fromJson(json))
              .toList() ??
          [],
      coaches: (json['coaches'] as List<dynamic>?)
              ?.map((json) => UserModel.fromJson(json))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    final daysJson = <String, dynamic>{};

    days.forEach((key, value) {
      daysJson[key] = {
        'start': value['start'],
        'end': value['end'],
      };
    });

    return {
      'days': daysJson,
      'group_id': groupId,
      'max_users': maxUsers,
      'name': name,
      'number_of_coaches': numberOfCoaches,
      'number_of_users': numberOfUsers,
      'pid': pid,
      'schedule_ids': schedulesIds,
      'schedule_days': schedulesDays,
      'coachIds': coachIds,
      'coachList': coachList,
      'userIds': userIds,
      'usersList': usersList,
      'users': users,
      'coaches': coaches,
    };
  }
}
