import 'package:admin_future/add_grouup_of_schedules/presentation/onboarding_screen.dart';
import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/routes_manager.dart';
import '../../../core/flutter_flow/flutter_flow_theme.dart';
import '../../../routiong.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return
      // Builder(builder: (context) {
      //todo: get schedules for admin
     // ManageAttendenceCubit.get(context).getSchedulesForAdmin().then(
     //     (value) => ManageAttendenceCubit.get(context).getNearestSchedule());
     //  return BlocConsumer<ManageAttendenceCubit, ManageAttendenceState>(
     //    listener: (context, state) {
     //      // TODO: implement listener
     //    },
     //    builder: (context, state) {
         // return
      WillPopScope(
        onWillPop: () async {
          bool shouldExit = await DefaultDialogToAskUserToExitAppOrNot.show(context) ?? false;
          // if (shouldExit) {
          //   SystemNavigator.pop();
          // }
          if (shouldExit) SystemNavigator.pop();
          return shouldExit;
        },
        //if shouldExit is true, then exit the app
        child:  Scaffold(
              //use flutter_screenutil to make above HomeLayout responsive
              //instead of height: 195 ,use height: 195.h,
              //instead of width: 155, use width: 155.w,
              //instead of SizedBox(height: 20), use SizedBox(height: 20.h),
              //instead of SizedBox(width: 20), use SizedBox(width: 20.w),
              //instead of fontSize: 16, use fontSize: 16.sp,
              //instead of fontSize: 18, use fontSize: 18.sp, and so on for all sizes in the app
              //key: scaffoldKey,
              backgroundColor: Colors.white,
              body: SafeArea(
                top: true,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //60 sized box
                          SizedBox(
                            height: 40.h,
                          ),

                          Align(
                            alignment: const AlignmentDirectional(0, -1),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 205.w,
                                  height: 205.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0x00FFFFFF),
                                    border: Border.all(
                                      color: const Color(0xFFB9B9B9),
                                      width: 1.10,
                                    ),
                                  ),
                                  child:
                                  // BlocBuilder<ManageAttendenceCubit,
                                  //     ManageAttendenceState>
                                  //   (
                                  //   builder: (context, state) {
                                  //     return Column(
                                  //       mainAxisSize: MainAxisSize.max,
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.center,
                                  //       children: [
                                  //         //         state is! GenerateQRCodeSuccessState
                                  //         //            ?
                                  //         ManageAttendenceCubit.get(context)
                                  //                     .nearestSchedule ==
                                  //                 null
                                  //             ? Container(
                                  //                 width: 200.w,
                                  //                 height: 200.h,
                                  //                 decoration: BoxDecoration(
                                  //                   color: FlutterFlowTheme.of(
                                  //                           context)
                                  //                       .secondaryBackground,
                                  //                   image: DecorationImage(
                                  //                     fit: BoxFit.cover,
                                  //                     image: Image.asset(
                                  //                       'assets/images/image112222222222222222222222222222222222.png',
                                  //                     ).image,
                                  //                   ),
                                  //                 ),
                                  //               )
                                  //             : QrImageView(
                                  //                 data: ManageAttendenceCubit.get(
                                  //                         context)
                                  //                     .nearestSchedule![
                                  //                         'schedule_id']
                                  //                     .toString(),
                                  //                 version: QrVersions.auto,
                                  //                 size: 177.0,
                                  //               ),
                                  //       ],
                                  //     );
                                  //   },
                                  // ),
                                  Container(
                                    width: 200.w,
                                    height: 200.h,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(
                                          context)
                                          .secondaryBackground,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.asset(
                                          'assets/images/image112222222222222222222222222222222222.png',
                                        ).image,
                                      ),
                                    ),
                                  ),
                                ),
                                //10 sized box
                                SizedBox(
                                  height: 10.h,
                                ),
                               // ManageAttendenceCubit.get(context).nearestSchedule == null
                               //     ?
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        //are you sure you want to sign out?
                                        title: const Text('هل انت متأكد من تسجيل الخروج؟'),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                width: 100.0,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: Colors.white,
                                                  ),
                                                  child: const Text(
                                                    'لا',
                                                    style: TextStyle(color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 100.0,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                   // Navigator.pop(context);
                                                    //sign out from firebase and navigate to login page
                                                    FirebaseAuth.instance.signOut(
                                                    );
                                                    //remove all firebase cache
                                                    Navigator.pushNamed(context, AppRoutes.login);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: Colors.red.shade800,
                                                  ),
                                                  child: const Text(
                                                    'نعم',
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text(
                                  'تسجيل الخروج',
                                  style: TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.red,
                                    fontSize: 18,
                                  ),
                                ),
                              )
                                    // : Text(
                                    //     'الحصة القادمة في ${DateFormat('h:mm a', 'ar').format(DateTime.fromMillisecondsSinceEpoch(ManageAttendenceCubit.get(context).nearestSchedule!['start_time'].millisecondsSinceEpoch))}',
                                    //     style: TextStyle(
                                    //       color: const Color(0xFFB9B9B9),
                                    //       fontSize: 16.sp,
                                    //       fontFamily: 'Montserrat-Arabic',
                                    //       fontWeight: FontWeight.w400,
                                    //       height: 0.6.h,
                                    //     ),
                                    //   ),
                              ]
                                  .divide(SizedBox(height: 10.h))
                                  .addToStart(SizedBox(height: 0.h)),
                            ),
                          ),
                          //5

                          SizedBox(
                            height: 10.h,
                          ),
                          //text next schedule place
                          //  ManageAttendenceCubit.get(context).nearestSchedule == null
                          //           ?
                           Text(
                                        '',
                                        style: TextStyle(
                                          color: const Color(0xFFB9B9B9),
                                          fontSize: 16.sp,
                                          fontFamily: 'Montserrat-Arabic',
                                          fontWeight: FontWeight.w400,
                                          height: 0.6.h,
                                        ),
                                      ),
                          //           :
                          //  Text(
                          //   'مكان التدريب: '
                          //   //    '${ManageAttendenceCubit.get(context).nearestSchedule == null ? "" :
                          //  // ManageAttendenceCubit.get(context).nearestSchedule!['branch_id'].toString()}'
                          //    ,
                          //   style: TextStyle(
                          //     color: const Color(0xFFB9B9B9),
                          //     fontSize: 16.sp,
                          //     fontFamily: 'Montserrat-Arabic',
                          //     fontWeight: FontWeight.w400,
                          //     height: 0.6.h,
                          //   ),
                          // ),


                          SizedBox(
                            height: 15.h,
                          ),

                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //20

                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  //FirebaseFirestore.instance.collection('users').where(
                                  //                                       'role', isEqualTo: 'user')
                                  //                                       .where('pid',isEqualTo: FirebaseAuth.instance.currentUser!.uid),
                                  final addGroupCubit = context.read<AddGroupCubit>();
                                  addGroupCubit.usersQuery =
                                  FirebaseFirestore.instance.collection('users').where(
                                      'role', isEqualTo: 'user')
                                      .where('pid',isEqualTo: FirebaseAuth.instance.currentUser!.uid);
                                  Navigator.pushNamed(
                                      context, AppRoutes.manageUseers);
                                },
                                child: Container(
                                  width: 155.w,
                                  height: 195.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0x4064B5F6),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 90.w,
                                          height: 90.h,
                                          decoration: const BoxDecoration(
                                            color: Color(0x00FFFFFF),
                                          ),
                                          alignment: const AlignmentDirectional(0, 0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/images/group_add_people_svgrepo.com.png',
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        //10 sized box
                                        const Text(
                                          'ادارة المتدربين',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF2196F3),
                                            fontSize: 16,
                                            fontFamily: 'Montserrat-Arabic',
                                            fontWeight: FontWeight.w400,
                                            height: 0.08,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () //async
                                {
                                  //  await ManageSalaryCubit.get(context).getCoaches();
                                  //  ManageSalaryCubit.get(context).syncData();
                                  final addGroupCubit = context.read<AddGroupCubit>();
                                  addGroupCubit.usersQuery =
                                  FirebaseFirestore.instance.collection('users').where(
                                      'role', isEqualTo: 'coach')
                                      .where('pid',isEqualTo: FirebaseAuth.instance.currentUser!.uid);
                                  Navigator.pushNamed(
                                      context, AppRoutes.manageSalary);
                                },
                                child: Container(
                                  width: 155.w,
                                  height: 195.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEE3E8),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 90.w,
                                          height: 90.h,
                                          decoration: const BoxDecoration(
                                            color: Color(0x00FFFFFF),
                                          ),
                                          alignment: const AlignmentDirectional(0, 0),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/images/productivity.png',
                                              width: 60.w,
                                              height: 60.h,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        //10 sized box
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        const Text(
                                          'ادارة المدربين',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFFD92C20),
                                            fontSize: 16,
                                            fontFamily: 'Montserrat-Arabic',
                                            fontWeight: FontWeight.w400,
                                            height: 0.08,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 20.w)),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(

                                  onTap: () {

                                    Navigator.pushNamed(context, AppRoutes.manageSchedules);
                                 //   Future.delayed(Duration(milliseconds: 100)).then((_) {
                                 //     ManageUsersCubit.get(context).getDays();
                                //    });// Call getDays() after navigation
                                  },
                                child: Container(
                                  width: 155.w,
                                  height: 195.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF9AFFB6),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 90.w,
                                          height: 90.h,
                                          decoration: const BoxDecoration(
                                            color: Color(0x00FFFFFF),
                                          ),
                                          alignment: const AlignmentDirectional(0, 0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/images/group-add-people_svgrepo.com.png',
                                              width: 60.w,
                                              height: 60.h,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        //10 sized box
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        const Text(
                                          //manage appoinments
                                          'ادارة المواعيد',
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            color: Color(0xFF00CE39),
                                            fontSize: 16,
                                            fontFamily: 'Montserrat-Arabic',
                                            fontWeight: FontWeight.w400,
                                            height: 0.08,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  //push named to the page manage attendees
                                  Navigator.pushNamed(
                                      context, AppRoutes.notification);
                                },
                                child: Container(
                                  width: 155.w,
                                  height: 195.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xF1C6F1F7),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 90.w,
                                          height: 90.h,
                                          decoration: const BoxDecoration(
                                            color: Color(0x00FFFFFF),
                                          ),
                                          alignment: const AlignmentDirectional(0, 0),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/images/notification-bell.png',
                                              width: 50.w,
                                              height: 50.h,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        //10 sized box
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        const Text(
                                          'الاشعارات',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF00D1FF),
                                            fontSize: 16,
                                            fontFamily: 'Montserrat-Arabic',
                                            fontWeight: FontWeight.w400,
                                            height: 0.08,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 20.w)),
                          ),
                        ].divide(SizedBox(height: 20.h)),
                      ),
                    ].divide(SizedBox(height: 20.h)),
                  ),
                ),
              ),
          ),
            );
    //     },
    //   );
    // });


  }
}
