//
//use flutter_screenutil to make above ManageSchedulesScreen responsive
//instead of height: 160 ,use height: 160.h,
//instead of width: 155, use width: 155.w,
//instead of SizedBox(height: 20), use SizedBox(height: 20.h),
//instead of SizedBox(width: 20), use SizedBox(width: 20.w),
//instead of fontSize: 16, use fontSize: 16.sp,
//instead of fontSize: 18, use fontSize: 18.sp, and so on for all sizes in the app
import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:admin_future/home/business_logic/Home/manage_attendence_cubit%20.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../add_grouup_of_schedules/presentation/onboarding_screen.dart';
import '../../../core/constants/routes_manager.dart';
import '../../../core/flutter_flow/flutter_flow_theme.dart';
import '../../../core/flutter_flow/flutter_flow_widgets.dart';
import '../../../manage_users_coaches/business_logic/manage_users_cubit.dart';
import '../../data/schedules.dart';

class ManageSchedulesScreen extends StatelessWidget {
  const ManageSchedulesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ManageSalaryCubit.get(context).isCoach = false;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/back.png',
              width: 50.w,
              height: 50.h,
              fit: BoxFit.none,
            ),
          ),
        ),
        actions: [
          BlocBuilder<ManageUsersCubit, ManageUsersState>(
            builder: (context, state) {
              return //if state is     emit(GetSchedulesLoadingState());
//      show loading indicator
                SizedBox(
                  //height: 50.h,
                  width: 200.w,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      InkWell(
                        onTap: () {
                          ManageUsersCubit.get(context).changeIsCoach(true);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: ManageUsersCubit.get(context).isCoach
                                    ? Colors.blue
                                    : Colors.grey,
                                width: ManageUsersCubit.get(context).isCoach
                                    ? 2.0
                                    : 0.0,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 39.0.h,
                              right: 12.w,
                            ),
                            child: Text(
                              'المدربين',
                              style: TextStyle(
                                color: ManageUsersCubit.get(context).isCoach
                                    ? Colors.blue
                                    : Colors.grey,
                                fontSize: 18.sp,
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.w400,
                                height: 0.07.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          ManageUsersCubit.get(context).changeIsCoach(false);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: ManageUsersCubit.get(context).isCoach
                                    ? Colors.grey
                                    : Colors.blue,
                                width: ManageUsersCubit.get(context).isCoach
                                    ? 0.0
                                    : 2.0,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 39.0.h,
                              // right: 12.w,
                            ),
                            child: Text(
                              'المتدربين',
                              style: TextStyle(
                                color: ManageUsersCubit.get(context).isCoach
                                    ? Colors.grey
                                    : Colors.blue,
                                fontSize: 18.sp,
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.w400,
                                height: 0.07.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
            },
          ),
        ],
      ),
      // key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [],
                ),

//52
                SizedBox(height: 5.h),
                Text(
                  'ادارة المواعيد',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF333333),
                    fontSize: 32.sp,
                    fontFamily: 'Montserrat-Arabic',
                    fontWeight: FontWeight.w400,
                    height: 0.03.h,
                  ),
                ),
//65
                SizedBox(height: 0.h),
                ////TODO: add this to cubit
                Builder(builder: (context) {
                  ManageUsersCubit.get(context).getDays();
                  return const ScheduleDaysList();
                }),
                SizedBox(
                  height: 400.h,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Divider(
                          thickness: 2,
                          color: Color(0xFFF4F4F4),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            BlocBuilder<ManageUsersCubit, ManageUsersState>(
                              builder: (context, state) {
                                return ManageUsersCubit.get(context)
                                    .days
                                    .isEmpty
                                    ? const Center(
                                    child: CircularProgressIndicator())
                                    : FirestoreListView(
                                  query: FirebaseFirestore.instance
                                      .collection('admins')
                                  //todo change this to admin id
                                      .doc(FirebaseAuth
                                      .instance.currentUser!.uid)
                                      .collection('schedules')
                                      .doc(ManageUsersCubit.get(context)
                                      .days?[
                                  //selectedDayIndex
                                  ManageUsersCubit.get(
                                      context)
                                      .selectedDayIndex]
                                      .name ??
                                      '')
                                      .collection('schedules')
                                  //order start time which is timestamp based on hour only not day
                                      .orderBy('start_time_hour', descending: false)
                                  // .get(const GetOptions(source: Source.serverAndCache)),
                                  ,
                                  pageSize: 8,
                                  cacheExtent: 100,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, doc) {
                                    final data = doc.data();
                                    final schedule =
                                    ScheduleModel.fromJson2(data);
                                    // List<String?>? coachesIds =
                                    //     schedule.coachIds ?? [];
                                    // List<String?>? usersIds =
                                    //     schedule.userIds ?? [];
                                    // //group_id
                                    //
                                    // String scheduleId =
                                    //     schedule.scheduleId ?? '';
                                    // String day = schedule.date ?? '';

                                    return Column(
                                      children: [
                                        GestureDetector(
                                          // updated
                                          // onLongPress: () {
                                          //   // setState(() {
                                          //   //   isGrey = true;
                                          //   // });
                                          //   //use cubit
                                          //   ManageSalaryCubit.get(context).changeIsGrey(true);
                                          // },
                                          // onTap: () {
                                          //   // setState(() {
                                          //   //   isGrey = false;
                                          //   // });
                                          //   //use cubit
                                          //   ManageSalaryCubit.get(context).changeIsGrey(false);
                                          //
                                          // },
                                          child: ExpansionTile(
                                            leading: Row(
                                              mainAxisSize:
                                              MainAxisSize.min,
                                              children: [
                                                // FFButtonWidget(
                                                //   onPressed: () {
                                                //     ManageUsersCubit
                                                //         .get(
                                                //         context)
                                                //        .deleteSchedule(
                                                //       coachesIds:
                                                //       coachesIds?.cast<
                                                //           String>() ??
                                                //           [],
                                                //       usersIds: usersIds
                                                //           ?.cast<
                                                //           String>() ??
                                                //           [],
                                                //       scheduleId:
                                                //       scheduleId,
                                                //       day: day,
                                                //     );
                                                //   },
                                                //   text: 'حذف',
                                                //   options:
                                                //   FFButtonOptions(
                                                //     width: 50.w,
                                                //     height: 40.h,
                                                //     padding:
                                                //     const EdgeInsetsDirectional
                                                //         .fromSTEB(
                                                //         5, 0, 5, 0),
                                                //     iconPadding:
                                                //     const EdgeInsetsDirectional
                                                //         .fromSTEB(
                                                //         0, 0, 0, 0),
                                                //     color: Colors.red,
                                                //     textStyle:
                                                //     FlutterFlowTheme
                                                //         .of(
                                                //         context)
                                                //         .titleSmall
                                                //         .override(
                                                //       fontFamily:
                                                //       'Readex Pro',
                                                //       color: Colors
                                                //           .white,
                                                //       fontSize:
                                                //       12.sp,
                                                //     ),
                                                //     elevation: 3,
                                                //     borderSide:
                                                //     const BorderSide(
                                                //       color: Colors
                                                //           .transparent,
                                                //       width: 1,
                                                //     ),
                                                //     borderRadius:
                                                //     BorderRadius
                                                //         .circular(
                                                //         8),
                                                //   ),
                                                // ),
                                                // SizedBox(width: 10.w),
                                                FFButtonWidget(
                                                  onPressed: () {
                                                    ManageAttendenceCubit
                                                        .get(
                                                        context)
                                                        .getAdminData();
                                                    ManageAttendenceCubit
                                                        .get(
                                                        context)
                                                        .navigateToGroupData(
                                                        schedule.group_id ??
                                                            '',
                                                        schedule.branchId ??
                                                            '',
                                                        context);
                                                    // Navigator.pushNamed(
                                                    // context,
                                                    //AppRoutes.onboarding,
                                                    //
                                                    //         AppRoutes.addSchedule,
                                                    // arguments: {
                                                    //   'toggle': false,
                                                    //   'startTime': statrTime,
                                                    //   'endTime': endTime,
                                                    //   'date': day,
                                                    //   'usersList': usersList,
                                                    //   'scheduleId': scheduleId,
                                                    //   'usersIds': usersIds,
                                                    // },
                                                    // );
                                                  },
                                                  text: 'تعديل',
                                                  options:
                                                  FFButtonOptions(
                                                    width: 50.w,
                                                    height: 40.h,
                                                    padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        5, 0, 5, 0),
                                                    iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 0, 0, 0),
                                                    color: Colors.blue,
                                                    textStyle:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .titleSmall
                                                        .override(
                                                      fontFamily:
                                                      'Readex Pro',
                                                      color: Colors
                                                          .white,
                                                      fontSize:
                                                      12.sp,
                                                    ),
                                                    elevation: 3,
                                                    borderSide:
                                                    const BorderSide(
                                                      color: Colors
                                                          .transparent,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            title: BlocBuilder<
                                                ManageUsersCubit,
                                                ManageUsersState>(
                                              builder:
                                                  (context, state) {
                                                return Row(
                                                  children: [
                                                    Expanded(
                                                      child: SizedBox(
                                                        width: 200,
                                                        child:
                                                        AutoSizeText(
                                                          '${DateFormat('hh:mm a').format(schedule.endTime!.toDate())} '
                                                              '<---'
                                                              '${DateFormat('hh:mm a').format(schedule.startTime!.toDate())} '
                                                              '-'
                                                              '${schedule.branchId}',
                                                          style: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Readex Pro',
                                                            // fontSize: ,
                                                          ),
                                                          minFontSize:
                                                          6,
                                                          maxFontSize:
                                                          19,
                                                          maxLines: 1,
                                                          overflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      const SizedBox(
                                                          width: 5)),
                                                );
                                              },
                                            ),
                                            children: [
                                              if (ManageUsersCubit.get(
                                                  context)
                                                  .isCoach ==
                                                  true)
                                                SizedBox(
                                                    height: 175,
                                                    child:
                                                    FirestoreListView<
                                                        Map<String,
                                                            dynamic>>(
                                                      pageSize: 6,
                                                      shrinkWrap: true,
                                                      loadingBuilder:
                                                          (context) =>
                                                      const Center(
                                                          child:
                                                          CircularProgressIndicator()),
                                                      cacheExtent: 100,
                                                      query: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                          'admins')
                                                          .doc(FirebaseAuth
                                                          .instance
                                                          .currentUser
                                                          ?.uid)
                                                          .collection(
                                                          'schedules')
                                                          .doc(ManageUsersCubit.get(
                                                          context)
                                                          .days?[
                                                      //selectedDayIndex
                                                      ManageUsersCubit.get(context)
                                                          .selectedDayIndex]
                                                          .name ??
                                                          '')
                                                          .collection(
                                                          'schedules')
                                                          .doc(
                                                          '${schedule.scheduleId}')
                                                          .collection(
                                                          'users')
                                                          .where('role',
                                                          isEqualTo:
                                                          'coach'),
                                                      itemBuilder:
                                                          (context,
                                                          snapshot) {
                                                        DateTime
                                                        nearestDay =
                                                            schedule.nearestDay
                                                                ?.toDate() ??
                                                                DateTime
                                                                    .now();
                                                        // Calculate the difference between the nearest day and today's date
                                                        int differenceInDays =  DateTime
                                                            .now()
                                                            .difference(
                                                            nearestDay)
                                                            .inDays;
                                                        // Duration difference = DateTime.now().difference(nearestDay);
                                                        bool?
                                                        isTimeExceed;
                                                        Map<String,
                                                            dynamic>
                                                        user =
                                                        snapshot
                                                            .data();
                                                        if (differenceInDays >
                                                            5) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                              'admins')
                                                              .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser
                                                              ?.uid)
                                                              .collection(
                                                              'schedules')
                                                              .doc(ManageUsersCubit.get(context).days?[ManageUsersCubit.get(context).selectedDayIndex].name ??
                                                              '')
                                                              .collection(
                                                              'schedules').doc(
                                                              '${schedule.scheduleId}')
                                                          //update nearest_day to today
                                                              .update({
                                                            'nearest_day':
                                                            Timestamp.now(),
                                                          });
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                              'admins')
                                                              .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser
                                                              ?.uid)
                                                              .collection(
                                                              'schedules')
                                                              .doc(ManageUsersCubit.get(context).days?[ManageUsersCubit.get(context).selectedDayIndex].name ??
                                                              '')
                                                              .collection(
                                                              'schedules')
                                                              .doc(
                                                              '${schedule.scheduleId}')
                                                              .collection(
                                                              'users')
                                                              .where(
                                                              'finished',
                                                              isEqualTo:
                                                              true)
                                                              .where(
                                                              'role',
                                                              isEqualTo:
                                                              'coach')
                                                              .get()
                                                              .then(
                                                                  (querySnapshot) {
                                                                querySnapshot
                                                                    .docs
                                                                    .forEach(
                                                                        (doc) {
                                                                      doc.reference
                                                                          .update({
                                                                        'finished':
                                                                        false
                                                                      });
                                                                    });
                                                              });
                                                          isTimeExceed =
                                                          false;
                                                        }
                                                        // else if(differenceInDays < 5 && differenceInDays != 0){
                                                        //   //message cant add attendance because this date not reached yet
                                                        //   //show toast
                                                        //    showToast(
                                                        //      state: ToastStates.ERROR,
                                                        //        msg: 'لا يمكنك اضافة حضور لان هذا الموعد لم يصل بعد',
                                                        //     );
                                                        // }

                                                        user = snapshot
                                                            .data();
                                                        return //Text('Schedule id is ${user['name']}');
                                                          Column(
                                                            children: [
                                                              //  for (int i = 0; i < user.length; i++)
                                                              CheckboxListTile(
                                                                activeColor:
                                                                Colors
                                                                    .blue,
                                                                title: Text(
                                                                    user[
                                                                    'name']),
                                                                value: isTimeExceed ??
                                                                    user[
                                                                    'finished'],
                                                                onChanged:
                                                                    (value) async {
                                                                  FirebaseFirestore
                                                                  firestore =
                                                                      FirebaseFirestore.instance;
                                                                  // DocumentSnapshot scheduleSnapshot = await firestore
                                                                  //     .collection('admins')
                                                                  //     .doc(FirebaseAuth.instance.currentUser?.uid)
                                                                  //     .collection('schedules')
                                                                  //     .doc(ManageSalaryCubit.get(context).days?[index].name ?? '')
                                                                  //     .collection('schedules')
                                                                  //     .doc('${ManageSalaryCubit.get(context).schedules?[index].scheduleId}')
                                                                  //     .get();
                                                                  int startTime =
                                                                      schedule.startTime?.toDate().hour ??
                                                                          0;
                                                                  int endTime =
                                                                      schedule.endTime?.toDate().hour ??
                                                                          0;
                                                                  int totalHours =
                                                                      endTime -
                                                                          startTime;
                                                                  totalHours +=
                                                                      const Duration(minutes: 2).inHours;

                                                                  if (value ==
                                                                      true) {
                                                                    //use batches
                                                                    WriteBatch batch =
                                                                    firestore.batch();
                                                                    // firestore
                                                                    //     .collection('admins')
                                                                    //     .doc(FirebaseAuth.instance.currentUser?.uid)
                                                                    //     .collection('schedules')
                                                                    //     .doc(ManageUsersCubit.get(context)
                                                                    //     .days?[
                                                                    // //selectedDayIndex
                                                                    // ManageUsersCubit.get(context).selectedDayIndex]
                                                                    //     .name ??
                                                                    //     '')
                                                                    //     .collection('schedules')
                                                                    //     .doc('${schedule.scheduleId}')
                                                                    //     .collection('users')
                                                                    //     .doc(user['uid'])
                                                                    //     .update({
                                                                    //   'finished':
                                                                    //   value,
                                                                    // });
                                                                    batch.update(
                                                                        firestore
                                                                            .collection('admins')
                                                                            .doc(FirebaseAuth.instance.currentUser?.uid)
                                                                            .collection('schedules')
                                                                            .doc(ManageUsersCubit.get(context)
                                                                            .days?[
                                                                        //selectedDayIndex
                                                                        ManageUsersCubit.get(context).selectedDayIndex]
                                                                            .name ??
                                                                            '')
                                                                            .collection('schedules')
                                                                            .doc('${schedule.scheduleId}')
                                                                            .collection('users')
                                                                            .doc(user['uid']),
                                                                        {'finished': value});

                                                                    // firestore
                                                                    //     .collection(
                                                                    //     'users')
                                                                    //     .doc(user[
                                                                    // 'uid'])
                                                                    //     .update({
                                                                    //   'totalHours':
                                                                    //   FieldValue.increment(totalHours),
                                                                    //   'totalSalary':FieldValue.increment(totalHours*user['hourlyRate'])
                                                                    // });
                                                                    batch.update(
                                                                        firestore
                                                                            .collection(
                                                                            'users')
                                                                            .doc(user[
                                                                        'uid']),
                                                                        {
                                                                          'totalHours':
                                                                          FieldValue.increment(totalHours),
                                                                          'totalSalary':FieldValue.increment(totalHours*user['hourlyRate'])
                                                                        });
                                                                    //handle notification
                                                                    // class NotificationModel {
                                                                    //    String? message;
                                                                    //   DateTime? timestamp;
                                                                    //
                                                                    //   NotificationModel({required this.message, required this.timestamp});
                                                                    // //fromJson
                                                                    //   factory NotificationModel.fromJson(Map<String, dynamic> json) {
                                                                    //     return NotificationModel(
                                                                    //       message: json['message'],
                                                                    //       timestamp: DateTime.parse(json['timestamp']),
                                                                    //     );
                                                                    //   }
                                                                    batch.set(
                                                                        firestore
                                                                            .collection('users').
                                                                            doc(user['uid']).collection('notifications').doc(),
                                                                            {
                                                                       'message': 'تم اضافة ${totalHours} ساعات لحسابك',
                                                                    'timestamp': Timestamp.now(),
                                                                    },
                                                                    );



                                                                    batch.commit();
//                                                                       FirebaseFirestore.instance
//                                                                           .collection('admins')
//                                                                           .doc( FirebaseAuth.instance.currentUser?.uid)
//                                                                           .collection('dates').doc('${DateTime.now().month.toString()}-${DateTime.now().year.toString()}').get().then((value) {
//                                                                         if (value.exists) {
// //add number of sessions to it
//                                                                           FirebaseFirestore.instance
//                                                                               .collection('admins')
//                                                                               .doc( FirebaseAuth.instance.currentUser?.uid)
//                                                                               .collection('dates')
//                                                                               .doc('${DateTime.now().month.toString()}-${DateTime.now().year.toString()}')
//                                                                               .update({
//                                                                             //totalSalary
//                                                                             'totalSalary': FieldValue.increment(totalHours*user['hourlyRate']),
//                                                                             'totalHours': FieldValue.increment(totalHours),
//                                                                           });
//                                                                         } else {
//                                                                           //create new document and add number of sessions to it
//                                                                           FirebaseFirestore.instance
//                                                                               .collection('admins')
//                                                                               .doc( FirebaseAuth.instance.currentUser?.uid)
//                                                                               .collection('dates')
//                                                                               .doc('${DateTime.now().month.toString()}-${DateTime.now().year.toString()}')
//                                                                               .set({
//                                                                             //totalSalary
//                                                                             'totalSalary': totalHours*user['hourlyRate'],
//                                                                             'totalHours': totalHours,
//                                                                           });
//                                                                         }
//                                                                       });

                                                                    //send notification to users model contain 2 fields message and timestamp
                                                                    // firestore
                                                                    //     .collection('users')
                                                                    //     .doc(user['uid'])
                                                                    //     .collection('notifications')
                                                                    //     .add({
                                                                    //   'message':
                                                                    //       'تم اضافة ${totalHours} ساعات لحسابك',
                                                                    //   'timestamp':
                                                                    //       Timestamp.now(),
                                                                    // });
                                                                  } else {
                                                                    //use batches
                                                                    WriteBatch batch = firestore.batch();
                                                                    // firestore
                                                                    //     .collection('admins')
                                                                    //     .doc(FirebaseAuth.instance.currentUser?.uid)
                                                                    //     .collection('schedules')
                                                                    //     .doc(ManageUsersCubit.get(context)
                                                                    //     .days?[
                                                                    // //selectedDayIndex
                                                                    // ManageUsersCubit.get(context).selectedDayIndex]
                                                                    //     .name ??
                                                                    //     '')
                                                                    //     .collection('schedules')
                                                                    //     .doc('${schedule.scheduleId}')
                                                                    //     .collection('users')
                                                                    //     .doc(user['uid'])
                                                                    //     .update({
                                                                    //   'finished':
                                                                    //   value,
                                                                    // });
                                                                    batch.update(
                                                                        firestore
                                                                            .collection('admins')
                                                                            .doc(FirebaseAuth.instance.currentUser?.uid)
                                                                            .collection('schedules')
                                                                            .doc(ManageUsersCubit.get(context)
                                                                            .days?[
                                                                        //selectedDayIndex
                                                                        ManageUsersCubit.get(context).selectedDayIndex]
                                                                            .name ??
                                                                            '')
                                                                            .collection('schedules')
                                                                            .doc('${schedule.scheduleId}')
                                                                            .collection('users')
                                                                            .doc(user['uid']),
                                                                        {'finished': value});
                                                                    // firestore
                                                                    //     .collection(
                                                                    //     'users')
                                                                    //     .doc(user[
                                                                    // 'uid'])
                                                                    //     .update({
                                                                    //   'totalHours':
                                                                    //   FieldValue.increment(-totalHours)
                                                                    //   ,'totalSalary':FieldValue.increment(-totalHours*user['hourlyRate'])
                                                                    // });
                                                                    batch.update(
                                                                        firestore
                                                                            .collection(
                                                                            'users')
                                                                            .doc(user[
                                                                        'uid']),
                                                                        {
                                                                          'totalHours':
                                                                          FieldValue.increment(-totalHours),
                                                                          'totalSalary':FieldValue.increment(-totalHours*user['hourlyRate'])
                                                                        });
//                                                                       FirebaseFirestore.instance
//                                                                           .collection('admins')
//                                                                           .doc( FirebaseAuth.instance.currentUser?.uid)
//                                                                           .collection('dates').doc('${DateTime.now().month.toString()}-${DateTime.now().year.toString()}').get().then((value) {
//                                                                         if (value.exists) {
// //add number of sessions to it
//                                                                           FirebaseFirestore.instance
//                                                                               .collection('admins')
//                                                                               .doc( FirebaseAuth.instance.currentUser?.uid)
//                                                                               .collection('dates')
//                                                                               .doc('${DateTime.now().month.toString()}-${DateTime.now().year.toString()}')
//                                                                               .update({
//                                                                             //totalSalary
//                                                                             'totalSalary': FieldValue.increment(-totalHours*user['hourlyRate']),
//                                                                             'totalHours': FieldValue.increment(-totalHours),
//                                                                           });
//                                                                         } else {
//                                                                           //create new document and add number of sessions to it
//                                                                           FirebaseFirestore.instance
//                                                                               .collection('admins')
//                                                                               .doc( FirebaseAuth.instance.currentUser?.uid)
//                                                                               .collection('dates')
//                                                                               .doc('${DateTime.now().month.toString()}-${DateTime.now().year.toString()}')
//                                                                               .set({
//                                                                             //totalSalary
//                                                                             'totalSalary': 0,
//                                                                             'totalHours': 0,
//                                                                           });
//                                                                         }
//                                                                       });
                                                                    batch.set(
                                                                      firestore
                                                                          .collection('users').
                                                                      doc(user['uid']).collection('notifications').doc(),
                                                                      {
                                                                        'message': 'تم خصم ${totalHours} ساعات من حسابك',
                                                                        'timestamp': Timestamp.now(),
                                                                      },
                                                                    );
                                                                    batch.commit();

                                                                    //send notification to users model contain 2 fields message and timestamp
                                                                    // firestore
                                                                    //     .collection('users')
                                                                    //     .doc(user['uid'])
                                                                    //     .collection('notifications')
                                                                    //     .add({
                                                                    //   'message':
                                                                    //       'تم خصم ${totalHours} ساعات من حسابك',
                                                                    //   'timestamp':
                                                                    //       Timestamp.now(),
                                                                    // });
                                                                  }
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                      },
                                                    ))
                                              else
                                                SizedBox(
                                                    height: 175,
                                                    child: FirestoreListView<
                                                        Map<String,
                                                            dynamic>>(
                                                      pageSize: 8,
                                                      shrinkWrap: true,
                                                      loadingBuilder:
                                                          (context) =>
                                                      const Center(
                                                          child:
                                                          CircularProgressIndicator()),
                                                      cacheExtent: 100,
                                                      query: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                          'admins')
                                                          .doc(FirebaseAuth
                                                          .instance
                                                          .currentUser
                                                          ?.uid)
                                                          .collection(
                                                          'schedules')
                                                          .doc(
                                                          ManageUsersCubit
                                                              .get(
                                                              context)
                                                              .days?[
                                                          //selectedDayIndex
                                                          ManageUsersCubit
                                                              .get(context)
                                                              .selectedDayIndex]
                                                              .name ??
                                                              '')
                                                          .collection(
                                                          'schedules')
                                                          .doc(
                                                          '${schedule
                                                              .scheduleId}')
                                                          .collection(
                                                          'users')
                                                          .where('role',
                                                          isEqualTo:
                                                          'user'),
                                                      itemBuilder: (context,
                                                          snapshot) {
                                                        //nearestDay 2023-10-11 15:35:13.858087
                                                        //differenceInDays 0
                                                        //DateTime.now()  DateTime.now() 2023-10-11 15:36:59.950
                                                        DateTime
                                                        nearestDay =
                                                            schedule
                                                                .nearestDayUser
                                                                ?.toDate() ??
                                                                DateTime
                                                                    .now();
                                                        // Calculate the difference between the nearest day and today's date
                                                        int differenceInDays =
                                                            DateTime
                                                                .now()
                                                                .difference(nearestDay
                                                            )
                                                                .inDays;
                                                        bool? isTimeExceed;
                                                        // Duration difference = DateTime.now().difference(nearestDay);
                                                        Map<String, dynamic>
                                                        user =
                                                        snapshot.data();

                                                        if (differenceInDays >
                                                            5) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                              'admins')
                                                              .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser
                                                              ?.uid)
                                                              .collection(
                                                              'schedules')
                                                              .doc(ManageUsersCubit.get(context).days?[ManageUsersCubit.get(context).selectedDayIndex].name ??
                                                              '')
                                                              .collection(
                                                              'schedules').doc(
                                                              '${schedule.scheduleId}')
                                                          //update nearest_day to today
                                                              .update({
                                                            'nearest_day_user':
                                                            Timestamp.now(),
                                                          });
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                              'admins')
                                                              .doc(
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser
                                                                  ?.uid)
                                                              .collection(
                                                              'schedules')
                                                              .doc(
                                                              ManageUsersCubit
                                                                  .get(
                                                                  context)
                                                                  .days?[ManageUsersCubit
                                                                  .get(
                                                                  context)
                                                                  .selectedDayIndex]
                                                                  .name ??
                                                                  '')
                                                              .collection(
                                                              'schedules')
                                                              .doc(
                                                              '${schedule
                                                                  .scheduleId}')
                                                              .collection(
                                                              'users')
                                                              .where(
                                                              'finished',
                                                              isEqualTo:
                                                              true)
                                                              .where('role',
                                                              isEqualTo:
                                                              'user')
                                                              .get()
                                                              .then(
                                                                  (
                                                                  querySnapshot) {
                                                                querySnapshot
                                                                    .docs
                                                                    .forEach(
                                                                        (
                                                                        doc) {
                                                                      doc
                                                                          .reference
                                                                          .update(
                                                                          {
                                                                            'finished':
                                                                            false
                                                                          });
                                                                    });
                                                              });
                                                          isTimeExceed =
                                                          false;
                                                        }
                                                        return //Text('Schedule id is ${user['name']}');
                                                          Column(
                                                            children: [
                                                              CheckboxListTile(
                                                                activeColor: Colors.blue,
                                                                title: Text(
                                                                    user[
                                                                    'name']),
                                                                value: isTimeExceed ??
                                                                    user[
                                                                    'finished'],
                                                                onChanged:
                                                                    (
                                                                    value) async {
                                                                  FirebaseFirestore
                                                                  firestore =
                                                                      FirebaseFirestore
                                                                          .instance;
                                                                  // DocumentSnapshot scheduleSnapshot = await firestore
                                                                  //     .collection('admins')
                                                                  //     .doc(FirebaseAuth.instance.currentUser?.uid)
                                                                  //     .collection('schedules')
                                                                  //     .doc(ManageSalaryCubit.get(context).days?[index].name ?? '')
                                                                  //     .collection('schedules')
                                                                  //     .doc('${ManageSalaryCubit.get(context).schedules?[index].scheduleId}')
                                                                  //     .get();
                                                                  int startTime = schedule
                                                                      .startTime
                                                                      ?.toDate()
                                                                      .hour ??
                                                                      0;
                                                                  int endTime = schedule
                                                                      .endTime
                                                                      ?.toDate()
                                                                      .hour ??
                                                                      0;
                                                                  int totalHours =
                                                                      endTime -
                                                                          startTime;
                                                                  totalHours +=
                                                                      const Duration(
                                                                          minutes: 2)
                                                                          .inHours;

                                                                  if (value ==
                                                                      true) {
                                                                    firestore
                                                                        .collection(
                                                                        'admins')
                                                                        .doc(
                                                                        FirebaseAuth
                                                                            .instance
                                                                            .currentUser
                                                                            ?.uid)
                                                                        .collection(
                                                                        'schedules')
                                                                        .doc(
                                                                        ManageUsersCubit
                                                                            .get(
                                                                            context)
                                                                            .days?[
                                                                        //selectedDayIndex
                                                                        ManageUsersCubit
                                                                            .get(
                                                                            context)
                                                                            .selectedDayIndex]
                                                                            .name ??
                                                                            '')
                                                                        .collection(
                                                                        'schedules')
                                                                        .doc(
                                                                        '${schedule
                                                                            .scheduleId}')
                                                                        .collection(
                                                                        'users')
                                                                        .doc(
                                                                        user['uid'])
                                                                        .update(
                                                                        {
                                                                          'finished':
                                                                          value,
                                                                        });

                                                                    //get user number of sessions from user collection first check if it is less than 2 then subtract 1 from it and
                                                                    //send whatup message from user['phone'] to admin['phone'] with message 'تم اضافة ${totalHours} ساعات لحسابك'
                                                                    firestore
                                                                        .collection(
                                                                        'users')
                                                                        .doc(
                                                                        user[
                                                                        'uid'])
                                                                        .get()
                                                                        .then(
                                                                            (
                                                                            value) {
                                                                          int numberOfSessions =
                                                                              value
                                                                                  .data()?['numberOfSessions'] ??
                                                                                  0;
                                                                          String
                                                                          phone =
                                                                              value
                                                                                  .data()?['phone'] ??
                                                                                  '';
                                                                          if (numberOfSessions <
                                                                              2) {
                                                                            //send whatup message from user['phone'] to admin['phone'] with message 'we are rememberring you that you have only 1 sessions left'
                                                                            //   String url = 'https://api.whatsapp.com/send?phone=${phone}&text=we are rememberring you that you have only 1 sessions left
                                                                            //translate text to arabic
                                                                            String
                                                                            url =
                                                                                'https://api.whatsapp.com/send?phone=+20${phone}&text=نذكركم بتجديد الاشتراك ';
                                                                            launch(
                                                                                url);
                                                                          }
                                                                          //subtract 1 from numberOfSessions
//intialize batch
                                                                          WriteBatch batch =
                                                                          firestore.batch();
                                                                          batch.update(firestore.collection('users').doc(user['uid']), {
                                                                            'numberOfSessions': FieldValue.increment(-1)
                                                                          });
                                                                          batch.set(firestore.collection('admins').doc( FirebaseAuth.instance.currentUser?.uid).collection('dates').doc('${DateTime.now().month.toString()}-${DateTime.now().year.toString()}'),
                                                                              {
                                                                                'setFlag': true
                                                                              },
                                                                            SetOptions(merge: true));
                                                                          batch.update(firestore.collection('admins').doc( FirebaseAuth.instance.currentUser?.uid).collection('dates').doc('${DateTime.now().month.toString()}-${DateTime.now().year.toString()}'), {
                                                                            'numberOfAttendence':
                                                                            //add 1 to as int
                                                                          FieldValue.increment(1)
                                                                          },
                                                                          );

                                                                          //commit batch
                                                                          batch.commit();


                                                                        });
                                                                    //todo add this to cubit
                                                                    //send notification to users model contain 2 fields message and timestamp
                                                                    // firestore.collection('users').doc(user['uid']).collection('notifications').add({
                                                                    //   'message': 'تم اضافة ${totalHours} ساعات لحسابك',
                                                                    //   'timestamp': Timestamp.now(),
                                                                    // });
                                                                  } else {
                                                                    WriteBatch batch =
                                                                    firestore.batch();
                                                                    // firestore
                                                                    //     .collection(
                                                                    //     'admins')
                                                                    //     .doc(
                                                                    //     FirebaseAuth
                                                                    //         .instance
                                                                    //         .currentUser
                                                                    //         ?.uid)
                                                                    //     .collection(
                                                                    //     'schedules')
                                                                    //     .doc(
                                                                    //     ManageUsersCubit
                                                                    //         .get(
                                                                    //         context)
                                                                    //         .days?[
                                                                    //     //selectedDayIndex
                                                                    //     ManageUsersCubit
                                                                    //         .get(
                                                                    //         context)
                                                                    //         .selectedDayIndex]
                                                                    //         .name ??
                                                                    //         '')
                                                                    //     .collection(
                                                                    //     'schedules')
                                                                    //     .doc(
                                                                    //     '${schedule
                                                                    //         .scheduleId}')
                                                                    //     .collection(
                                                                    //     'users')
                                                                    //     .doc(
                                                                    //     user['uid'])
                                                                    //     .update(
                                                                    //     {
                                                                    //       'finished':
                                                                    //       value,
                                                                    //     });
                                                                    batch.update(
                                                                        firestore
                                                                            .collection(
                                                                            'admins')
                                                                            .doc(
                                                                            FirebaseAuth
                                                                                .instance
                                                                                .currentUser
                                                                                ?.uid)
                                                                            .collection(
                                                                            'schedules')
                                                                            .doc(
                                                                            ManageUsersCubit
                                                                                .get(
                                                                                context)
                                                                                .days?[
                                                                            //selectedDayIndex
                                                                            ManageUsersCubit
                                                                                .get(
                                                                                context)
                                                                                .selectedDayIndex]
                                                                                .name ??
                                                                                '')
                                                                            .collection(
                                                                            'schedules')
                                                                            .doc(
                                                                            '${schedule
                                                                                .scheduleId}')
                                                                            .collection(
                                                                            'users')
                                                                            .doc(
                                                                            user['uid']),
                                                                        {
                                                                          'finished':
                                                                          value,
                                                                        });
                                                                    // firestore.collection('users').doc(user['uid']).update({'totalHours': FieldValue.increment(-totalHours)});
                                                                    //send notification to users model contain 2 fields message and timestamp
                                                                    // firestore.collection('users').doc(user['uid']).collection('notifications').add({
                                                                    //   'message': 'تم خصم ${totalHours} ساعات من حسابك',
                                                                    //   'timestamp': Timestamp.now(),
                                                                    // });

                                                                    //print \n\n
                                                                    //i want to make new collection for dates if not exist then add number of sessions to it
                                                                    //if exist then add number of sessions to it
                                                                    //   FirebaseFirestore.instance
                                                                    // .collection('branches')
                                                                    // .doc(//schedule.branch id
                                                                    //     '${schedule.branchId}')
                                                                    // .collection('dates')
                                                                    // .doc( DateTime.now().month.toString() +
                                                                    //       '-' +
                                                                    //       DateTime.now().year.toString())

                                                                    batch.update(firestore.collection('users').doc(user['uid']), {
                                                                      'numberOfSessions': FieldValue.increment(1)
                                                                    });
                                                                    batch.set(firestore.collection('admins').doc( FirebaseAuth.instance.currentUser?.uid).collection('dates').doc('${DateTime.now().month.toString()}-${DateTime.now().year.toString()}'),
                                                                        {
                                                                          'setFlag': true
                                                                        },
                                                                        SetOptions(merge: true));
                                                                    batch.update(firestore.collection('admins').doc( FirebaseAuth.instance.currentUser?.uid).collection('dates').doc('${DateTime.now().month.toString()}-${DateTime.now().year.toString()}'), {
                                                                      'numberOfAttendence': FieldValue.increment(-1)
                                                                    });


                                                                    //commit batch
                                                                    batch.commit();

                                                                  }

                                                                },
                                                              ),
                                                            ],
                                                          );
                                                      },
                                                    )
                                                )
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  //  itemCount: ManageSalaryCubit
                                  //      .get(context)
                                  //      .schedules
                                  //      ?.length ?? 0,
                                );
                              },
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 2,
                          color: Color(0xFFF4F4F4),
                        ),
                      ],
                    ),
                  ),
                ),

                FFButtonWidget(
                  onPressed: () {
                    //  ManageAttendenceCubit.get(context).selectedCoaches = [];
                    //  ManageAttendenceCubit.get(context).selectedDays = [];
                    //  ManageAttendenceCubit.get(context).startTime = Timestamp.now();
                    //  ManageAttendenceCubit.get(context).endTime = Timestamp.now();
                    final addGroupCubit = context.read<AddGroupCubit>();
                    addGroupCubit.initState(context);
                    ManageAttendenceCubit.get(context).getAdminData();
                    //  context.watch<AddGroupCubit>().changeMaxUsers('0');
                    // context.read<AddGroupCubit>().state.copyWith(maxUsers: '0');
                    // context.read<AddGroupCubit>().maxUsers = '0';

                    Navigator.pushNamed(
                      context,
                      AppRoutes.onboarding,
                      arguments: {
                        'isAdd': true,
                        'branchId': '',
                        'maxUsers': '0',
                        //   'days':
                        //   [],
                        //    'usersList':
                        //   [],
                        //    'coachList':
                        //    [],
                        //     'coachIds':
                        //     [],
                        //     'userIds':
                        //     [],
                        //      'scheduleId':
                        //       '',
                        //       'schedule_days':
                        //      [],
                        //      'groupId':
                        //      '',
                        //      'users':
                        //     [],

                        // 'coaches': group.coaches,
                      },
                    );
                  },
                  text: 'اضافة موعد ',
                  options: FFButtonOptions(
                    height: 40.h,
                    padding:
                    const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    iconPadding:
                    const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: const Color(0xFF198CE3),
                    textStyle:
                    FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Readex Pro',
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                    elevation: 3,
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                //SizedBox(height: 20.h),
              ].divide(const SizedBox(height: 30)),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleDaysList extends StatelessWidget {
  const ScheduleDaysList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 65.h,
      decoration: BoxDecoration(
        color: const Color.fromARGB(0, 195, 162, 162),
        border: Border.all(
          color: Colors.blue,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<ManageUsersCubit, ManageUsersState>(
              builder: (context, state) {
                return ManageUsersCubit.get(context).days.isEmpty
                    ? Container(
                  height: 0.h,
                )
                    : ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    width: 10.w,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      ManageUsersCubit.get(context).getSchedulesForDay(
                        ManageUsersCubit.get(context).days?[index].name ?? '',
                      );
                      ManageUsersCubit.get(context)
                          .changeSelectedDayIndex(index);
                    },
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Container(
                        width: 75.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: ManageUsersCubit.get(context)
                              .selectedDayIndex ==
                              index
                              ? Colors.blue
                              : const Color(0xFFF3F3F3),
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                        ),
                        alignment: const AlignmentDirectional(0, 0),
                        child: Text(
                          ManageUsersCubit.get(context).days?[index].name ??
                              '',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Readex Pro',
                            color: ManageUsersCubit.get(context)
                                .selectedDayIndex ==
                                index
                                ? const Color(0xFFF4F4F4)
                                : Colors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ManageUsersCubit.get(context).days?.length ?? 0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
