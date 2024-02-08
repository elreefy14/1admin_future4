//import 'package:connectivity/connectivity.dart';
import 'dart:math';
//import 'package:firestore_cache/firestore_cache.dart';
import 'package:admin_future/home/data/schedules.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../add_grouup_of_schedules/presentation/onboarding_screen.dart';
import '../../../core/constants/routes_manager.dart';
import '../../../core/flutter_flow/flutter_flow_util.dart';
import '../../../registeration/data/userModel.dart';
import '../../presenation/widget/manage_groups_screen.dart';
import 'manage_attendence_state.dart';
import '../../../manage_users_coaches/business_logic/manage_users_cubit.dart';
// ****this is my firestore Collections and Documents:**
// - *users*: A collection to store the information of all coaches.
// - Document ID: unique coach ID
// - Fields: *`name`, *`level`*, *`hourly_rate`*, *`total_hours`*, *`total_salary`*, *`current_month_hours`*, *`current_month_salary`**
//  *admins*: A collection to store the information of all admins.
//  - Document ID: unique admin ID
//  - Fields: *`name`, *`email`*, *`branch_id`** (the ID of the branch they're responsible for)
// - Subcollection: *`schedules`*
// - Document ID: unique schedule ID
// - Fields: *`branch_id`, *`start_time`*, *`end_time`*, *`date`*, *`finished`**

// - *branches*: A collection to store the information of all branches.
// - Document ID: unique branch ID
// - Fields: *`name`, *`address`**
// - Subcollection: *`coaches`*
// - Document ID: unique coach ID who works at this branch
//
// -
// - *schedules*: A collection to store the information of all schedules.
// - Document ID: unique schedule ID
// - Fields: *`branch_id`, *`start_time`*, *`end_time`*, *`date`**
// - Subcollection: *`attendance`*
// - Document ID: unique attendance ID (usually just the coach ID)
// - Fields: *`attended`, *`qr_code`**

class ManageAttendenceCubit extends Cubit<ManageAttendenceState> {
  ManageAttendenceCubit() : super(InitialState()) {}
  static ManageAttendenceCubit get(context) => BlocProvider.of(context);
  // function to get string
//     // get the nearest schedule to the current timw using utc time
//      //schedulesList is a list of all schedules for the current day which is stored descendingly
//      //loop on the list and check if the current time is less than the start time of the schedule
//       //if it is less than the start time then this is the nearest schedule
//       //if it is not less than the start time then check if it is less than the end time
  //use utc time
  //use catch error to catch the error
  //use emit to emit the state

  Map<String, dynamic>? nearestSchedule;
  static List<Map<String, dynamic>> schedulesList = [];
  List<Map<String, dynamic>> schedulesList2 = [];
  // Subcollection: *`schedules`*
// - Document ID: unique schedule ID
// - Fields: *`branch_id`, *`start_time`*, *`end_time`*, *`date`*, *`finished`**

  void addToWhatsAppGroup(String groupLink, String phoneNumber) async {
    final url = 'https://wa.me/$phoneNumber?text=Please%20add%20me%20to%20the%20group%20$groupLink';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

void sendWhatsAppMessage(String phoneNumber) async {
  final message = Uri.encodeComponent('hello');
  final url = 'https://wa.me/$phoneNumber?text=$message';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


  Future<void> getNearestSchedule() async {
    try {
      emit(GetNearestScheduleLoadingState());

      final DateTime now = DateTime.now();
      final String today = getdayinArabic();
      final schedulesCollection = FirebaseFirestore.instance
          .collection('admins')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('schedules')
          .doc(today)
          .collection('schedules');

      final QuerySnapshot snapshot = await schedulesCollection
          .orderBy('start_time', descending: false)
          .get();

      List<Map<String, dynamic>> schedulesList = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      for (final Map<String, dynamic> schedule in schedulesList) {
        final DateTime utcStartTime = schedule['start_time'].toDate().toUtc();
        final DateTime utcEndTime = schedule['end_time'].toDate().toUtc();

        final DateTime utcNow = DateTime.utc(
            now.year, now.month, now.day, now.hour, now.minute, now.second);

        if (utcNow.isBefore(utcStartTime)) {
          nearestSchedule = schedule;
          break;
        } else if (utcNow.isAfter(utcStartTime) &&
            utcNow.isBefore(utcEndTime)) {
          nearestSchedule = schedule;
          break;
        }
      }

      if (nearestSchedule != null) {
        print('nearestSchedule:\n\n\n ');
        // print(nearestSchedule['start_time'].toDate().toUtc());
      }

      emit(GetNearestScheduleSuccessState(
          // nearestSchedule,
          ));
    } catch (e) {
      print('Error in getNearestSchedule()\n\n\n\n');
      print(e.toString());
      emit(GetNearestScheduleErrorState(e.toString()));
    }
  }

  Map<String, dynamic>? firstSchedule; // Variable to store the first schedule

  Future<void> getSchedulesForAdmin() async {
    initializeDateFormatting();
    emit(GetSchedulesForAdminLoadingState());
    try {
      final DateTime now = DateTime.now();
      final DateTime startOfToday = DateTime(now.year, now.month, now.day);
      //  final schedulesCollection = FirebaseFirestore.instance
      //           .collection('admins')
      //           .doc(FirebaseAuth.instance.currentUser!.uid)
      //           .collection('schedules')
      //           .doc(today)
      //           .collection('schedules');
      final String today = getdayinArabic();
      final QuerySnapshot schedulesQuerySnapshot = await FirebaseFirestore
          .instance
          .collection('admins')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('schedules')
          .doc(today)
          .collection('schedules')
          // Start_time greater than or equal to yesterday 12:00 am and less than tomorrow 12:00 am
          .where('start_time', isGreaterThanOrEqualTo: startOfToday.toUtc())
          .where('start_time',
              isLessThan: startOfToday.add(const Duration(days: 1)).toUtc())
          .orderBy('start_time', descending: false)
          .get(
            const GetOptions(
              source: Source.serverAndCache,
            ),
          );

      for (final QueryDocumentSnapshot scheduleDoc
          in schedulesQuerySnapshot.docs) {
        final Map<String, dynamic> scheduleData =
            scheduleDoc.data() as Map<String, dynamic>;

        final QuerySnapshot usersQuerySnapshot =
            await scheduleDoc.reference.collection('users').get(
                  const GetOptions(
                    source: Source.serverAndCache,
                  ),
                );

        final List<Map<String, dynamic>> usersList = usersQuerySnapshot.docs
            .map<Map<String, dynamic>>(
              (QueryDocumentSnapshot documentSnapshot) =>
                  documentSnapshot.data() as Map<String, dynamic>,
            )
            .toList();

        final Map<String, dynamic> scheduleWithUserData = {
          ...scheduleData,
          'users': usersList,
        };

        schedulesList.add(scheduleWithUserData);
      }

      emit(GetSchedulesForAdminSuccessState());
    } catch (e) {
      emit(GetSchedulesForAdminErrorState(e.toString()));
    }
  }
  // Future<void> getSchedulesForAdmin(SharedPreferences sharedPreferences) async {
  //   initializeDateFormatting();
  //   emit(GetSchedulesForAdminLoadingState());
  //   try {
  //     final DateTime now = DateTime.now();
  //     final String todayKey = 'schedules_${now.year}_${now.month}_${now.day}';
  //
  //     if (sharedPreferences.containsKey(todayKey)) {
  //       final String schedulesJson = sharedPreferences.getString(todayKey);
  //       // Convert schedulesJson to a List<Map<String, dynamic>> and use it as needed
  //       // You can skip the Firestore query and emit success state here
  //       emit(GetSchedulesForAdminSuccessState());
  //       return;
  //     }
  //
  //     final DateTime startOfToday = DateTime(now.year, now.month, now.day);
  //     final QuerySnapshot schedulesQuerySnapshot = await FirebaseFirestore.instance
  //         .collection('admins')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('schedules')
  //     // Start_time greater than or equal to yesterday 12:00 am and less than tomorrow 12:00 am
  //         .where('start_time', isGreaterThanOrEqualTo: startOfToday.toUtc())
  //         .where('start_time', isLessThan: startOfToday.add(const Duration(days: 1)).toUtc())
  //         .orderBy('start_time', descending: false)
  //         .get(
  //       const GetOptions(
  //         source: Source.serverAndCache,
  //       ),
  //     );
  //
  //     final List<Map<String, dynamic>> schedulesList = [];
  //
  //     for (final QueryDocumentSnapshot scheduleDoc in schedulesQuerySnapshot.docs) {
  //       final Map<String, dynamic> scheduleData = scheduleDoc.data() as Map<String, dynamic>;
  //
  //       final QuerySnapshot usersQuerySnapshot = await scheduleDoc.reference
  //           .collection('users')
  //           .get(
  //         const GetOptions(
  //           source: Source.serverAndCache,
  //         ),
  //       );
  //
  //       final List<Map<String, dynamic>> usersList = usersQuerySnapshot.docs
  //           .map<Map<String, dynamic>>(
  //             (QueryDocumentSnapshot documentSnapshot) =>
  //         documentSnapshot.data() as Map<String, dynamic>,
  //       )
  //           .toList();
  //
  //       final Map<String, dynamic> scheduleWithUserData = {
  //         ...scheduleData,
  //         'users': usersList,
  //       };
  //
  //       schedulesList.add(scheduleWithUserData);
  //     }
  //
  //     // After processing the schedulesList, store it in SharedPreferences
  //     final String schedulesJson = json.encode(schedulesList);
  //     await sharedPreferences.setString(todayKey, schedulesJson);
  //
  //     emit(GetSchedulesForAdminSuccessState());
  //   } catch (e) {
  //     emit(GetSchedulesForAdminErrorState(e.toString()));
  //   }
  // }

  void generateRandomData() async {
    print('Generating random data...');
    final CollectionReference adminsCollection =
        FirebaseFirestore.instance.collection('admins');
    final CollectionReference branchesCollection =
        FirebaseFirestore.instance.collection('branches');

    final List<String> adminNames = ['Alice', 'Bob', 'Charlie', 'David'];
    final List<String> branchNames = [
      'Branch A',
      'Branch B',
      'Branch C',
      'Branch D'
    ];
    final List<String> branchAddresses = [
      '123 Main St',
      '456 Elm St',
      '789 Oak St',
      '321 Pine St'
    ];

    final Random random = Random();

    // Get the admin with UID Oco5jDV6nkhA4jgkStLCTbiB2hJ3
    final QuerySnapshot adminSnapshot = await adminsCollection
        .where('id', isEqualTo: 'Oco5jDV6nkhA4jgkStLCTbiB2hJ3')
        .get();

    if (adminSnapshot.docs.length == 0) {
      return; // Admin not found
    }

    final DocumentReference adminDocRef = adminSnapshot.docs.first.reference;

    // Generate 2 random schedules for this admin
    for (int j = 0; j < 2; j++) {
      final int branchId =
          random.nextInt(4) + 1; // Random branch ID between 1-4
      final DateTime now = DateTime.now();
      final DateTime startDate = now.add(Duration(
          days: random.nextInt(7))); // Random start date within the next 7 days
      final DateTime endDate = startDate.add(Duration(
          hours: 4 +
              random.nextInt(
                  4))); // Random end date within 4-7 hours of start date

      final Map<String, dynamic> scheduleData = {
        'branch_id': branchId,
        'start_time': Timestamp.fromDate(startDate),
        'end_time': Timestamp.fromDate(endDate),
        'date': Timestamp.fromDate(startDate),
        'finished': false,
      };

      final DocumentReference scheduleDocRef =
          await adminDocRef.collection('schedules').add(scheduleData);

      // Generate 3 random users for this schedule
      for (int k = 0; k < 3; k++) {
        final String name = 'User ${k + 1}';
        final int level = random.nextInt(3) + 1; // Random level between 1-3
        final int hourlyRate =
            10 + random.nextInt(20); // Random hourly rate between 10-30
        final int totalHours =
            random.nextInt(50); // Random total hours between 0-50
        final int currentMonthHours =
            random.nextInt(20); // Random current month hours between 0-20
        final int currentMonthSalary = currentMonthHours * hourlyRate;

        final Map<String, dynamic> userData = {
          'name': name,
          'finished': false,
          'phone': '123-456-7890',
          'hourly_rate': hourlyRate,
          'total_hours': totalHours,
          'total_salary': totalHours * hourlyRate,
          'current_month_hours': currentMonthHours,
          'current_month_salary': currentMonthSalary,
        };

        await scheduleDocRef.collection('users').add(userData);
      }
    }

    // Generate 4 random branches
    for (int i = 0; i < 4; i++) {
      final String name = branchNames[random.nextInt(branchNames.length)];
      final String address =
          branchAddresses[random.nextInt(branchAddresses.length)];

      final Map<String, dynamic> branchData = {
        'name': name,
        'address': address,
      };

      final DocumentReference branchDocRef =
          await branchesCollection.add(branchData);

      // Generate 3 random coaches for this branch
      for (int j = 0; j < 3; j++) {
        final String coachId = 'Coach ${j + 1}';

        final Map<String, dynamic> coachData = {
          'coach_id': coachId,
        };

        await branchDocRef.collection('coaches').add(coachData);
      }
    }
  }

  bool? updatedFinishedValue;

  void changeAttendance(String scheduleId, String userId, bool? value) async {
    final CollectionReference adminsCollection =
        FirebaseFirestore.instance.collection('admins');
    final DocumentSnapshot scheduleSnapshot = await adminsCollection
        .doc(
          FirebaseAuth.instance.currentUser!.uid,
        )
        .get();
    final DocumentReference userRef = scheduleSnapshot.reference
        .collection('schedules')
        .doc(scheduleId)
        .collection('users')
        .doc(userId);

    if (value != null) {
      try {
        // Fetch the current value of 'finished' from Firestore
        final DocumentSnapshot userSnapshot = await userRef.get();
        final Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>? ?? {};
        final bool currentFinishedValue = userData['finished'] ?? false;

        // Toggle the value of 'finished'
        updatedFinishedValue = !currentFinishedValue;

        emit(AttendanceChangedState(updatedFinishedValue!));

        // Update the document with the new value
        await userRef.update({'finished': updatedFinishedValue});

        // Update the schedulesList for the specific user
        // for (int i = 0; i < schedulesList.length; i++) {
        //   final Map<String, dynamic> schedule = schedulesList[i];
        //   if (schedule['id'] == scheduleId) {
        //     final List<Map<String, dynamic>> usersList =
        //     List<Map<String, dynamic>>.from(schedule['users']);
        //     for (int j = 0; j < usersList.length; j++) {
        //       if (usersList[j]['id'] == userId) {
        //         usersList[j]['finished'] = updatedFinishedValue;
        //         break;
        //       }
        //     }
        //     schedulesList[i]['users'] = usersList;
        //     break;
        //   }
        // }
      } catch (e) {
        // If there's an error updating the document, it means there's no internet connection
        // Use FirestoreCache to store the update locally
        // await FirestoreCache.set(userRef, {'finished': updatedFinishedValue});
      }
    }
  }

  String getdayinArabic() {
    final DateTime now = DateTime.now();
    final String dayOfWeek = DateFormat('EEEE').format(now);
    switch (dayOfWeek) {
      case 'Saturday':
        return 'السبت';
      case 'Sunday':
        return 'الأحد';
      case 'Monday':
        return 'الاثنين';
      case 'Tuesday':
        return 'الثلاثاء';
      case 'Wednesday':
        return 'الأربعاء';
      case 'Thursday':
        return 'الخميس';
      case 'Friday':
        return 'الجمعة';
      default:
        return 'السبت';
    }
  }

// - *admins*: A collection to store the information of all admins.
//   - Document ID: unique admin ID
//   - Fields:*`phone`*, *`name`*, *`email`*, *`branches`* (list of string of the branches they're responsible for) ,pId
//   - Subcollection: *`schedules`*
//     - Document ID: unique schedule ID
//     - Fields: *`branch_id`*, *`start_time`*, *`end_time`*, *`date`*,
//     - Subcollection: *`users`*
//       - Document ID: unique user ID
//       - Fields: *`name`*, *`phone`*, *`hourly_rate`*, *`total_hours`*, *`total_salary`*, *`current_month_hours`*, *`current_month_salary`* ,*`finished`*
//   - Subcollection: *`salaryHistory`*
//     - Document ID: unique salary history ID (usually just the month and year)
//     - Fields: *`month`*, *`year`*, *`total_hours`*, *`total_salary`*
//   - Fields: *`branches`* (array of branch IDs that the admin is responsible for)
//
// - *branches*: A collection to store the information of all branches.
//   - Document ID: unique branch ID
//   - Fields: *`name`*, *`address`*
//   - Subcollection: *`coaches`*
//     - Document ID: unique coach ID who works at this branch
//get all user where pid equal FirebaseAuth.instance.currentUser!.uid
  List<UserModel>? MyUsers;
  List<String>? MyUsersNames;
  List<String>? branches;

  Future<void> getAdminData() async {
    try {
      emit(GetUserDataLoadingState());
      //get list branches from firebase admins collection
      final CollectionReference branchesCollection =
          FirebaseFirestore.instance.collection('admins');
      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      final QuerySnapshot usersQuerySnapshot = await usersCollection
          .where('pid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get(
            const GetOptions(
              source: Source.serverAndCache,
            ),
          );

      // - *admins*: A collection to store the information of all admins.
      //   - Document ID: unique admin ID
      //   - Fields:*`phone`*, *`name`*, *`email`*, *`branches`* (list of string of the branches they're responsible for) ,pId
      //get list of branches from firebase admins collection
      final DocumentSnapshot adminSnapshot = await branchesCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final Map<String, dynamic> adminData =
          adminSnapshot.data() as Map<String, dynamic>;
      branches = List<String>.from(adminData['branches']);

      final List<UserModel> usersList = [];
      MyUsersNames = []; // Initialize MyUsersNames as an empty list

      for (final QueryDocumentSnapshot userDoc in usersQuerySnapshot.docs) {
        final Map<String, dynamic> userData =
            userDoc.data() as Map<String, dynamic>;
        usersList.add(UserModel.fromJson(userData));
        // add usersname to list
        MyUsersNames!.add(
            userData['name']); // Use MyUsersNames! to access the non-null list
        print(userData['name']);
        print(MyUsersNames);
        print(MyUsers?.length);
      }
      MyUsers = usersList;
      emit(GetUserDataSuccessState());
    } catch (e) {
      emit(GetUserDataErrorState(e.toString()));
    }
  }

  Future deleteSchedule({
    context,
    required String scheduleId,
    required String day,
    required List<String>? usersIds,
  }) {
    //emit(DeleteScheduleLoadingState());
    return FirebaseFirestore.instance
        .collection('admins')
        //todo change this to admin id
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('schedules')
        .doc(day)
        .collection('schedules')
        .doc(scheduleId)
        .delete()
        .then((value) async {
      print('Schedule deleted');

      // Delete the subcollection 'users'
      FirebaseFirestore.instance
          .collection('admins')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('schedules')
          .doc(day)
          .collection('schedules')
          .doc(scheduleId)
          .collection('users')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });

      // Remove the schedule from the list of schedules
      ManageUsersCubit.get(context)
          .schedules
          .removeWhere((schedule) => schedule.scheduleId == scheduleId);

      // Delete the schedule from each user's collection
      if (usersIds != null) {
        for (String userId in usersIds) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('schedules')
              .doc(scheduleId)
              .delete()
              .then((value) {
            print('Schedule deleted from user $userId');
          }).catchError((error) {
            print('Failed to delete schedule from user $userId: $error');
          });
        }
      }

      //emit(DeleteScheduleSuccessState());
    }).catchError((error) {
      print(error.toString());
      // emit(DeleteScheduleErrorState(error.toString()));
    });
  }

  Future<void> updateSchedule({
    String? scheduleId,
    Timestamp? startTrainingTime,
    Timestamp? endTrainingTime,
    String? branch,
    context,
    required usersIds,
    required String date,
  }) async {
    emit(AddScheduleLoadingState());

    List<String> days = selectedDays ?? [];
    List<String> coaches = selectedCoaches ?? [];
    //ManageSalaryCubit manageSalaryCubit = ManageSalaryCubit();

    try {
      if (days.length > 1) {
        //emit(AddScheduleLoadingState());
        //delete schedule for the first day in the list
        deleteSchedule(
            context: context,
            scheduleId: scheduleId!,
            day: date,
            usersIds: usersIds);
        // add the schedule for the first day in the list
        // emit(AddScheduleLoadingState());
        addSchedule(false, context,
            startTrainingTime: startTrainingTime!,
            endTrainingTime: endTrainingTime!,
            branch: branch!);
        //if usersList is not empty then update the subcollection users
        // if (coaches.isNotEmpty) {
        //   for (var coach in coaches) {
        //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        //         .collection('users')
        //         .where('name', isEqualTo: coach)
        //         .get();
        //     if (querySnapshot.docs.isNotEmpty) {
        //       String userId = querySnapshot.docs.first.id;
        //       await FirebaseFirestore.instance
        //           .collection('admins')
        //           .doc(FirebaseAuth.instance.currentUser!.uid)
        //           .collection('schedules')
        //           .doc(days[0])
        //           .collection('schedules')
        //           .doc(scheduleId)
        //           .collection('users')
        //           .doc(userId)
        //           .set({
        //         'name': querySnapshot.docs.first['name'],
        //         'uid': userId,
        //         'finished': false,
        //       });
        //     }
        //   }
        // }
        // Create new schedules for the rest of the days in the list
        // for (int i = 1; i < days.length; i++) {

        //   await FirebaseFirestore.instance
        //       .collection('admins')
        //       .doc(FirebaseAuth.instance.currentUser!.uid)
        //       .collection('schedules')
        //       .doc(days[i])
        //       .collection('schedules')
        //       .add({
        //     'start_time': startTrainingTime,
        //     'end_time': endTrainingTime,
        //     'date': days[i],
        //     'branch_id': branch,
        //     'usersList': coaches
        //   });
        // }
        //chect if date is in selected days then update the schedule
        // if (days.contains(date)) {
        ScheduleModel? schedule = ScheduleModel(
          pId: FirebaseAuth.instance.currentUser!.uid,
          branchId: branch,
          startTime: startTrainingTime,
          endTime: endTrainingTime,
          finished: false,
          usersList: coaches,
          userIds: usersIds,
          scheduleId: scheduleId,
          date: date,
          nearestDay: Timestamp.fromDate(DateTime.now()),
        );
        ManageUsersCubit.get(context).updateSchedules(schedule!);
        // }
      } else {
        ManageUsersCubit.get(context).deleteSchedule(
            scheduleId: scheduleId!, day: date, usersIds: usersIds);
        // add the schedule for the first day in the list
        addSchedule(false, context,
            startTrainingTime: startTrainingTime!,
            endTrainingTime: endTrainingTime!,
            branch: branch!);
        ScheduleModel? schedule = ScheduleModel(
          pId: FirebaseAuth.instance.currentUser!.uid,
          branchId: branch,
          startTime: startTrainingTime,
          endTime: endTrainingTime,
          finished: false,
          usersList: coaches,
          userIds: usersIds,
          scheduleId: scheduleId,
          date: date,
          nearestDay: Timestamp.fromDate(DateTime.now()),
        );
        ManageUsersCubit.get(context).updateSchedules(schedule!);
        // Update the schedule for the only day in the list
        // await FirebaseFirestore.instance
        //     .collection('admins')
        //     .doc(FirebaseAuth.instance.currentUser!.uid)
        //     .collection('schedules')
        //     .doc(days[0])
        //     .collection('schedules')
        //     .doc(scheduleId)
        //     .update({
        //   'start_time': startTrainingTime,
        //   'end_time': endTrainingTime,
        //   'date': days[0],
        //   'branch_id': branch,
        //   'usersList': coaches,
        // });
      }

      // Update the user information in the subcollection
      // for (var coach in coaches) {
      //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      //       .collection('users')
      //       .where('name', isEqualTo: coach)
      //       .get();
      //
      //   for (var doc in querySnapshot.docs) {
      //     String userId = doc.id;
      //     await FirebaseFirestore.instance
      //         .collection('admins')
      //         .doc(FirebaseAuth.instance.currentUser!.uid)
      //         .collection('schedules')
      //         .doc(days[0])
      //         .collection('schedules')
      //         .doc(scheduleId)
      //         .collection('users')
      //         .doc(userId)
      //         .set({
      //       'name': doc['name'],
      //       'uid': userId,
      //       'finished': false,
      //     });
      //   }
      // }
      // Import the ManageSalaryCubit file
      // Create an instance of ManageSalaryCubit
      // final manageSalaryCubit = ManageSalaryCubit();
      // print('days[0]: ${days[0]}');
      // await manageSalaryCubit.getSchedules(day: days[0]);
      emit(AddSchedulefinishState());
      //show toast
      Fluttertoast.showToast(
          msg: 'تم تعديل المواعيد بنجاح',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      print('Error updating schedule: $e');
      emit(AddScheduleErrorState(e.toString()));
      Fluttertoast.showToast(
          msg: 'حدث خطأ أثناء تعديل المواعيد',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  // Define a function to get the nearest day of the week
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
 Future<void> addSchedule(bool isEmit,BuildContext context,
      {required Timestamp startTrainingTime,
      required Timestamp endTrainingTime,
      required String branch}) async {
    List<String> days = selectedDays ?? [];
    List<String> coaches = selectedCoaches ?? [];

    ManageUsersCubit manageSalaryCubit = ManageUsersCubit();
    ScheduleModel? schedule;
    try {
      //emit(LoadingState());
      if(isEmit)
      emit(AddScheduleLoadingState());
      for (var day in days) {
        // Get the nearest day of the week
        DateTime nearestDay = getNearestDayOfWeek(day);

        // Convert the nearest day to a Timestamp object
        Timestamp nearestDayTimestamp = Timestamp.fromDate(nearestDay);

        await FirebaseFirestore.instance
            .collection('admins')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('schedules')
            .doc(day)
            .collection('schedules')
            .add({
          'start_time': startTrainingTime,
          'end_time': endTrainingTime,
          'date': day,
          'nearest_day':
              nearestDayTimestamp, // Add nearest day timestamp as a field
          'branch_id': branch,
          'usersList': [], // add empty usersList field to each schedule
          'userIds': [], // add empty userIds field to each schedule
        }).then((scheduleDoc) async {
          if (coaches.isNotEmpty) {
            for (var coach in coaches) {
              QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                  .collection('users')
                  .where('name', isEqualTo: coach)
                  .get();
              if (querySnapshot.docs.isNotEmpty) {

                String userId = querySnapshot.docs.first.id;
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .collection('schedules')
                    .doc(scheduleDoc.id)
                    .set({
                  'start_time': startTrainingTime,
                  'end_time': endTrainingTime,
                  'date': day,
                  'nearest_day':
                      nearestDayTimestamp, // Add nearest day timestamp as a field
                  'branch_id': branch,
                  'pId': FirebaseAuth.instance.currentUser!.uid,
                });
                await FirebaseFirestore.instance
                    .collection('admins')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('schedules')
                    .doc(day)
                    .collection('schedules')
                    .doc(scheduleDoc.id)
                    .collection('users')
                    .doc(userId)
                    .set({
                  'name': querySnapshot.docs.first['name'],
                  'uid' : userId,
                  'uid': userId,
                  'finished': false,
                });

                // add user to usersList field in schedule
                await scheduleDoc.update({
                  'usersList': FieldValue.arrayUnion([querySnapshot.docs.first['name']]),
                  'usersList':
                      FieldValue.arrayUnion([querySnapshot.docs.first['name']]),
                  'userIds': FieldValue.arrayUnion(
                      [userId]), // add userId to userIds field
                });

                // add schedule ID to the user's schedules subcollection
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .collection('schedules')
                    .doc(scheduleDoc.id)
                    .set({
                  'start_time': startTrainingTime,
                  'end_time': endTrainingTime,
                  'date': day,
                  'nearest_day':
                      nearestDayTimestamp, // Add nearest day timestamp as a field
                  'branch_id': branch,
                  'pId': FirebaseAuth.instance.currentUser!.uid,
                  'scheduleId': scheduleDoc.id,
                });
              }
            }
          }

          await scheduleDoc.update({
            'schedule_id': scheduleDoc.id,
          });

          // make schedules model and add them to the list of schedules
          schedule = ScheduleModel(
            startTime: startTrainingTime,
            endTime: endTrainingTime,
            date: day,
            nearestDay:
                nearestDayTimestamp, // Add nearest day timestamp as a field
            branchId: branch,
            usersList: coaches,
            userIds: [], // add empty userIds field to the schedule model
            scheduleId: scheduleDoc.id,
            finished: false,
            pId: FirebaseAuth.instance.currentUser!.uid,
          );
        });
      }

      //emit(SuccessState());
      emit(AddScheduleSuccessState());
      ManageUsersCubit.get(context).updateSchedules(schedule!);
      if(isEmit){
        emit(AddScheduleSuccessState());
        //show toast
        Fluttertoast.showToast(
            msg: 'تم إضافة المواعيد بنجاح',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }

    } catch (e) {
      if(isEmit)
      emit(AddScheduleErrorState(e.toString()));
    //  emit(ErrorState(errorMessage: 'Error updating schedule: $e'));
      Fluttertoast.showToast(
          msg: //print e
          'حدث خطأ أثناء إضافة المواعيد\n${e.toString()}',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  } 

  // Modify the addSchedule function to use the getNearestDayOfWeek function
  late Map<String, Map<dynamic, dynamic>> nonNullableDays = {};
Future<void> addGroup(
  bool isEmit,
  BuildContext context, {
  required List<UserModel> selectedCoaches,
  required Timestamp startTrainingTime,
  required Timestamp endTrainingTime,
  required String branch,
  Map<String, Map<dynamic, dynamic>>? times, String? maxUsers,
}) async {
  // void addSchedule(
  //     bool isEmit  ,
  //   BuildContext context, {
  //  // List<String>? selectedDays,
  //   String? startTrainingTime,
  //   String? endTrainingTime,
  //   String? branch,
  //   Map<String, Map<dynamic, dynamic>>? times,
  // }) async {
  //todo change use thsi map

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
  print('nonNullableDays: ${nonNullableDays.toString()}}');

  List<String> days = //get all non null days
      nonNullableDays.keys.toList();
  //get all non null days start and end time as timestamp . note start and end time is timeofday

  ScheduleModel? schedule;
  try {
    if (isEmit) emit(AddScheduleLoadingState());
    for (var day in days) {
      if (nonNullableDays.containsKey(day)) {
        //DateTime nearestDay = nonNullableDays[day]!['nearest_day'].toDate();
        Timestamp nearestDayTimestamp = nonNullableDays[day]!['nearest_day'];

        await FirebaseFirestore.instance
            .collection('admins')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('schedules')
            .doc(day)
            .collection('schedules')
            .add({
          'start_time': nonNullableDays[day]!['start'],
          'end_time': nonNullableDays[day]!['end'],
          'date': day,
          'nearest_day': nearestDayTimestamp,
          'branch_id': branch,
          'usersList': [],
          'userIds': [],
          'max_users': maxUsers,
        }).then((scheduleDoc) async {
          if (selectedCoaches != null && selectedCoaches.isNotEmpty) {
            for (var coach in selectedCoaches) {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(coach.uId)
                  .collection('schedules')
                  .doc(scheduleDoc.id)
                  .set({
                'start_time': nonNullableDays[day]!['start'],
                'end_time': nonNullableDays[day]!['end'],
                'date': day,
                'nearest_day': nearestDayTimestamp,
                'branch_id': branch,
                'pId': FirebaseAuth.instance.currentUser!.uid,
                'max_users': maxUsers,
              });
              await FirebaseFirestore.instance
                  .collection('admins')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('schedules')
                  .doc(day)
                  .collection('schedules')
                  .doc(scheduleDoc.id)
                  .collection('users')
                  .doc(coach.uId)
                  .set({
                'name': coach.name,
                'uid': coach.uId,
                'finished': false,
              });

              await scheduleDoc.update({
                'usersList': FieldValue.arrayUnion([coach.name]),
                'userIds': FieldValue.arrayUnion([coach.uId]),
              });

              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(coach.uId)
                  .collection('schedules')
                  .doc(scheduleDoc.id)
                  .set({
                'start_time': nonNullableDays[day]!['start'],
                'end_time': nonNullableDays[day]!['end'],
                'date': day,
                'nearest_day': nearestDayTimestamp,
                'branch_id': branch,
                'pId': FirebaseAuth.instance.currentUser!.uid,
                'scheduleId': scheduleDoc.id,
                'max_users': maxUsers,
              });
            }
          }

          await scheduleDoc.update({
            'schedule_id': scheduleDoc.id,
          });

          schedule = ScheduleModel(
            startTime: nonNullableDays[day]!['start'],
            endTime: nonNullableDays[day]!['end'],
            date: day,
            nearestDay: nearestDayTimestamp,
            branchId: branch,
            users : selectedCoaches,
            usersList: selectedCoaches?.map((coach) => coach.name).toList() ?? [],
            userIds: selectedCoaches?.map((coach) => coach.uId).toList() ?? [],
            scheduleId: scheduleDoc.id,
            finished: false,
            pId: FirebaseAuth.instance.currentUser!.uid,
            maxUsers: maxUsers,
          );
        });
      }
    }
    ManageUsersCubit.get(context).updateSchedules(schedule!);
    if (isEmit) {
      emit(AddScheduleSuccessState());
      Fluttertoast.showToast(
          msg: 'تم إضافة المواعيد بنجاح',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  } catch (e) {
    if (isEmit) emit(AddScheduleErrorState(e.toString()));
    Fluttertoast.showToast(
        msg: 'حدث خطأ أثناء إضافة المواعيد\n${e.toString()}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
  //edit this function so that when user selected day is saturday for example get the date of neareast saturday and add it as field in schedule in firebase

  //selected items
  List<String>? selectedCoaches;
  void add(String itemValue) {
    selectedCoaches ??= [];
    print('add');
    print(itemValue);
    print(itemValue.toString());
    selectedCoaches?.add(itemValue.toString());

    emit(UpdateSelectedItemsState(
        //  selectedItems: selectedItems,
        ));
    print(selectedCoaches);
  }

  void remove(String itemValue) {
    selectedCoaches ??= [];
    selectedCoaches?.remove(itemValue.toString());
    emit(UpdateSelectedItemsState());
    print(selectedCoaches);
  }

  void itemChange(String itemValue, bool isSelected, BuildContext context) {
    //final List<String> updatedSelection = List.from(
    //   SignUpCubit.get(context).selectedItems ?? []);

    if (isSelected) {
      add(itemValue);
      // updatedSelection.add(itemValue);
    } else {
      remove(itemValue);
      //  updatedSelection.remove(itemValue);
    }

    //  onSelectionChanged(updatedSelection);
  } //selected items

  List<String>? selectedDays;
  void add2(String itemValue) {
    selectedDays ??= [];
    print('add');
    print(itemValue);
    print(itemValue.toString());
    selectedDays?.add(itemValue.toString());

    emit(UpdateSelectedItemsState(
        //  selectedItems: selectedItems,
        ));
    print(selectedDays);
  }

  void remove2(String itemValue) {
    selectedDays ??= [];
    selectedDays?.remove(itemValue.toString());
    emit(UpdateSelectedItemsState());
    print(selectedDays);
  }

  void itemChange2(String itemValue, bool isSelected, BuildContext context) {
    //final List<String> updatedSelection = List.from(
    //   SignUpCubit.get(context).selectedItems ?? []);

    if (isSelected) {
      add2(itemValue);
      // updatedSelection.add(itemValue);
    } else {
      remove2(itemValue);
      //  updatedSelection.remove(itemValue);
    }

    //  onSelectionChanged(updatedSelection);
  }

  String? selectedBranch;
  void updateSelectedBranch(String branch) {
    selectedBranch = branch;
    emit(UpdateSelectedBranchState());
  }

  var endTime;
  void updateEndTime(Timestamp timestamp) {
    endTime = timestamp;
    emit(UpdateEndTimeState());
  }

  //start time
  var startTime;
  void updateStartTime(Timestamp timestamp) {
    startTime = timestamp;
    emit(UpdateStartTimeState());
  }
//                FirebaseFirestore.instance
// //                             .collection('branches')
// //                             .doc(branchId)
// //                             .collection('groups')
// //                             .doc(groupId)
// //                             .get()
// //                             .then((docSnapshot) {
// //                           if (docSnapshot.exists) {
// //                             Map<String, dynamic> groupData = docSnapshot.data();
// //                             Navigator.pushNamed(
// //                               context,
// //                               AppRoutes.onboarding,
// //                               arguments: {
// //                                 'isAdd': false,
// //                                 'branchId': '',
// //                                 'maxUsers': '0',
// //                                 // Pass the retrieved group data
// //                                 'groupData': groupData,
// //                               },
// //                             );
// //                           }
// //                         });
// //                       }
  void navigateToGroupData(String groupId ,String branchId, BuildContext context) {
    emit(NavigateToGroupDataState());
    //debug parameters
    print('groupId: $groupId');
    print('branchId: $branchId');
    FirebaseFirestore.instance
        .collection('branches')
        .doc(branchId)
        .collection('groups')
    //todo change this to group id
        .doc(groupId)
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        //that is group model
      GroupModel group = GroupModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
      //  Map<String, dynamic> groupData = docSnapshot.data() as Map<String, dynamic>;
        context.read<AddGroupCubit>().updateSelectedUsersAndCoachesAndTimesAndBranchAndMaxUsers(
            selectedUsers: group.users,
            selectedOption: 'تعديل',
            //selectedTimes: group.days,
            context: context,
            maxUsers: group.maxUsers,
            selectedBranch: branchId, 
            selectedCoaches: group.coaches,
            selectedDays: group.days,
        );
//debug parameters schedule id
        print('scheduleId: ${group.schedulesIds}');
        print('scheduleDay in ddelete : ${group.schedulesDays}');
        //days
        print('days: ${group.days}');
        Navigator.pushNamed(
          context,
          AppRoutes.onboarding,
          arguments: {
            'isAdd': false,
            'branchId': branchId,
            'maxUsers': group.maxUsers,
    'days': group.days,
                'usersList':
                    group.usersList,
              'coachList':
                    group.coachList,
                'coachIds':
                    group.coachIds,
                'userIds':
                    group.userIds,
                 'scheduleId':
                    group.schedulesIds,
                 'scheduleDays':
                    group.schedulesDays,
                 'groupId':
                    group.groupId,
                 'users':
                    group.users,
            'coaches':
                    group.coaches,
          },
        );
      }
    });
  }
}
