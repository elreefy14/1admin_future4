import 'package:admin_future/add_grouup_of_schedules/presentation/select_coaches.dart';
  import 'package:admin_future/home/business_logic/Home/manage_attendence_cubit%20.dart';
  import 'package:admin_future/registeration/data/userModel.dart';

  import 'package:admin_future/home/presenation/widget/widget/custom_app_bar.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:flutter_svg/svg.dart';
  import 'package:fluttertoast/fluttertoast.dart';
  import 'package:provider/provider.dart';

  import '../../home/business_logic/Home/manage_attendence_state.dart';
  import '../../home/presenation/widget/add_schedule.dart';

class AddGroupCubit extends Cubit<AddGroupState> {
  var _searchController;
  //final String updatedMaxUsers;

  AddGroupCubit(
      //this.updatedMaxUsers
      )
      : super(AddGroupState(screens: [
    SelectCoachesScreen(
      isCoach: true,
    ),
    SelectCoachesScreen(
      isCoach: false,
    ),
    TimeSelectionScreen(),
    SelectBranchScreen(
      // maxUsers: updatedMaxUsers,
    ),
    InfoScreen()
  ]));

  final TextEditingController searchController = TextEditingController();
  bool isSearch = false;
  Query? usersQuery;
  Query? _query2;
  String? onSubmitted;
  List<String> selectedUsersUids = [];
  String? maxUsers;
  //final TextEditingController _searchController = TextEditingController();
  // Query? _query;
  int? numberOfQuery;
  List<String> selectedCoachesUids = [];
  //List<String> _selectedUsersUids = [];
  List<UserModel> selectedCoaches = [];
  List<UserModel> selectedUsers = [];
  static final Map<String, Map<dynamic, dynamic>> _times = {
    'السبت': {'start': null, 'end': null},
    'الأحد': {'start': null, 'end': null},
    'الاثنين': {'start': null, 'end': null},
    'الثلاثاء': {'start': null, 'end': null},
    'الأربعاء': {'start': null, 'end': null},
    'الخميس': {'start': null, 'end': null},
    'الجمعة': {'start': null, 'end': null},
  };
  //function to update _times
  void updateTimes(Map<String, Map<dynamic, dynamic>> times) {
    _times.addAll(times);
    emit(state.copyWith(times: _times));
  }

  Map<String, Map<dynamic, dynamic>> get times => _times;

  @override
  void initState(context) {
    //clear all these fields
    //            selectedUsers: context
    //     .read<AddGroupCubit>()
    //     .state
    //     .selectedUsers,
    // selectedCoaches: context
    //     .read<AddGroupCubit>()
    //     .state
    //     .selectedCoaches,
    // startTrainingTime: //random time
    //     Timestamp.now(),
    // endTrainingTime: //random time
    //     Timestamp.now(),
    // branch:
    // ManageAttendenceCubit.get(context)
    // .selectedBranch??'',
    // // 'error',
    // times: //call the times map from screen 2
    //     context.read<AddGroupCubit>().state.times,
    // //TODO : delete
    // //TODO : delete
    // //TODO : delete
    // //TODO : delete
    // //TODO : delete
    // //TODO : delete
    // //TODO : delete
    // //TODO : delete
    // //TODO : delete

    selectedCoaches = [];
    selectedUsers = [];
    selectedCoachesUids = [];
    selectedUsersUids = [];

    // maxUsers = null;
    _times['السبت'] = {'start': null, 'end': null};
    _times['الأحد'] = {'start': null, 'end': null};
    _times['الاثنين'] = {'start': null, 'end': null};
    _times['الثلاثاء'] = {'start': null, 'end': null};
    _times['الأربعاء'] = {'start': null, 'end': null};
    _times['الخميس'] = {'start': null, 'end': null};
    _times['الجمعة'] = {'start': null, 'end': null};
    ManageAttendenceCubit.get(context).updateSelectedBranch('');
    emit(
      state.copyWith(
        maxUsers: null,
        selectedUsers: List.empty(),
        selectedUsersUids: List.empty(),
        selectedCoaches: List.empty(),
        selectedBranch: null,

      ),
    );
  }

  Future<void> onSearchSubmitted(String value, bool isCoach) async {
    late Query newQuery;
    if (isCoach)
      newQuery = FirebaseFirestore.instance
          .collection('users')
          .orderBy('name')
          .startAt([value])
          .endAt([value + '\uf8ff'])
          .where('role', isEqualTo: 'coach')
          .limit(100);
    else
      newQuery = FirebaseFirestore.instance
          .collection('users')
          .orderBy('name')
          .startAt([value])
          .endAt([value + '\uf8ff'])
          .where('role', isEqualTo: 'user')
          .limit(100);

    QuerySnapshot querySnapshot =
    await newQuery.get(GetOptions(source: Source.serverAndCache));
    var numberOfQuery = querySnapshot.docs.length;
    print('number of query is $numberOfQuery');
    print(numberOfQuery);

    if (numberOfQuery == 0) {
      if (isCoach)
        newQuery = FirebaseFirestore.instance
            .collection('users')
            .where('phone', isGreaterThanOrEqualTo: value)
            .where('phone', isLessThan: value + 'z')
        //order by name
            .orderBy('phone', descending: false)
            .where('role', isEqualTo: 'coach')
            .limit(100);
      else
        newQuery = FirebaseFirestore.instance
            .collection('users')
            .where('phone', isGreaterThanOrEqualTo: value)
            .where('phone', isLessThan: value + 'z')
        //order by name
            .orderBy('phone', descending: false)
            .where('role', isEqualTo: 'user')
            .limit(100);
    }
    //update query
    updateQuery(newQuery);
  }

  // List<UserModel> _selectedCoaches = [];
  // List<UserModel> _selectedUsers = [];
  void selectUser(UserModel user) {
    //add user to selected users
    selectedUsers.add(user);
    emit(state.copyWith(selectedUsers: [...state.selectedUsers, user]));
  }

  void deselectUser(UserModel user) {
    //remove user from selected users
    // selectedUsers.removeWhere((u) => u.uId == user.uId);
    emit(state.copyWith(
        selectedUsers:
        state.selectedUsers.where((u) => u.uId != user.uId).toList()));
  }

  void selectCoach(UserModel coach) {
    selectedCoaches.add(coach);
    emit(state.copyWith(selectedCoaches: [...state.selectedCoaches, coach]));
  }

  void deselectCoach(UserModel coach) {
    print('deselectCoach');
    print(selectedCoaches.length);
    //selectedCoaches.remove(coach);
    //remove where uId != coach.uId
    //  selectedCoaches.removeWhere((c) => c.uId == coach.uId);
    emit(state.copyWith(
        selectedCoaches:
        //  state.selectedCoaches.where((c) => c != coach).toList()));
        state.selectedCoaches.where((c) => c.uId != coach.uId).toList()));
    print(selectedCoaches.length);
  }

  void selectTime(String time) {
    emit(state.copyWith(selectedTimes: [...state.selectedTimes, time]));
  }

  void deselectTime(String time) {
    emit(state.copyWith(
        selectedTimes: state.selectedTimes.where((t) => t != time).toList()));
  }

  void selectBranch(String branch) {
    emit(state.copyWith(selectedBranch: branch));
  }

  void selectOption(String option) {
    emit(state.copyWith(selectedOption: option));
  }

  void updateSelectedBranch(String branch) {
    emit(state.copyWith(selectedBranch: branch));
  }

  void updateSelectedCoaches(List<UserModel> coaches) {
    emit(state.copyWith(selectedCoaches: coaches));
  }

  void updateSelectedTimes(List<String> times) {
    emit(state.copyWith(selectedTimes: times));
  }

  void nextScreen(
      BuildContext context,
      ) {
    //delete keyBoard if it is open
    FocusScope.of(context).unfocus();
    int currentIndex = state.currentIndex;
    if (currentIndex < state.screens.length - 1) {
      emit(state.copyWith(currentIndex: currentIndex + 1));
    }
  }

  void previousScreen(
      BuildContext context,
      ) {
    FocusScope.of(context).unfocus();
    int currentIndex = state.currentIndex;
    if (currentIndex > 0) {
      emit(state.copyWith(currentIndex: currentIndex - 1));
    }
  }

  void setCurrentIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  void searchUsers(String query) {
    _query2 = usersQuery!
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff');
    emit(state.copyWith(searchQuery: query));
  }

  void clearSearch() {
    _query2 = null;
    _searchController.clear();
    emit(state.copyWith(searchQuery: null));
  }

  Stream<QuerySnapshot> getUsersStream() {
    if (_query2 != null) {
      return _query2!.snapshots();
    } else {
      return usersQuery!.snapshots();
    }
  }

  void selectUserUid(UserModel user) {
    selectedUsersUids.add(user.uId ?? '');
    emit(state.copyWith(selectedUsersUids: selectedUsersUids));
  }

  void deselectUserUid(UserModel user) {
    selectedUsersUids.remove(user);
    emit(state.copyWith(selectedUsersUids: selectedUsersUids));
  }

  void updateTime(String day, TimeOfDay endTime) {
    _times[day]?['end'] = endTime;
    _times[day]?['start'] = endTime.replacing(hour: endTime.hour - 1);
    emit(state.copyWith(times: _times));
  }
  //edit thais to add list of maps for branch collection contains schedule.date as key and schedule.id as value
  late Map<String, Map<dynamic, dynamic>> nonNullableDays = {};
  Future<void> addGroup(
      bool isEmit,
      BuildContext context, {
        required List<UserModel> selectedUsers,
        required List<UserModel> selectedCoaches,
        required Timestamp startTrainingTime,
        required Timestamp endTrainingTime,
        required String branch,
        Map<String, Map<dynamic, dynamic>>? times,
        String? maxUsers,
      }) async {
    emit(state.copyWith(loading: true));

    for (var day in times!.keys) {
      if (times[day]!['start'] != null && times[day]!['end'] != null) {
        DateTime nearestDay = getNearestDayOfWeek(day);
        Timestamp nearestDayTimestamp = Timestamp.fromDate(nearestDay);
        nonNullableDays[day] = {
          'start': Timestamp.fromDate(DateTime(
              nearestDay.year,
              nearestDay.month,
              nearestDay.day,
              times[day]!['start'].hour,
              times[day]!['start'].minute)),
          'end': Timestamp.fromDate(DateTime(
              nearestDay.year,
              nearestDay.month,
              nearestDay.day,
              times[day]!['end'].hour,
              times[day]!['end'].minute)),
          'nearest_day': nearestDayTimestamp,
        };
      }
    }

    List<String> days = nonNullableDays.keys.toList();

    if (days.isEmpty ||
        selectedUsers.isEmpty ||
        selectedCoaches.isEmpty ||
        maxUsers == null ||
        branch == '') {
      emit(state.copyWith(loading: false));

      Fluttertoast.showToast(
        msg: 'يجب إدخال جميع البيانات المطلوبة',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return;
    }

    WriteBatch batch = FirebaseFirestore.instance.batch();
    DocumentReference branchRef = FirebaseFirestore.instance
        .collection('branches')
        .doc(branch)
        .collection('groups')
        .doc();
    String groupId = branchRef.id;
    batch.set(branchRef, {
      'name': branch,
      'max_users': maxUsers,
      'number_of_users': selectedUsers.length,
      'number_of_coaches': selectedCoaches.length,

      //add list of coaches and users to the branch

      'usersList': selectedUsers.map((e) => e.name).toList(),
      'userIds': selectedUsers.map((e) => e.uId).toList(),
      'coachList': selectedCoaches.map((e) => e.name).toList(),
      'coachIds': selectedCoaches.map((e) => e.uId).toList(),
      //can i upload ;ist of maps to firebase like list of userModels
      'users': selectedUsers.map((e) => e.toMap()).toList(),
      'coaches': selectedCoaches.map((e) => e.toMap()).toList(),

      'pid': FirebaseAuth.instance.currentUser!.uid,
      'group_id': branchRef.id,
      'days': nonNullableDays,
    });

    try {
      for (var day in days) {
        if (nonNullableDays.containsKey(day)) {
          Timestamp nearestDayTimestamp = nonNullableDays[day]!['nearest_day'];

          DocumentReference scheduleRef = FirebaseFirestore.instance
              .collection('admins')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('schedules')
              .doc(day)
              .collection('schedules')
              .doc();
          batch.set(scheduleRef, {
            'start_time': nonNullableDays[day]!['start'],
            'end_time': nonNullableDays[day]!['end'],
            'date': day,
            'nearest_day': nearestDayTimestamp,
            'branch_id': branch,
            'group_id': groupId,
            'usersList': [],
            'userIds': [],
            'max_users': maxUsers,
            'schedule_id': scheduleRef.id ?? '',
          });

          if (selectedCoaches != null && selectedCoaches.isNotEmpty) {
            for (var coach in selectedCoaches) {
              DocumentReference coachRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(coach.uId)
                  .collection('schedules')
                  .doc(scheduleRef.id);

              batch.set(coachRef, {
                'start_time': nonNullableDays[day]!['start'],
                'end_time': nonNullableDays[day]!['end'],
                'date': day,
                'nearest_day': nearestDayTimestamp,
                'branch_id': branch,
                'pId': FirebaseAuth.instance.currentUser!.uid,
                'max_users': maxUsers,
                'schedule_id': scheduleRef.id ?? '',
                'group_id': groupId,
              });

              DocumentReference adminRef = FirebaseFirestore.instance
                  .collection('admins')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('schedules')
                  .doc(day)
                  .collection('schedules')
                  .doc(scheduleRef.id)
                  .collection('users')
                  .doc(coach.uId);

              batch.set(adminRef, {
                'name': coach.name,
                'uid': coach.uId,
                'finished': false,
                'role': 'coach',
              });

              batch.update(scheduleRef, {
                'coachList': FieldValue.arrayUnion([coach.name]),
                'coachIds': FieldValue.arrayUnion([coach.uId]),
              });
              //        batch.update(
              //   FirebaseFirestore.instance
              //       .collection('branches')
              //       .doc(branch)
              //       .collection('groups')
              //       .doc(groupId),
              //   {
              //     //'schedule_ids': FieldValue.arrayUnion([scheduleRef.id]),
              //     'coachList': FieldValue.arrayUnion([coach.name]),
              //     'coachIds': FieldValue.arrayUnion([coach.uId]),
              //   },
              // );

              DocumentReference coachScheduleRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(coach.uId)
                  .collection('schedules')
                  .doc(scheduleRef.id);

              batch.set(coachScheduleRef, {
                'start_time': nonNullableDays[day]!['start'],
                'end_time': nonNullableDays[day]!['end'],
                'date': day,
                'nearest_day': nearestDayTimestamp,
                'branch_id': branch,
                'pId': FirebaseAuth.instance.currentUser!.uid,
                'max_users': maxUsers,
                'schedule_id': scheduleRef.id ?? '',
                'group_id': groupId,
              });
            }
          }

          if (selectedUsers != null && selectedUsers.isNotEmpty) {
            for (var user in selectedUsers) {
              DocumentReference userRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uId)
                  .collection('schedules')
                  .doc(scheduleRef.id);

              batch.set(userRef, {
                'start_time': nonNullableDays[day]!['start'],
                'end_time': nonNullableDays[day]!['end'],
                'date': day,
                'nearest_day': nearestDayTimestamp,
                'branch_id': branch,
                'pId': FirebaseAuth.instance.currentUser!.uid,
                'max_users': maxUsers,
                'schedule_id': scheduleRef.id ?? '',
                'group_id': groupId,
              });

              DocumentReference adminRef = FirebaseFirestore.instance
                  .collection('admins')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('schedules')
                  .doc(day)
                  .collection('schedules')
                  .doc(scheduleRef.id)
                  .collection('users')
                  .doc(user.uId);

              batch.set(adminRef, {
                'name': user.name,
                'uid': user.uId,
                'finished': false,
                'role': 'user',
              });

              batch.update(scheduleRef, {
                'usersList': FieldValue.arrayUnion([user.name]),
                'userIds': FieldValue.arrayUnion([user.uId]),
              });

              DocumentReference userScheduleRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uId)
                  .collection('schedules')
                  .doc(scheduleRef.id);

              batch.set(userScheduleRef, {
                'start_time': nonNullableDays[day]!['start'],
                'end_time': nonNullableDays[day]!['end'],
                'date': day,
                'nearest_day': nearestDayTimestamp,
                'branch_id': branch,
                'pId': FirebaseAuth.instance.currentUser!.uid,
                'schedule_id': scheduleRef.id ?? '',
                'max_users': maxUsers,
              });
              //      batch.update(
              //   FirebaseFirestore.instance
              //       .collection('branches')
              //       .doc(branch)
              //       .collection('groups')
              //       .doc(groupId),
              //   {
              //     'usersList': FieldValue.arrayUnion([user.name]),
              //     'userIds': FieldValue.arrayUnion([user.uId]),
              //   },
              // );
            }
          }

          // Add the schedule ID to the branch collection
          batch.update(
            FirebaseFirestore.instance
                .collection('branches')
                .doc(branch)
                .collection('groups')
                .doc(groupId),
            {
              'schedule_ids': FieldValue.arrayUnion([scheduleRef.id]),
              'schedule_days': FieldValue.arrayUnion([day]),
              // 'users': selectedUsers,
              // 'coaches': selectedCoaches,
              //add list of coaches and users to the branch



            },
          );
        }
      }


      await batch.commit();

      emit(state.copyWith(loading: false));

      Fluttertoast.showToast(
        msg: 'تم إضافة المواعيد بنجاح',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      emit(state.copyWith(loading: false));
      print(e.toString());

      Fluttertoast.showToast(
        msg: 'حدث خطأ أثناء إضافة المواعيد\n${e.toString()}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
  //todo sh3ala bs na2s el schedulesids
  // Future<void> addGroup(
  //     bool isEmit,
  //     BuildContext context, {
  //       required List<UserModel> selectedUsers,
  //       required List<UserModel> selectedCoaches,
  //       required Timestamp startTrainingTime,
  //       required Timestamp endTrainingTime,
  //       required String branch,
  //       Map<String, Map<dynamic, dynamic>>? times,
  //       String? maxUsers,
  //     }) async {
  //   emit(state.copyWith(loading: true));
  //
  //   for (var day in times!.keys) {
  //     if (times[day]!['start'] != null && times[day]!['end'] != null) {
  //       DateTime nearestDay = getNearestDayOfWeek(day);
  //       Timestamp nearestDayTimestamp = Timestamp.fromDate(nearestDay);
  //       nonNullableDays[day] = {
  //         'start': Timestamp.fromDate(DateTime(
  //             nearestDay.year,
  //             nearestDay.month,
  //             nearestDay.day,
  //             times[day]!['start'].hour,
  //             times[day]!['start'].minute)),
  //         'end': Timestamp.fromDate(DateTime(
  //             nearestDay.year,
  //             nearestDay.month,
  //             nearestDay.day,
  //             times[day]!['end'].hour,
  //             times[day]!['end'].minute)),
  //         'nearest_day': nearestDayTimestamp,
  //       };
  //     }
  //   }
  //
  //   List<String> days = nonNullableDays.keys.toList();
  //
  //   if (days.isEmpty ||
  //       selectedUsers.isEmpty ||
  //       selectedCoaches.isEmpty ||
  //       maxUsers == null ||
  //       branch == '') {
  //     emit(state.copyWith(loading: false));
  //
  //     Fluttertoast.showToast(
  //         msg: 'يجب إدخال جميع البيانات المطلوبة',
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 5,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //
  //     return;
  //   }
  //
  //   WriteBatch batch = FirebaseFirestore.instance.batch();
  //
  //   try {
  //     for (var day in days) {
  //       if (nonNullableDays.containsKey(day)) {
  //         Timestamp nearestDayTimestamp = nonNullableDays[day]!['nearest_day'];
  //
  //         DocumentReference scheduleRef = FirebaseFirestore.instance
  //             .collection('admins')
  //             .doc(FirebaseAuth.instance.currentUser!.uid)
  //             .collection('schedules')
  //             .doc(day)
  //             .collection('schedules')
  //             .doc();
  //
  //         batch.set(scheduleRef, {
  //           'start_time': nonNullableDays[day]!['start'],
  //           'end_time': nonNullableDays[day]!['end'],
  //           'date': day,
  //           'nearest_day': nearestDayTimestamp,
  //           'branch_id': branch,
  //           'usersList': [],
  //           'userIds': [],
  //           'max_users': maxUsers,
  //           'schedule_id': scheduleRef.id ?? '',
  //         });
  //
  //         if (selectedCoaches != null && selectedCoaches.isNotEmpty) {
  //           for (var coach in selectedCoaches) {
  //             DocumentReference coachRef = FirebaseFirestore.instance
  //                 .collection('users')
  //                 .doc(coach.uId)
  //                 .collection('schedules')
  //                 .doc(scheduleRef.id);
  //
  //             batch.set(coachRef, {
  //               'start_time': nonNullableDays[day]!['start'],
  //               'end_time': nonNullableDays[day]!['end'],
  //               'date': day,
  //               'nearest_day': nearestDayTimestamp,
  //               'branch_id': branch,
  //               'pId': FirebaseAuth.instance.currentUser!.uid,
  //               'max_users': maxUsers,
  //               'schedule_id': scheduleRef.id ?? '',
  //             });
  //
  //             DocumentReference adminRef = FirebaseFirestore.instance
  //                 .collection('admins')
  //                 .doc(FirebaseAuth.instance.currentUser!.uid)
  //                 .collection('schedules')
  //                 .doc(day)
  //                 .collection('schedules')
  //                 .doc(scheduleRef.id)
  //                 .collection('users')
  //                 .doc(coach.uId);
  //
  //             batch.set(adminRef, {
  //               'name': coach.name,
  //               'uid': coach.uId,
  //               'finished': false,
  //               'role': 'coach',
  //             });
  //
  //             batch.update(scheduleRef, {
  //               'coachList': FieldValue.arrayUnion([coach.name]),
  //               'coachIds': FieldValue.arrayUnion([coach.uId]),
  //             });
  //
  //             DocumentReference coachScheduleRef = FirebaseFirestore.instance
  //                 .collection('users')
  //                 .doc(coach.uId)
  //                 .collection('schedules')
  //                 .doc(scheduleRef.id);
  //
  //             batch.set(coachScheduleRef, {
  //               'start_time': nonNullableDays[day]!['start'],
  //               'end_time': nonNullableDays[day]!['end'],
  //               'date': day,
  //               'nearest_day': nearestDayTimestamp,
  //               'branch_id': branch,
  //               'pId': FirebaseAuth.instance.currentUser!.uid,
  //               'max_users': maxUsers,
  //               'schedule_id': scheduleRef.id ?? '',
  //             });
  //           }
  //         }
  //
  //         if (selectedUsers != null && selectedUsers.isNotEmpty) {
  //           for (var user in selectedUsers) {
  //             DocumentReference userRef = FirebaseFirestore.instance
  //                 .collection('users')
  //                 .doc(user.uId)
  //                 .collection('schedules')
  //                 .doc(scheduleRef.id);
  //
  //             batch.set(userRef, {
  //               'start_time': nonNullableDays[day]!['start'],
  //               'end_time': nonNullableDays[day]!['end'],
  //               'date': day,
  //               'nearest_day': nearestDayTimestamp,
  //               'branch_id': branch,
  //               'pId': FirebaseAuth.instance.currentUser!.uid,
  //               'max_users': maxUsers,
  //               'schedule_id': scheduleRef.id ?? '',
  //             });
  //
  //             DocumentReference adminRef = FirebaseFirestore.instance
  //                 .collection('admins')
  //                 .doc(FirebaseAuth.instance.currentUser!.uid)
  //                 .collection('schedules')
  //                 .doc(day)
  //                 .collection('schedules')
  //                 .doc(scheduleRef.id)
  //                 .collection('users')
  //                 .doc(user.uId);
  //
  //             batch.set(adminRef, {
  //               'name': user.name,
  //               'uid': user.uId,
  //               'finished': false,
  //               'role': 'user',
  //             });
  //
  //             batch.update(scheduleRef, {
  //               'usersList': FieldValue.arrayUnion([user.name]),
  //               'userIds': FieldValue.arrayUnion([user.uId]),
  //             });
  //
  //             DocumentReference userScheduleRef = FirebaseFirestore.instance
  //                 .collection('users')
  //                 .doc(user.uId)
  //                 .collection('schedules')
  //                 .doc(scheduleRef.id);
  //
  //             batch.set(userScheduleRef, {
  //               'start_time': nonNullableDays[day]!['start'],
  //               'end_time': nonNullableDays[day]!['end'],
  //               'date': day,
  //               'nearest_day': nearestDayTimestamp,
  //               'branch_id': branch,
  //               'pId': FirebaseAuth.instance.currentUser!.uid,
  //               'schedule_id': scheduleRef.id ?? '',
  //               'max_users': maxUsers,
  //             });
  //           }
  //         }
  //       }
  //     }
  //
  //     DocumentReference branchRef = FirebaseFirestore.instance
  //         .collection('branches')
  //         .doc(branch)
  //         .collection('groups')
  //         .doc();
  //     batch.set(branchRef, {
  //       'name': branch,
  //       'max_users': maxUsers,
  //       'number_of_users': selectedUsers.length,
  //       'number_of_coaches': selectedCoaches.length,
  //       'pid': FirebaseAuth.instance.currentUser!.uid,
  //       'group_id': branchRef.id,
  //       'days': nonNullableDays,
  //     });
  //
  //     await batch.commit();
  //
  //     emit(state.copyWith(loading: false));
  //
  //     Fluttertoast.showToast(
  //         msg: 'تم إضافة المواعيد بنجاح',
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 5,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   } catch (e) {
  //     emit(state.copyWith(loading: false));
  //
  //     Fluttertoast.showToast(
  //         msg: 'حدث خطأ أثناء إضافة المواعيد\n${e.toString()}',
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 5,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  // }
//todo sh3ala bs na2s el schedulesids
//   late Map<String, Map<dynamic, dynamic>> nonNullableDays = {};
//   Future<void> addGroup(
//     bool isEmit,
//     BuildContext context, {
//     required List<UserModel> selectedUsers,
//     required List<UserModel> selectedCoaches,
//     required Timestamp startTrainingTime,
//     required Timestamp endTrainingTime,
//     required String branch,
//     Map<String, Map<dynamic, dynamic>>? times,
//     String? maxUsers,
//   }) async {
//     emit(state.copyWith(loading: true));
//     // late Map<String, Map<dynamic, dynamic>> nonNullableDays = {};
//
//     // Convert times to nonNullableDays
//     for (var day in times!.keys) {
//       if (times[day]!['start'] != null && times[day]!['end'] != null) {
//         DateTime nearestDay = getNearestDayOfWeek(day);
//         Timestamp nearestDayTimestamp = Timestamp.fromDate(nearestDay);
//         nonNullableDays[day] = {
//           'start': Timestamp.fromDate(DateTime(
//               nearestDay.year,
//               nearestDay.month,
//               nearestDay.day,
//               times[day]!['start'].hour,
//               times[day]!['start'].minute)),
//           'end': Timestamp.fromDate(DateTime(
//               nearestDay.year,
//               nearestDay.month,
//               nearestDay.day,
//               times[day]!['end'].hour,
//               times[day]!['end'].minute)),
//           'nearest_day': nearestDayTimestamp,
//         };
//       }
//     }
//
//     // Get all non-null days
//     List<String> days = nonNullableDays.keys.toList();
//     //if days is empty or selectedUsers is empty or selectedCoaches is empty
//     // or maxUsers is empty or branch is empty return error message
//     if (days.isEmpty ||
//         selectedUsers.isEmpty ||
//         selectedCoaches.isEmpty ||
//         maxUsers == null ||
//         branch == '') {
//       emit(state.copyWith(loading: false));
//
//       Fluttertoast.showToast(
//           msg: 'يجب إدخال جميع البيانات المطلوبة',
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 5,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0);
//
//       return;
//     }
//
//     // Create a batched write
//     WriteBatch batch = FirebaseFirestore.instance.batch();
//
//     try {
//       // Add schedules to batch
//       for (var day in days) {
//         if (nonNullableDays.containsKey(day)) {
//           Timestamp nearestDayTimestamp = nonNullableDays[day]!['nearest_day'];
//
//           DocumentReference scheduleRef = FirebaseFirestore.instance
//               .collection('admins')
//               .doc(FirebaseAuth.instance.currentUser!.uid)
//               .collection('schedules')
//               .doc(day)
//               .collection('schedules')
//               .doc();
//
//           batch.set(scheduleRef, {
//             'start_time': nonNullableDays[day]!['start'],
//             'end_time': nonNullableDays[day]!['end'],
//             'date': day,
//             'nearest_day': nearestDayTimestamp,
//             'branch_id': branch,
//             'usersList': [],
//             'userIds': [],
//             'max_users': maxUsers,
//             'schedule_id': scheduleRef.id ?? '',
//           });
//
//           // Add coaches to batch
//           if (selectedCoaches != null && selectedCoaches.isNotEmpty) {
//             for (var coach in selectedCoaches) {
//               DocumentReference coachRef = FirebaseFirestore.instance
//                   .collection('users')
//                   .doc(coach.uId)
//                   .collection('schedules')
//                   .doc(scheduleRef.id);
//
//               batch.set(coachRef, {
//                 'start_time': nonNullableDays[day]!['start'],
//                 'end_time': nonNullableDays[day]!['end'],
//                 'date': day,
//                 'nearest_day': nearestDayTimestamp,
//                 'branch_id': branch,
//                 'pId': FirebaseAuth.instance.currentUser!.uid,
//                 'max_users': maxUsers,
//                 'schedule_id': scheduleRef.id ?? '',
//               });
//
//               DocumentReference adminRef = FirebaseFirestore.instance
//                   .collection('admins')
//                   .doc(FirebaseAuth.instance.currentUser!.uid)
//                   .collection('schedules')
//                   .doc(day)
//                   .collection('schedules')
//                   .doc(scheduleRef.id)
//                   .collection('users')
//                   .doc(coach.uId);
//
//               batch.set(adminRef, {
//                 'name': coach.name,
//                 'uid': coach.uId,
//                 'finished': false,
//                 'role': 'coach',
//               });
//
//               batch.update(scheduleRef, {
//                 'coachList': FieldValue.arrayUnion([coach.name]),
//                 'coachIds': FieldValue.arrayUnion([coach.uId]),
//               });
//
//               DocumentReference coachScheduleRef = FirebaseFirestore.instance
//                   .collection('users')
//                   .doc(coach.uId)
//                   .collection('schedules')
//                   .doc(scheduleRef.id);
//
//               batch.set(coachScheduleRef, {
//                 'start_time': nonNullableDays[day]!['start'],
//                 'end_time': nonNullableDays[day]!['end'],
//                 'date': day,
//                 'nearest_day': nearestDayTimestamp,
//                 'branch_id': branch,
//                 'pId': FirebaseAuth.instance.currentUser!.uid,
//                 'max_users': maxUsers,
//                 'schedule_id': scheduleRef.id ?? '',
//               });
//             }
//           }
//
//           // Add users to batch
//           if (selectedUsers != null && selectedUsers.isNotEmpty) {
//             for (var user in selectedUsers) {
//               DocumentReference userRef = FirebaseFirestore.instance
//                   .collection('users')
//                   .doc(user.uId)
//                   .collection('schedules')
//                   .doc(scheduleRef.id);
//
//               batch.set(userRef, {
//                 'start_time': nonNullableDays[day]!['start'],
//                 'end_time': nonNullableDays[day]!['end'],
//                 'date': day,
//                 'nearest_day': nearestDayTimestamp,
//                 'branch_id': branch,
//                 'pId': FirebaseAuth.instance.currentUser!.uid,
//                 'max_users': maxUsers,
//                 'schedule_id': scheduleRef.id ?? '',
//               });
//
//               DocumentReference adminRef = FirebaseFirestore.instance
//                   .collection('admins')
//                   .doc(FirebaseAuth.instance.currentUser!.uid)
//                   .collection('schedules')
//                   .doc(day)
//                   .collection('schedules')
//                   .doc(scheduleRef.id)
//                   .collection('users')
//                   .doc(user.uId);
//
//               batch.set(adminRef, {
//                 'name': user.name,
//                 'uid': user.uId,
//                 'finished': false,
//                 'role': 'user',
//               });
//
//               batch.update(scheduleRef, {
//                 'usersList': FieldValue.arrayUnion([user.name]),
//                 'userIds': FieldValue.arrayUnion([user.uId]),
//               });
//
//               DocumentReference userScheduleRef = FirebaseFirestore.instance
//                   .collection('users')
//                   .doc(user.uId)
//                   .collection('schedules')
//                   .doc(scheduleRef.id);
//
//               batch.set(userScheduleRef, {
//                 'start_time': nonNullableDays[day]!['start'],
//                 'end_time': nonNullableDays[day]!['end'],
//                 'date': day,
//                 'nearest_day': nearestDayTimestamp,
//                 'branch_id': branch,
//                 'pId': FirebaseAuth.instance.currentUser!.uid,
//                 'schedule_id': scheduleRef.id ?? '',
//                 'max_users': maxUsers,
//               });
//             }
//           }
//         }
//       }
//       //todo :fix branch is null
//       DocumentReference branchRef = FirebaseFirestore.instance
//           .collection('branches')
//           .doc(branch)
//           .collection('groups')
//           .doc();
//       batch.set(branchRef, {
//         'name': branch,
//         'max_users': maxUsers,
//         'number_of_users': selectedUsers.length,
//         'number_of_coaches': selectedCoaches.length,
//         'pid': FirebaseAuth.instance.currentUser!.uid,
//         'group_id': branchRef.id,
//         //non nullable days as map
//         'days': nonNullableDays,
//        // 'schedules':
//       });
//
//       // Commit the batched write
//       await batch.commit();
//
//       emit(state.copyWith(loading: false));
//
//       Fluttertoast.showToast(
//           msg: 'تم إضافة المواعيد بنجاح',
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 5,
//           backgroundColor: Colors.green,
//           textColor: Colors.white,
//           fontSize: 16.0);
//     } catch (e) {
//       emit(state.copyWith(loading: false));
//
//       Fluttertoast.showToast(
//           msg: 'حدث خطأ أثناء إضافة المواعيد\n${e.toString()}',
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 5,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0);
//     }
//   }

  DateTime getNearestDayOfWeek(String dayOfWeek) {
    // Get the current date
    DateTime now = DateTime.now();

    // Get the integer value of the selected day of the week
    int selectedDayOfWeek = [
      'الأحد',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت'
    ].indexOf(dayOfWeek);
    ////vdfdf

    //dfdfgdfg/d
    // Calculate the difference between the selected day of the week and the current day of the week
    int difference = selectedDayOfWeek - now.weekday;

    // If the difference is negative, add 7 to get the nearest day of the week
    if (difference < 0) {
      difference += 7;
    }

    // Add the difference to the current date to get the nearest day of the week
    DateTime nearestDay = now.add(Duration(days: difference));

    return nearestDay;
  }

  void updateTime2(String day, TimeOfDay startTime) {
    _times[day]?['start'] = startTime;
    _times[day]?['end'] = startTime.replacing(hour: startTime.hour + 1);
    emit(state.copyWith(times: _times));
  }
  //update time3 which take Map<String, Map<dynamic, dynamic>>
  void updateTime3(Map<String, Map<dynamic, dynamic>> times) {
    //Get the day from the map and update the start and end time of the day
    for (var day in times.keys) {
      _times[day]?['start'] = times[day]!['start'];
      _times[day]?['end'] = times[day]!['end'];
    }
  }
  // setState(() {
  //   if (widget.isCoach) {
  //     _selectedCoachesUids = users.map((e) => e.uId!).toList();
  //   } else {
  //     _selectedUsersUids = users.map((e) => e.uId!).toList();
  //   }
  //   // _selectedCoaches = users;
  // });

  void setSelectedCoaches(List<UserModel> users) {
    selectedCoachesUids = users.map((e) => e.uId!).toList();
    selectedCoaches = users;
    emit(state.copyWith(selectedCoaches: users));
  }
  void setSelectedCoachesUids(List<String> users) {
    selectedCoachesUids = users;
    emit(state.copyWith(selectedCoachesUids: users));
  }

  void setSelectedUsers(List<UserModel> users) {
    selectedUsersUids = users.map((e) => e.uId!).toList();
    selectedUsers = users;
    emit(state.copyWith(selectedUsers: users));
  }
  void setSelectedUsersUids(List<String> users) {
    selectedUsersUids = users;
    emit(state.copyWith(selectedUsersUids: users));
  }

  void updateQuery(Query query) {
    usersQuery = query;
    emit(state.copyWith(query: query));
  }

  void updateMaxUsers(int parse) {
    maxUsers = parse.toString();
    emit(state.copyWith(maxUsers: parse.toString()));
  }

  void updateUsersQuery(param0) {
    usersQuery = param0;
    emit(state.copyWith(query: param0));
  }

  void updateIsSearch(bool bool) {
    isSearch = bool;
    emit(state.copyWith(isSearch: bool));
  }
  //function to update sekected user and selected coach and selected times and selected branch and max users
  void updateSelectedUsersAndCoachesAndTimesAndBranchAndMaxUsers(
      {List<UserModel>? selectedUsers,
        List<UserModel>? selectedCoaches,
        List<String>? selectedTimes,
        String? selectedBranch,
        String? selectedOption,
        String? maxUsers,context, required Map<String, Map<String, Timestamp>> selectedDays}) {
    maxUsers = maxUsers;
    //update times variable whish is Map<String, Map<dynamic, dynamic>>
    //it looks like that
    //static final Map<String, Map<dynamic, dynamic>> _times = {
    //     'السبت': {'start': null, 'end': null},
    //     'الأحد': {'start': null, 'end': null},
    //     'الاثنين': {'start': null, 'end': null},
    //     'الثلاثاء': {'start': null, 'end': null},
    //     'الأربعاء': {'start': null, 'end': null},
    //     'الخميس': {'start': null, 'end': null},
    //     'الجمعة': {'start': null, 'end': null},
    //   };
    //loop on selected days and update the start and end time of the day
    for (var day in selectedDays.keys) {
      //selectedDays[day]!['start'];
      //selectedDays[day]!['end'];
      //i want to turn these 2 timestamps to time of day
      int? startTime = selectedDays[day]!['start']?.millisecondsSinceEpoch;
      int? endTime = selectedDays[day]!['end']?.millisecondsSinceEpoch;
      //assign the start and end time to the day
      _times[day]?['start'] = TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(startTime!));
      _times[day]?['end'] = TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(endTime!));
    }
    this.selectedUsers = selectedUsers ?? this.selectedUsers;
    this.selectedCoaches = selectedCoaches ?? this.selectedCoaches;
    //this.selectedTimes = selectedTimes ?? this.selectedTimes;
    ManageAttendenceCubit.get(context)
        .updateSelectedBranch(selectedBranch!);
    ///if isAdd is false update data in the cubit
    //         //  if (isAdd == true) {
    //         //loop on users and convert it to UserModel
    //         // List<UserModel> usersList = [];
    //         // for (var user in users!) {
    //         //   context.read<AddGroupCubit>().selectUser(user);
    //         //   //use this to se
    //         //   //usersList.add(UserModel.fromJson(user));
    //         // }
    //         //
    //         //  List<UserModel> coachesList = [];
    //         // for (var coach in coaches!) {
    //         //   coachesList.add(UserModel.fromJson(coach));
    //         //   }
    //         //update data in the cubit using selectedUsers and selectedCoaches
    //         // context.read<AddGroupCubit>().selectUser(usersList);
    //         //  context.read<AddGroupCubit>().selectCoach(coachesList);
    //         //  context.read<AddGroupCubit>().updateTime3(days!);
    //
    //         //  context.read<AddGroupCubit>().setSelectedUsers(users??[]);
    //         // context.read<AddGroupCubit>().setSelectedUsers(coaches??[]);
    //        // print('isAdd in onboarding screen $isAdd');
    //         //users
    //         // print('users in onboarding screen $users');
    //         // print('users in onboarding screen ${users?.length}');
    //
    //
    //         // print('days in onboarding screen $days');
    //         // print('branchId in onboarding screen $branchId');
    //         // print('groupId in onboarding screen $groupId');
    //         // print('schedule_days in onboarding screen $schedule_days');
    //         // print('userIds in onboarding screen $userIds');
    //         // print('scheduleId in onboarding screen $scheduleId');
    //         // print('coachIds in onboarding screen $coachIds');
    //         // print('coachList in onboarding screen $coachList');
    //         // print('usersList in onboarding screen $usersList');
    //         // print('maxUsers in onboarding screen $maxUsers');
    //         //context.read<AddGroupCubit>().updateMaxUsers(int.parse(maxUsers!));
    //         //ManageAttendenceCubit.get(context)
    //         //    .updateSelectedBranch(branchId!);
    //         //}
    emit(state.copyWith(
        selectedUsers: selectedUsers,
        selectedCoaches: selectedCoaches,
        selectedTimes: selectedTimes,
        selectedBranch: selectedBranch,
        selectedOption: selectedOption,
        maxUsers: maxUsers));
  }
}

class AddGroupState {
  List<UserModel> selectedUsers;
  List<UserModel> selectedCoaches;
  final List<String> selectedTimes;
  final String selectedBranch;
  final String selectedOption;
  final int currentIndex;
  final List<Widget> screens;
  final String? searchQuery;
  final List<UserModel> selectedUsersUids;
  final Map<String, Map<dynamic, dynamic>> times;
  final bool loading;
  final Query? query;
  final String? maxUsers;

  AddGroupState({
    this.maxUsers,
    this.query,
    this.selectedUsers = const [],
    this.selectedCoaches = const [],
    this.selectedTimes = const [],
    this.selectedBranch = '',
    this.selectedOption = '',
    this.currentIndex = 0,
    required this.screens,
    this.searchQuery,
    this.selectedUsersUids = const [],
    this.times = const {
      'السبت': {'start': null, 'end': null},
      'الأحد': {'start': null, 'end': null},
      'الاثنين': {'start': null, 'end': null},
      'الثلاثاء': {'start': null, 'end': null},
      'الأربعاء': {'start': null, 'end': null},
      'الخميس': {'start': null, 'end': null},
      'الجمعة': {'start': null, 'end': null},
    },
    this.loading = false,
  });

  AddGroupState copyWith({
    List<UserModel>? selectedUsers,
    List<UserModel>? selectedCoaches,
    List<String>? selectedTimes,
    String? selectedBranch,
    String? selectedOption,
    int? currentIndex,
    String? searchQuery,
    List<String>? selectedUsersUids,
    Map<String, Map>? times,
    bool? loading,
    Query? query,
    String? maxUsers,  bool? isSearch, List<String>? selectedCoachesUids,
  }) {
    return AddGroupState(
      query: query ?? this.query,
      selectedUsers: selectedUsers ?? this.selectedUsers,
      selectedCoaches: selectedCoaches ?? this.selectedCoaches,
      selectedTimes: selectedTimes ?? this.selectedTimes,
      selectedBranch: selectedBranch ?? this.selectedBranch,
      selectedOption: selectedOption ?? this.selectedOption,
      currentIndex: currentIndex ?? this.currentIndex,
      screens: this.screens,
      searchQuery: searchQuery ?? this.searchQuery,
      //   selectedUsersUids: selectedUsersUids ?? this.selectedUsersUids,
      times: times ?? this.times,
      loading: loading ?? this.loading,
      maxUsers: maxUsers ?? this.maxUsers,



    );
  }
}
class OnboardingScreen extends StatelessWidget {
  final bool? isAdd;
  final String? branchId;
  final String? groupId;
  final List<String>? scheduleDays;
  final List<String>? userIds;
  final List<String>? scheduleId;
  final List<String>? coachIds;
  final List<String>? coachList;
  final List<String>? usersList;
  //users is list of json from firebase collection users i will get here and then use userModel.fromJson to convert it to UserModel
  final List? users;
  // final List<UserModel>? coaches;
  final Map<String, Map<dynamic, dynamic>>? days;
  final String? maxUsers;

  OnboardingScreen(
      {Key? key,
        this.isAdd,
        this.branchId,
        this.groupId,
        this.scheduleDays,
        this.userIds,
        this.scheduleId,
        this.coachIds,
        this.coachList,
        this.usersList,
        this.days,
        this.maxUsers,
        this.users,
        //  this.coaches,
      }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // String? group_id = groupId;
    // String? branch_id = branchId;
    // String? max_users = maxUsers;
    // List<String>? schedule_days = this.schedule_days;
    // List<String>? user_ids = userIds;
    // List<String>? schedule_ids = scheduleId;
    // List<String>? coach_ids = coachIds;
    // List<String>? coach_list = coachList;
    // List<String>? users_list = usersList;
    // List? users = this.users;
    // //List<UserModel>? coaches = this.coaches;
    // Map<String, Map<dynamic, dynamic>>? days = this.days;
    // bool? isAdd = this.isAdd;
    //

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
  //         text: 'Add group of schedules',
          //traanslate the text to arabic
          text: 'اضافة مجموعة',
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  //delete borders
                  //  decoration: BoxDecoration(
                  //    border: Border.all(
                  //      color: Colors.white,
                  //    ),
                  //  ),
                  height: 650.h,
                  width: double.infinity,
                  child: Container(
                      //delete borders
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Theme(
                        data: ThemeData(
                          canvasColor: Colors.white,
                        ),
                        child: Stepper(
                          controlsBuilder:
                              //return Container();
                              (context, details) => Container(),
                          onStepContinue: //use AddGroupCubit
                              () {
                            context.read<AddGroupCubit>().nextScreen(
                                  context,
                                );
                          },
                          onStepCancel: //use AddGroupCubit
                              () {
                            context.read<AddGroupCubit>().previousScreen(
                                  context,
                                );
                          },
                          onStepTapped: (index) {
                            context.read<AddGroupCubit>().setCurrentIndex(index);
                          },
                          //handle navigation with swiping
                          physics: ClampingScrollPhysics(),
                          stepIconBuilder: (stepIndex, stepState) {
                            //change the icon of the step
                            if (stepState == StepState.complete) {
                              return

                                  ///home/elreefy14/admin14/admin_future/assets/images/Group 1.svg
                                  Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                  //make thick white border
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.5,
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/check.svg',
                                  color: Colors.white,
                                ),
                              );
                            } else if (stepState == StepState.indexed) {
                              //assets/images/emty14.svg
                              return Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    //color: Colors.white,
                                    //make thick white border
                                    border: Border.all(
                                      // color: Colors.white,
                                      width: .1,
                                    ),
                                  ),
                                  child: Container(
                                    width: 40.w,
                                    //shape circke to make the icon in circle
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    margin: EdgeInsets.all(1),
                                    //padding: EdgeInsets.all(5),
                                    //shape circke to make the icon in circle
                                    //color: Colors.white,
                                  ));
                            } else if (stepState == StepState.editing) {
                              return Container(
                                //shape circke to make the icon in circle
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/Group 1.svg',
                                  color: Colors.blue,
                                ),
                              );
                            } else {
                              //this example, we add an assertion to make sure that the hour value is not null and is within the valid range of 0 to 23. If the assertion fails, an error will be thrown. If the assertion pass
                              return Text(
                                '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontFamily: 'Montserrat-Arabic',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              );
                            }
                          },

                          type: StepperType.horizontal,
                          currentStep:
                              context.watch<AddGroupCubit>().state.currentIndex,
                          steps: context
                              .watch<AddGroupCubit>()
                              .state
                              .screens
                              .asMap()
                              .map((index, screen) => MapEntry(
                                  index,
                                  Step(
                                    title: Text(''),
                                    isActive: context
                                            .watch<AddGroupCubit>()
                                            .state
                                            .currentIndex >=
                                        index,
                                    state: context
                                                .watch<AddGroupCubit>()
                                                .state
                                                .currentIndex ==
                                            index
                                        ? StepState.editing
                                        : context
                                                    .watch<AddGroupCubit>()
                                                    .state
                                                    .currentIndex >
                                                index
                                            ? StepState.complete
                                            : StepState.indexed,
                                    content: SingleChildScrollView(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      child: SizedBox(
                                        height: 600.h,
                                        width: double.infinity,
                                        child: screen,
                                      ),
                                    ),
                                    //Expanded(

                                    //     child: SizedBox(
                                    //            height: MediaQuery.of(context).size.height,
                                    //            width: double.infinity,
                                    //         child: screen),
                                    //  ),
                                  )))
                              .values
                              .toList(),
                        ),
                      )),
                ),
                // Expanded(
                //   child: //_screens[_currentIndex],
                //   context.watch<AddGroupCubit>().state.screens[
                //       context.watch<AddGroupCubit>().state.currentIndex],
                //  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // todo :this delete button example
                    // when tap on it show dialog to confirm delete or not
                    //                       //if yes delete the group
                    //                       //if no do nothing
                    //                       if (context.watch<AddGroupCubit>().state.currentIndex == 0)
                    //                         Padding(
                    //                           padding: EdgeInsets.symmetric(
                    //                             horizontal: 4.0.w,
                    //                           ),
                    //                           child: InkWell(
                    //                             onTap: () =>   ManageUsersCubit.get(
                    //                                 context)
                    //                                 .deleteGroup(
                    //                               groupId: groupId ?? '',
                    //                               branchId: branchId ?? '',
                    //                               schedulesIds:
                    //                               scheduleId ?? [],
                    //                               schedulesDays:
                    //                               scheduleDays ?? [],
                    //                               context: context,
                    //                             ),
                    //                             child: Container(
                    //                               height: 50.h,
                    //                               width: 150.w,
                    //                               decoration: BoxDecoration(
                    //                                 color: Colors.red,
                    //                                 borderRadius: BorderRadius.circular(8),
                    //                               ),
                    //                               child: Align(
                    //                                   alignment: AlignmentDirectional(0, 0),
                    //                                   child: Text(
                    //                                     'حذف',
                    //                                     textAlign: TextAlign.right,
                    //                                     style: TextStyle(
                    //                                       color: Colors.white,
                    //                                       fontSize: 18.sp,
                    //                                       fontFamily: 'Montserrat-Arabic',
                    //                                       fontWeight: FontWeight.w400,
                    //                                       height: 0.08.h,
                    //                                     ),
                    //                                   )),
                    //                             ),
                    //                           ),
                    //                         ),
                    if (context.watch<AddGroupCubit>().state.currentIndex > 0)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.0.w,
                        ),
                        child: InkWell(
                          onTap: () =>
                              context.read<AddGroupCubit>().previousScreen(
                                    context,
                                  ),
                          child: Container(
                            height: 50.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                  'السابق',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontFamily: 'Montserrat-Arabic',
                                    fontWeight: FontWeight.w400,
                                    height: 0.08.h,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    //if current index is last index 'حفظ',

                    if (context.watch<AddGroupCubit>().state.currentIndex ==
                        context.watch<AddGroupCubit>().state.screens.length - 1)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.0.w,
                        ),
                        child: InkWell(
                          onTap: () {
                            print('save');
                            //print all   context.watch<AddGroupCubit>().state.times,
                            print(
                                'Selected Times: ${context.read<AddGroupCubit>().state.times}');

                            context.read<AddGroupCubit>().addGroup(
                                  true,
                                  context,
                                  selectedUsers: context
                                      .read<AddGroupCubit>()
                                      .state
                                      .selectedUsers,
                                  selectedCoaches: context
                                      .read<AddGroupCubit>()
                                      .state
                                      .selectedCoaches,
                                  startTrainingTime: //random time
                                      Timestamp.now(),
                                  endTrainingTime: //random time
                                      Timestamp.now(),
                                  branch: ManageAttendenceCubit.get(context)
                                          .selectedBranch ??
                                      '',
                                  // 'error',
                                  times: //call the times map from screen 2
                                      context.read<AddGroupCubit>().state.times,
                                  //TODO :fix this error
                                  // {
                                  //   'السبت': {'start': TimeOfDay.now(), 'end': TimeOfDay.now()},
                                  //  },
                                  maxUsers:
                                      context.read<AddGroupCubit>().maxUsers,
                                );
                            //clr   context.read<AddGroupCubit>().state.times,
                            context.read<AddGroupCubit>().state.times.clear();
                          },
                          child: BlocBuilder<AddGroupCubit, AddGroupState>(
                            builder: (context, state) {
                              return state.loading
                                  ? CircularProgressIndicator()
                                  : Container(
                                      height: 50.h,
                                      width: 150.w,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Text(
                                            'حفظ',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.sp,
                                                fontFamily: 'Montserrat-Arabic',
                                                fontWeight: FontWeight.w400,
                                                height: 0.08.h),
                                          )),
                                    );
                            },
                          ),
                        ),
                      ),

                    if (context.watch<AddGroupCubit>().state.currentIndex <
                        context.watch<AddGroupCubit>().state.screens.length - 1)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () =>
                              context.read<AddGroupCubit>().nextScreen(context),
                          child: Container(
                            height: 50.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                  'التالي',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontFamily: 'Montserrat-Arabic',
                                      fontWeight: FontWeight.w400,
                                      height: 0.08.h),
                                )),
                          ),
                        ),
                      ),
                  ],
                ),
                //  SizedBox(
                //    height: 30,
                // )
              ],
            ),
          ),
        ),
      );
    }
  }

  //assets/images/delete-2_svgrepo.com.svg
  class TimeSelectionScreen extends StatelessWidget {
    // static final Map<String, Map<dynamic, dynamic>> _times = {
    //   'السبت': {'start': null, 'end': null},
    //   'الأحد': {'start': null, 'end': null},
    //   'الاثنين': {'start': null, 'end': null},
    //   'الثلاثاء': {'start': null, 'end': null},
    //   'الأربعاء': {'start': null, 'end': null},
    //   'الخميس': {'start': null, 'end': null},
    //   'الجمعة': {'start': null, 'end': null},
    // };
    // Map<String, Map<dynamic, dynamic>> get times => _times;

    @override
    Widget build(BuildContext context) {
      dynamic _times = context.watch<AddGroupCubit>().times;
      return ListView(
        children: context.read<AddGroupCubit>().times.keys.map((day) {
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '/$day',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            ),
            subtitle: Column(
              children: [
                //10
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () async {
                        TimeOfDay? endTime = await showTimePicker(
                          context: context,
                          initialTime: _times[day]?['end'] ?? TimeOfDay.now(),
                        );
                        if (endTime != null) {
                          // setState(() {
                          //   //
                          //   _times[day]?['end'] = endTime;
                          //   //start time equal hour minus end time
                          //   _times[day]?['start'] =
                          //       endTime.replacing(hour: endTime.hour - 1);
                          // });
                          context.read<AddGroupCubit>().updateTime(day, endTime);
                        }
                      },
                      child: Container(
                        width: 125.w,
                        height: 35.h,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Color(0xFFF6F6F6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: Text(
                          // _times[day]?['end']?.format(context) ?? 'نهاية التدريب',
                          //make it in arabic like that 11 ص
                          _times[day]?['end']
                                  ?.format(context)
                                  .toString()
                                  .replaceAll('PM', 'م')
                                  .replaceAll('AM', 'ص') ??
                              'نهاية التدريب',

                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 16.sp,
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 8.0),
                        Text(
                          '-',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        SizedBox(width: 8.0.w),
                        InkWell(
                          onTap: () async {
                            TimeOfDay? startTime = await showTimePicker(
                              context: context,
                              initialTime:
                                  _times[day]?['start'] ?? TimeOfDay.now(),
                            );
                            if (startTime != null) {
                              // setState(() {
                              //   //convert start time to time stamp

                              //   _times[day]?['start'] = startTime;
                              //   //end time equal hour plus start time
                              //   TimeOfDay endTime =
                              //       startTime.replacing(hour: startTime.hour + 1);
                              //   _times[day]?['end'] = endTime;
                              //   //save the start time as timeStamp get

                              //   //  DateTime getNearestDayOfWeek(String dayOfWeek) {
                              //   // Get the current date
                              //   //   DateTime now = DateTime.now();

                              //   //   // Get the integer value of the selected day of the week
                              //   //   int selectedDayOfWeek = [
                              //   //     'الأحد',
                              //   //     'الاثنين',
                              //   //     'الثلاثاء',
                              //   //     'الأربعاء',
                              //   //     'الخميس',
                              //   //     'الجمعة',
                              //   //     'السبت'
                              //   //   ].indexOf(dayOfWeek);

                              //   //   // Calculate the difference between the selected day of the week and the current day of the week
                              //   //   int difference = selectedDayOfWeek - now.weekday;

                              //   //   // If the difference is negative, add 7 to get the nearest day of the week
                              //   //   if (difference < 0) {
                              //   //     difference += 7;
                              //   //   }

                              //   //   // Add the difference to the current date to get the nearest day of the week
                              //   //   DateTime nearestDay = now.add(Duration(days: difference));

                              //   //   return nearestDay;
                              //   // }
                              // });
                              context
                                  .read<AddGroupCubit>()
                                  .updateTime2(day, startTime);
                            }
                          },
                          child: Container(
                            width: 125.w,
                            height: 35.h,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF6F6F6),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            child: Text(
                              // _times[day]?['start']?.format(context) ?? 'بداية التدريب',
                              //make it in arabic like that 11 ص
                              _times[day]?['start']
                                      ?.format(context)
                                      .toString()
                                      .replaceAll('PM', 'م')
                                      .replaceAll('AM', 'ص') ??
                                  'بداية التدريب',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 16.sp,
                                fontFamily: 'IBM Plex Sans Arabic',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // onTap: () async {
            //   TimeOfDay? startTime = await showTimePicker(
            //     context: context,
            //     initialTime: _times[day]?['start'] ?? TimeOfDay.now(),
            //   );
            //   if (startTime != null) {
            //     TimeOfDay? endTime = await showTimePicker(
            //       context: context,
            //       initialTime: _times[day]?['end'] ?? TimeOfDay.now(),
            //     );
            //     setState(() {
            //       _times[day]?['start'] = startTime;
            //       if (endTime != null) {
            //         _times[day]?['end'] = endTime;
            //       }
            //     });
            //   }
            // },
          );
        }).toList(),
      );
    }
  }

  class SelectCoachesScreen extends StatelessWidget {
    final bool isCoach;

    SelectCoachesScreen({super.key, required this.isCoach});

    final TextEditingController _searchController = TextEditingController();

    // Future<void> _onSearchSubmitted(String value) async {
    @override
    Widget build(BuildContext context) {
      return BlocBuilder<AddGroupCubit, AddGroupState>(
        builder: (context, state) {
          // if(widget.isCoach) {
          //   print('is coach');
          //   print(widget.isCoach);
          //   context.read<AddGroupCubit>().updateQuery(FirebaseFirestore.instance.collection('users').orderBy('name').where('role', isEqualTo: 'coach'));
          // } else {
          //   print('is coach');
          //   print(widget.isCoach);
          //   context.read<AddGroupCubit>().updateQuery(FirebaseFirestore.instance.collection('users').orderBy('name').where('role', isEqualTo: 'user'));
          // }
          // print('hjh' + widget.isCoach.toString());
          // print(widget.isCoach);
          return Column(
            children: [
              /*
          Text(
            'المدربين:',
            style: TextStyle(
          color: Color(0xFF333333),
          fontSize: 14,
          fontFamily: 'IBM Plex Sans Arabic',
          fontWeight: FontWeight.w400,
          height: 0,
            ),
          )
          //50

          */
              //50
              SizedBox(
                height: 40.h,
              ),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Text(
                  isCoach ? 'المدربين' : 'الطلاب',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 14.sp,
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    // added this line
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  if (isCoach) {
                    print('is coach');
                    print(isCoach);
                    context.read<AddGroupCubit>().updateQuery(FirebaseFirestore
                        .instance
                        .collection('users')
                        .orderBy('name')
                        .where('role', isEqualTo: 'coach'));
                  } else {
                    print('is coach');
                    print(isCoach);
                    context.read<AddGroupCubit>().updateQuery(FirebaseFirestore
                        .instance
                        .collection('users')
                        .orderBy('name')
                        .where('role', isEqualTo: 'user'));
                  }
                  showDialog(
                    context: context,
                    builder: (context) => Theme(
                      data: Theme.of(context)
                          .copyWith(canvasColor: Colors.white,dialogBackgroundColor: Colors.white),
                      child: ShowCoachesInDialog(
                        isCoach: isCoach ?? true,
                        selectedUsers: isCoach
                            ? context.read<AddGroupCubit>().state.selectedCoaches
                            : context.read<AddGroupCubit>().state.selectedUsers,
                        onSelectedUsersChanged: (users) {
                          // setState(() {
                          //   if (widget.isCoach) {
                          //     _selectedCoachesUids = users.map((e) => e.uId!).toList();
                          //   } else {
                          //     _selectedUsersUids = users.map((e) => e.uId!).toList();
                          //   }
                          //   // _selectedCoaches = users;
                          // });
                          // if (widget.isCoach) {
                          //
                          //   context.read<AddGroupCubit>().setSelectedCoaches(users);
                          // } else {
                          //   context.read<AddGroupCubit>().setSelectedUsers(users);
                          // }
                        },
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 280.w,
                      height: 48.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF6F6F6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 20.w,
                            height: 11.30.h,
                            child: Icon(
                              Icons.arrow_drop_down,
                              // size: 20.sp,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: SizedBox(
                              child: Text(
                                isCoach ? 'اختر المدربين' : 'اختر الطلاب',
                                // 'اختر المدربين',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: 16.sp,
                                  fontFamily: 'IBM Plex Sans Arabic',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SingleChildScrollView(
                //  physics: BouncingScrollPhysics(),
                child: SizedBox(
                  height: 250.h,
                  child: ListView.separated(
                    //    physics:  NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => //5
                        SizedBox(
                      height: 15.h,
                    ),
                    shrinkWrap: true,
                    itemCount: isCoach
                        ? state.selectedCoaches.length
                        : state.selectedUsers.length,
                    //     _selectedCoaches.length,
                    itemBuilder: (context, index) {
                      late UserModel user;
                      if (isCoach == true)
                        user = state.selectedCoaches[index];
                      else
                        user = state.selectedUsers[index];
                      return Container(
                        width: 360.w,
                        height: 25.h,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 25.w,
                              height: 25.h,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(),
                              child: Stack(
                                children: [
                                  //svg image delete which is svg image images/delete-2_svgrepo.com.svg
                                  InkWell(
                                      onTap: () {
                                        if (isCoach) {
                                          // setState(() {
                                          //   _selectedCoaches.remove(user);
                                          //   _selectedCoachesUids.remove(user.uId!);
                                          // });
                                          context
                                              .read<AddGroupCubit>()
                                              .deselectCoach(user);
                                        } else {
                                          // setState(() {
                                          //   _selectedUsers.remove(user);
                                          //   _selectedUsersUids.remove(user.uId!);
                                          // });
                                          context
                                              .read<AddGroupCubit>()
                                              .deselectUser(user);
                                        }
                                      },
                                      child: SvgPicture.asset(
                                          'assets/images/delete-2_svgrepo.com.svg')),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      //   '${user.name}-${index + 1}',
                                      //make the text from right to left to handl arabic and make 1 2 3 4 5 6 7 8 9 10
                                      '${index + 1}-${user.name}',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: 'Montserrat-Arabic',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  class SelectBranchScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Text(
              ':اقصى عدد للمتدربين',
              //make it in arabic align right

              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 14.sp,
                fontFamily: 'IBM Plex Sans Arabic',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Container(
              width: 150.w,
              height: 48.h,
              //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Color(0xFFF6F6F6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text(
                  //   // اقصى عدد
                  //   ':اقصى عدد',
                  //   style: TextStyle(
                  //     color: Color(0xFF666666),
                  //     fontSize: 16,
                  //     fontFamily: 'IBM Plex Sans Arabic',
                  //     fontWeight: FontWeight.w400,
                  //     height: 0,
                  //   ),
                  // ),
                  Flexible(
                    child: TextFormField(
                      onEditingComplete: () {
                        // Unfocus the text field when editing is complete
                        FocusScope.of(context).unfocus();
                      },
                      //rtl
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context
                            .read<AddGroupCubit>()
                            .updateMaxUsers(int.parse(value));
                      },
                      decoration: InputDecoration(
                        hintText: ':اقصى عدد',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'مكان التدريب:',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16.sp,
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          //SizedBox(height: 5.0.h),
          // List<String> items = ['Item 1', 'Item 2', 'Item 3'];

          BlocBuilder<ManageAttendenceCubit, ManageAttendenceState>(
            builder: (context, state) {
              return ManageAttendenceCubit.get(context).branches == null
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      height: 400.h,
                      child: CheckboxListWidget(
                        onBranchSelected: (branch) {
                          // setState(() {
                          //   print('selected branch: $branch');
                          //   selectedBranch = branch;
                          // });
                          ManageAttendenceCubit.get(context)
                              .updateSelectedBranch(branch);
                        },
                        items: ManageAttendenceCubit.get(context).branches ?? [],
                      ),
                    );
            },
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     if (_formKey.currentState!.validate()) {
          //       _formKey.currentState!.save();
          //       // Do something with _maxUsers
          //       Navigator.pop(context);
          //     }
          //   },
          //   child: Text('Save'),
          // ),
        ],
      );
    }
  }

  //info sceen
  //make screen contat listofusers aand list of coaches and list of times and selectedBranch
  //and maxUsers
  class InfoScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return BlocBuilder<AddGroupCubit, AddGroupState>(
        builder: (context, state) {
          //context.read<AddGroupCubit>() . make object from cubit
          final addGroupCubit = context.read<AddGroupCubit>();
          return SingleChildScrollView(
            // physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(bottom: 28.0.h),
              child: Column(
                children: [
                  state.selectedCoaches.isNotEmpty
                      ? Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: Text(
                                ':المدربين',
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 14.sp,
                                  fontFamily: 'IBM Plex Sans Arabic',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),

                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => //5
                        SizedBox(
                      height: 10.h,
                    ),
                    shrinkWrap: true,
                    itemCount: context
                        .read<AddGroupCubit>()
                        .state
                        .selectedCoaches
                        .length,
                    itemBuilder: (context, index) {
                      final user = context
                          .read<AddGroupCubit>()
                          .state
                          .selectedCoaches[index];
                      return Container(
                        width: 360.w,
                        height: 25.h,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 25.w,
                              height: 25.h,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(),
                              child: Stack(
                                children: [
                                  //svg image delete which is svg image images/delete-2_svgrepo.com.svg
                                  InkWell(
                                      onTap: () {
                                        //   setState(() {
                                        //     _SelectCoachesScreenState()
                                        //         .selectedCoaches
                                        //         .remove(user);
                                        //   });
                                        // },
                                        context
                                            .read<AddGroupCubit>()
                                            .deselectCoach(user);
                                      },
                                      child: SvgPicture.asset(
                                          'assets/images/delete-2_svgrepo.com.svg')),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${index + 1}-${user.name}',
                                      //make the text from right to left to handl arabic and make 1 2 3 4 5 6 7 8 9 10
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: 'Montserrat-Arabic',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  state.selectedUsers.isNotEmpty
                      ? Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: Text(
                                ':الطلاب',
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 14.sp,
                                  fontFamily: 'IBM Plex Sans Arabic',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        )
                      : SizedBox(),

                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => //5
                        SizedBox(
                      height: 10.h,
                    ),
                    shrinkWrap: true,
                    itemCount:
                        context.read<AddGroupCubit>().state.selectedUsers.length,
                    itemBuilder: (context, index) {
                      final user = context
                          .read<AddGroupCubit>()
                          .state
                          .selectedUsers[index];
                      return Container(
                        width: 360.w,
                        height: 25.h,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 25.w,
                              height: 25.h,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(),
                              child: Stack(
                                children: [
                                  //svg image delete which is svg image images/delete-2_svgrepo.com.svg
                                  InkWell(
                                      onTap: () {
                                        // setState(() {
                                        //   _SelectCoachesScreenState()
                                        //       .selectedUsers
                                        //       .remove(user);
                                        // });
                                        context
                                            .read<AddGroupCubit>()
                                            .deselectUser(user);
                                      },
                                      child: SvgPicture.asset(
                                          'assets/images/delete-2_svgrepo.com.svg')),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${index + 1}-${user.name}',
                                      //make the text from right to left to handl arabic and make 1 2 3 4 5 6 7 8 9 10
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontFamily: 'Montserrat-Arabic',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  //Text(
                  //     'اقصى عدد للمتدربين: ',
                  //     style: TextStyle(
                  //         color: Color(0xFF333333),
                  //         fontSize: 14,
                  //         fontFamily: 'IBM Plex Sans Arabic',
                  //         fontWeight: FontWeight.w400,
                  //         height: 0,
                  //     ),
                  // )
                  SizedBox(
                    height: 20.h,
                  ),
                  // Text(
                  //   'اقصى عدد للمتدربين: ${_SelectBranchScreenState().maxUsers}',
                  //   textAlign: TextAlign.right,
                  //   style: TextStyle(
                  //     color: Color(0xFF333333),
                  //     fontSize: 14,
                  //     fontFamily: 'IBM Plex Sans Arabic',
                  //     fontWeight: FontWeight.w400,
                  //     height: 0,
                  //   ),
                  // ),
                  state.maxUsers != null
                      ? Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: Text(
                                ':اقصى عدد للمتدربين',
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 14.sp,
                                  fontFamily: 'IBM Plex Sans Arabic',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${state.maxUsers} اقصى عدد للمتدربين',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontFamily: 'Montserrat-Arabic',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        )
                      : SizedBox(),

                  //
                  //
                  //                         '${ManageAttendenceCubit.get(context).selectedBranch}',

                  BlocBuilder<ManageAttendenceCubit, ManageAttendenceState>(
                    builder: (context, state) {
                      return ManageAttendenceCubit.get(context).selectedBranch == null
                          ? SizedBox()
                          : Column(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Align(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: Text(
                                    //:مكان التدريب'
                                    ':مكان التدريب',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 14.sp,
                                      fontFamily: 'IBM Plex Sans Arabic',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        ' ${ManageAttendenceCubit.get(context).selectedBranch} ',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontFamily: 'Montserrat-Arabic',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            );
                    },
                  ),
                  //${ManageAttendenceCubit.get(context).selectedBranch}

                  //Text(
                  // 'التوقيات:',
                  // style: TextStyle(
                  //     color: Color(0xFF333333),
                  //     fontSize: 14,
                  //     fontFamily: 'IBM Plex Sans Arabic',
                  //     fontWeight: FontWeight.w400,
                  //     height: 0,
                  // ),
                  //)
                  //show times like that
                  //Text(
                  //     'الاحد ',
                  //     textAlign: TextAlign.right,
                  //     style: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 12,
                  //         fontFamily: 'Montserrat-Arabic',
                  //         fontWeight: FontWeight.w300,
                  //         height: 0,
                  //     ),
                  // )
                  // Text(
                  //     '11:00AM - 12:00AM',
                  //     textAlign: TextAlign.right,
                  //     style: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 12,
                  //         fontFamily: 'Montserrat-Arabic',
                  //         fontWeight: FontWeight.w400,
                  //         height: 0,
                  //     ),
                  // ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //context.read<AddGroupCubit>().times
                  //check if times values is null or not
                  //if null return empty container
                  //  static final Map<String, Map<dynamic, dynamic>> _times = {
                  //     'السبت': {'start': null, 'end': null},
                  //     'الأحد': {'start': null, 'end': null},
                  //     'الاثنين': {'start': null, 'end': null},
                  //     'الثلاثاء': {'start': null, 'end': null},
                  //     'الأربعاء': {'start': null, 'end': null},
                  //     'الخميس': {'start': null, 'end': null},
                  //     'الجمعة': {'start': null, 'end': null},
                  //   };
                  //check if start is null or not for all keys not first element only if null return empty container
                  //if not null return text
                  context
                          .read<AddGroupCubit>()
                          .times
                          .values
                          .every((time) => time['start'] == null)
                      ? SizedBox()
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  ':التوقيات',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 14.sp,
                                    fontFamily: 'IBM Plex Sans Arabic',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                            ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => //5
                                  SizedBox(
                                height: 5.h,
                              ),
                              shrinkWrap: true,
                              itemCount:
                                  context.read<AddGroupCubit>().times.length,
                              itemBuilder: (context, index) {
                                final day = context
                                    .read<AddGroupCubit>()
                                    .times
                                    .keys
                                    .toList()[index];
                                final time =
                                    context.read<AddGroupCubit>().times[day];
                                return
                                    //if day is null return empty container
                                    time?['start'] == null
                                        ? Container()
                                        : Container(
                                            width: 360.w,
                                            height: 50.h,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '$day',
                                                  //make the text from right to left to handl arabic and make 1 2 3 4 5 6 7 8 9 10
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.sp,
                                                    fontFamily:
                                                        'Montserrat-Arabic',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        '${time?['start']?.format(context).toString().replaceAll('PM', 'م').replaceAll('AM', 'ص')} - ${time?['end']?.format(context).toString().replaceAll('PM', 'م').replaceAll('AM', 'ص')}',
                                                        //make the text from right to left to handl arabic and make 1 2 3 4 5 6 7 8 9 10
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14.sp,
                                                          fontFamily:
                                                              'Montserrat-Arabic',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                              },
                            ),
                          ],
                        ),
                ],
              ),
            ),
          );
        },
      );
    }
  }