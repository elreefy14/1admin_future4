// import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
// import 'package:admin_future/home/business_logic/Home/manage_attendence_cubit%20.dart';
// import 'package:admin_future/home/business_logic/Home/manage_attendence_state.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../../core/flutter_flow/flutter_flow_theme.dart';
// //  Future<void> getSchedulesForAdmin(String adminUid) async {
// //     emit(GetSchedulesForAdminLoadingState());
// //     try {
// //       final QuerySnapshot schedulesQuerySnapshot = await FirebaseFirestore.instance
// //           .collection('admins')
// //           .doc(adminUid)
// //           .collection('schedules')
// //           .get();
// //
// //       for (final QueryDocumentSnapshot scheduleDoc in schedulesQuerySnapshot.docs) {
// //         final Map<String, dynamic> scheduleData =
// //         scheduleDoc.data() as Map<String, dynamic>;
// //
// //         final QuerySnapshot usersQuerySnapshot = await scheduleDoc.reference
// //             .collection('users')
// //             .get();
// //
// //         final List<Map<String, dynamic>> usersList = usersQuerySnapshot.docs
// //             .map<Map<String, dynamic>>(
// //                 (QueryDocumentSnapshot documentSnapshot) =>
// //             documentSnapshot.data() as Map<String, dynamic>)
// //             .toList();
// //
// //         final Map<String, dynamic> scheduleWithUserData = {
// //           ...scheduleData,
// //           'users': usersList,
// //         };
// //
// //         schedulesList2.add(scheduleWithUserData);
// //       }
// //       //print all content of schedulesList2
// //       for (int i = 0; i < schedulesList2.length; i++) {
// //         print(schedulesList2[i]);
// //       }
// //       emit(GetSchedulesForAdminSuccessState(
// //       ));
// //     }
// //     catch(e){
// //       emit(GetSchedulesForAdminErrorState(e.toString()));
// //     }
// //   }
// class ManageAttendence extends StatelessWidget {
//   const ManageAttendence({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     //return BlocBuilder<ManageAttendenceCubit, ManageAttendenceState>(
//     // builder: (context, state) {
//
//     return FutureBuilder(
//        // future:  ManageAttendenceCubit.get(context).getSchedulesForAdmin(),
//
//         builder: (context, snapshot) {
//           return Scaffold(
//             // key: scaffoldKey,
//             backgroundColor: Colors.white,
//             body: ConditionalBuilder(
//               builder: (context) =>  SafeArea(
//             top: true,
//             child:
//             Column(
//
//               children: [
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.asset(
//                         'assets/images/back.png',
//                         width: 50,
//                         height: 50,
//                         fit: BoxFit.none,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 30.h,
//                 ),
//                 // Generated code for this Text Widget...
//                 Text(
//                   'ادارة الحضور',
//                   style: FlutterFlowTheme.of(context).bodyMedium.override(
//                     fontFamily: 'Readex Pro',
//                     fontSize: 24,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 60.h,
//                 ),
//                 Expanded(
//                   child: BlocBuilder<ManageAttendenceCubit,ManageAttendenceState >(
//                     builder: (context, state) {
//                       return BlocConsumer<ManageAttendenceCubit, ManageAttendenceState>(
//                         listener: (context, state) {
//                           // TODO: implement listener
//                         },
//                         builder: (context, state) {
//                           return ListView.separated(
//                             shrinkWrap: true,
//                             itemBuilder: (context, index) {
//                               var schedule = ManageAttendenceCubit
//                                   .schedulesList![index];
//                               var startTime =
//                               DateFormat('hh a', 'ar').format(
//                                   schedule['start_time']?.toDate()
//                                   ?? DateTime.now());
//                               var date = DateFormat('yyyy/MM/dd ', 'ar').format(
//                                   schedule['start_time']?.toDate()?? DateTime.now());
//                               var day = DateFormat('EEEE', 'ar').format(
//                                   schedule['start_time']?.toDate() ?? DateTime.now());
//                               var endTime = DateFormat('hh a', 'ar').format(
//                                   schedule['end_time']?.toDate() ?? DateTime.now());
//                               var formattedSchedule = '$startTime $date';
//                               return Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Align(
//                                     alignment: AlignmentDirectional(1, 0),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Row(
//                                           mainAxisSize: MainAxisSize.max,
//                                           children: [
//                                             Text(
//                                               date,
//                                               style: FlutterFlowTheme
//                                                   .of(context)
//                                                   .bodyMedium
//                                                   .override(
//                                                 fontFamily: 'Readex Pro',
//                                                 fontSize: 11,
//                                               ),
//                                             ),
//                                             Row(
//                                               mainAxisSize: MainAxisSize.max,
//                                               children: [
//                                                 Text(
//                                                   startTime,
//                                                   textAlign: TextAlign.center,
//                                                   style: FlutterFlowTheme
//                                                       .of(context)
//                                                       .bodyMedium
//                                                       .override(
//                                                     fontFamily: 'Readex Pro',
//                                                     fontSize: 11,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   '<--',
//                                                   style: FlutterFlowTheme
//                                                       .of(context)
//                                                       .bodyMedium
//                                                       .override(
//                                                     fontFamily: 'Readex Pro',
//                                                     fontSize: 11,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   endTime,
//                                                   style: FlutterFlowTheme
//                                                       .of(context)
//                                                       .bodyMedium
//                                                       .override(
//                                                     fontFamily: 'Readex Pro',
//                                                     fontSize: 11,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ].divide(SizedBox(width: 20)),
//                                         ),
//                                         Align(
//                                           alignment: AlignmentDirectional(0, 0),
//                                           child: Text(
//                                             schedule['branch_id'].toString(),
//                                             style: FlutterFlowTheme
//                                                 .of(context)
//                                                 .bodyMedium
//                                                 .override(
//                                               fontFamily: 'Readex Pro',
//                                               fontSize: 11,
//                                             ),
//                                           ),
//                                         ),
//                                       ].addToStart(SizedBox(width: 5)).addToEnd(SizedBox(width: 5)),
//                                     ),
//                                   ),
//
//                                   Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: schedule['users'].map((Map<String, dynamic> user) {
//                                       return
//                                         StreamBuilder<DocumentSnapshot>(
//                                           stream: FirebaseFirestore.instance
//                                               .collection('admins')
//                                               .doc(FirebaseAuth.instance.currentUser?.uid)
//                                               .collection('schedules')
//                                               .doc(schedule['id'])
//                                               .collection('users')
//                                               .doc(user['id'])
//                                               .snapshots(),
//                                           builder: (context, snapshot) {
//                                             if (!snapshot.hasData) {
//                                               return Container();
//                                             }
//                                             final userData = snapshot.data?.data() as Map<String, dynamic>? ?? {};
//                                             final bool finished = userData['finished'] ?? false;
//                                             return Row(
//                                               mainAxisSize: MainAxisSize.max,
//                                               mainAxisAlignment: MainAxisAlignment.end,
//                                               children: [
//                                                 Row(
//                                                   mainAxisSize: MainAxisSize.max,
//                                                   mainAxisAlignment: MainAxisAlignment.end,
//                                                   children: [
//                                                     Container(
//                                                       width: MediaQuery
//                                                           .sizeOf(context)
//                                                           .width * 0.2,
//                                                       height: 35,
//                                                       decoration: BoxDecoration(
//                                                         color: FlutterFlowTheme
//                                                             .of(context)
//                                                             .secondaryBackground,
//                                                         border: Border.all(
//                                                           color: Color(0xFFB4B4B4),
//                                                           width: 1,
//                                                         ),
//                                                       ),
//                                                       child: Align(
//                                                         alignment: AlignmentDirectional(0, 0),
//                                                         child: Text(
//                                                           'دفع الراتب',
//                                                           textAlign: TextAlign.end,
//                                                           style: FlutterFlowTheme
//                                                               .of(context)
//                                                               .bodyMedium
//                                                               .override(
//                                                             fontFamily: 'Readex Pro',
//                                                             color: Colors.blue,
//                                                             fontSize: 10,
//                                                             decoration: TextDecoration.underline,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Container(
//                                                       width: MediaQuery
//                                                           .sizeOf(context)
//                                                           .width * 0.35,
//                                                       height: 35,
//                                                       decoration: BoxDecoration(
//                                                         color: FlutterFlowTheme
//                                                             .of(context)
//                                                             .secondaryBackground,
//                                                         border: Border.all(
//                                                           color: Color(0xFFB4B4B4),
//                                                           width: 1,
//                                                         ),
//                                                       ),
//                                                       child: Align(
//                                                         alignment: AlignmentDirectional(0, 0),
//                                                         child: Text(
//                                                           user['hourly_rate'].toString(),
//                                                           textAlign: TextAlign.end,
//                                                           style: FlutterFlowTheme
//                                                               .of(context)
//                                                               .bodyMedium
//                                                               .override(
//                                                             fontFamily: 'Readex Pro',
//                                                             fontSize: 10,
//                                                             decoration: TextDecoration.underline,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Align(
//                                                       alignment: AlignmentDirectional(1, 0),
//                                                       child: Container(
//                                                         width: MediaQuery
//                                                             .sizeOf(context)
//                                                             .width * 0.35,
//                                                         height: 35,
//                                                         decoration: BoxDecoration(
//                                                           color: FlutterFlowTheme
//                                                               .of(context)
//                                                               .secondaryBackground,
//                                                           border: Border.all(
//                                                             color: Color(0xFFB4B4B4),
//                                                             width: 1,
//                                                           ),
//                                                         ),
//                                                         child: Align(
//                                                           alignment: AlignmentDirectional(0, 0),
//                                                           child: Text(
//                                                             user['name'].toString(),
//                                                             textAlign: TextAlign.end,
//                                                             style: FlutterFlowTheme
//                                                                 .of(context)
//                                                                 .bodyMedium
//                                                                 .override(
//                                                               fontFamily: 'Readex Pro',
//                                                               fontSize: 10,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Container(
//                                                       width: MediaQuery
//                                                           .sizeOf(context)
//                                                           .width * 0.1,
//                                                       height: 35,
//                                                       decoration: BoxDecoration(
//                                                         color: FlutterFlowTheme
//                                                             .of(context)
//                                                             .secondaryBackground,
//                                                         border: Border.all(
//                                                           color: Color(0xFFB4B4B4),
//                                                           width: 1,
//                                                         ),
//                                                       ),
//                                                       child: Stack(
//                                                         alignment: AlignmentDirectional(0, 0),
//                                                         children: [
//                                                           Container(
//                                                             width: 32,
//                                                             height: 32,
//                                                             decoration: BoxDecoration(
//                                                               color: Color(0x00FFFFFF),
//                                                               borderRadius: BorderRadius.circular(5),
//                                                               // border: Border.all(
//                                                               //   color: Colors.blue,
//                                                               //   width: 2,
//                                                               // ),
//                                                             ),
//                                                             child: Checkbox(
//                                                               onChanged: (value) {
//                                                                 ManageAttendenceCubit.get(context).changeAttendance(
//                                                                     schedule['id'], user['id'], value);
//                                                               },
//
//                                                               hoverColor: Colors.blue,
//                                                               overlayColor: MaterialStateProperty.all(Colors.blue),
//                                                               checkColor: Colors.white,
//                                                               activeColor: Colors.blue,
//                                                               value: finished,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             );
//                                           },
//                                         );
//
//
//                                     }).toList().cast<Widget>(),
//                                   ),
//                                 ].divide(SizedBox(height: 20)),
//                               );
//                             },
//                             separatorBuilder: (context, index) => SizedBox(height: 20.h,),
//                             itemCount: ManageAttendenceCubit
//                                 .schedulesList
//                                 .length,);
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//
//
// //             Column(
// //               mainAxisSize: MainAxisSize.max,
// //               children: [
// //                 Column(
// //                   mainAxisSize: MainAxisSize.max,
// //                   children: [
// //                     Column(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         Row(
// //                           mainAxisSize: MainAxisSize.max,
// //                           children: [
// //                             ClipRRect(
// //                               borderRadius: BorderRadius.circular(8),
// //                               child: Image.asset(
// //                                 'assets/images/back.png',
// //                                 width: 50,
// //                                 height: 50,
// //                                 fit: BoxFit.none,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                         Text(
// //                           'ادارة الحضور',
// //                           style: FlutterFlowTheme.of(context).bodyMedium.override(
// //                             fontFamily: 'Readex Pro',
// //                             fontSize: 24,
// //                           ),
// //                         ),
// //                       ].divide(SizedBox(height: 30)),
// //                     ),
// //                     BlocBuilder<ManageAttendenceCubit, ManageAttendenceState>(
// //   builder: (context, state) {
// //     return ConditionalBuilder(
// //         condition: ManageAttendenceCubit.get(context).schedulesList2.length > 0 || state is GetSchedulesForAdminSuccessState,
// //          builder :   (BuildContext context) =>
// //           Expanded(
// //             child: ListView.builder(
// //       physics: BouncingScrollPhysics(),
// //       itemCount: 1,
// //       // padding: EdgeInsets.zero,
// //     //  shrinkWrap: true,
// //       cacheExtent: 20,
// //
// //       //  scrollDirection: Axis.vertical,
// //       itemBuilder: (BuildContext context, int index)  {
// //         //       var schedule = ManageAttendenceCubit.get(context).schedulesList2[index];
// //         //     var startTime =
// //         //   DateFormat('hh a', 'ar').format(schedule['start_time'].toDate());
// //         //    var date = DateFormat('yyyy/MM/dd ', 'ar').format(schedule['start_time']?.toDate()??DateTime.now());
// //         //    var day = DateFormat('EEEE', 'ar').format(schedule['start_time']?.toDate()??DateTime.now());
// //         //  var endTime =DateFormat('hh a', 'ar').format(schedule['end_time'].toDate());
// //         Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Column(
// //               mainAxisSize: MainAxisSize.max,
// //               children: [
// //                 Divider(
// //                   thickness: 2,
// //                   color: Color(0xFFF4F4F4),
// //                 ),
// //                 Align(
// //                   alignment: AlignmentDirectional(1, 0),
// //                   child: Row(
// //                     mainAxisSize: MainAxisSize.max,
// //                     mainAxisAlignment:
// //                     MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Row(
// //                         mainAxisSize: MainAxisSize.max,
// //                         children: [
// //                           Text(
// //                             '2023 / 6 / 24',
// //                             style:
// //                             FlutterFlowTheme.of(context)
// //                                 .bodyMedium
// //                                 .override(
// //                               fontFamily:
// //                               'Readex Pro',
// //                               fontSize: 11,
// //                             ),
// //                           ),
// //                           Row(
// //                             mainAxisSize: MainAxisSize.max,
// //                             children: [
// //                               Text(
// //                                 '1:00م  ',
// //                                 textAlign: TextAlign.center,
// //                                 style: FlutterFlowTheme.of(
// //                                     context)
// //                                     .bodyMedium
// //                                     .override(
// //                                   fontFamily:
// //                                   'Readex Pro',
// //                                   fontSize: 11,
// //                                 ),
// //                               ),
// //                               Text(
// //                                 '<--',
// //                                 style: FlutterFlowTheme.of(
// //                                     context)
// //                                     .bodyMedium
// //                                     .override(
// //                                   fontFamily:
// //                                   'Readex Pro',
// //                                   fontSize: 11,
// //                                 ),
// //                               ),
// //                               Text(
// //                                 'ص00:11',
// //                                 style: FlutterFlowTheme.of(
// //                                     context)
// //                                     .bodyMedium
// //                                     .override(
// //                                   fontFamily:
// //                                   'Readex Pro',
// //                                   fontSize: 11,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ].divide(SizedBox(width: 20)),
// //                       ),
// //                       Align(
// //                         alignment: AlignmentDirectional(0, 0),
// //                         child: Text(
// //                           'فرع القاهرة',
// //                           style: FlutterFlowTheme.of(context)
// //                               .bodyMedium
// //                               .override(
// //                             fontFamily: 'Readex Pro',
// //                             fontSize: 11,
// //                           ),
// //                         ),
// //                       ),
// //                     ]
// //                         .addToStart(SizedBox(width: 5))
// //                         .addToEnd(SizedBox(width: 5)),
// //                   ),
// //                 ),
// //                 Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     Row(
// //                       mainAxisSize: MainAxisSize.max,
// //                       mainAxisAlignment:
// //                       MainAxisAlignment.end,
// //                       children: [
// //                         Container(
// //                           width: MediaQuery.sizeOf(context)
// //                               .width *
// //                               0.2,
// //                           height: 35,
// //                           decoration: BoxDecoration(
// //                             color:
// //                             FlutterFlowTheme.of(context)
// //                                 .secondaryBackground,
// //                             border: Border.all(
// //                               color: Color(0xFFB4B4B4),
// //                               width: 1,
// //                             ),
// //                           ),
// //                           child: Align(
// //                             alignment:
// //                             AlignmentDirectional(0, 0),
// //                             child: Text(
// //                               'دفع الراتب',
// //                               textAlign: TextAlign.end,
// //                               style: FlutterFlowTheme.of(
// //                                   context)
// //                                   .bodyMedium
// //                                   .override(
// //                                 fontFamily: 'Readex Pro',
// //                                 color: Colors.blue,
// //                                 fontSize: 10,
// //                                 decoration: TextDecoration
// //                                     .underline,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                         Container(
// //                           width: MediaQuery.sizeOf(context)
// //                               .width *
// //                               0.35,
// //                           height: 35,
// //                           decoration: BoxDecoration(
// //                             color:
// //                             FlutterFlowTheme.of(context)
// //                                 .secondaryBackground,
// //                             border: Border.all(
// //                               color: Color(0xFFB4B4B4),
// //                               width: 1,
// //                             ),
// //                           ),
// //                           child: Align(
// //                             alignment:
// //                             AlignmentDirectional(0, 0),
// //                             child: Text(
// //                               '+20 000 000 0000',
// //                               textAlign: TextAlign.end,
// //                               style: FlutterFlowTheme.of(
// //                                   context)
// //                                   .bodyMedium
// //                                   .override(
// //                                 fontFamily: 'Readex Pro',
// //                                 fontSize: 10,
// //                                 decoration: TextDecoration
// //                                     .underline,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                         Align(
// //                           alignment:
// //                           AlignmentDirectional(1, 0),
// //                           child: Container(
// //                             width: MediaQuery.sizeOf(context)
// //                                 .width *
// //                                 0.35,
// //                             height: 35,
// //                             decoration: BoxDecoration(
// //                               color:
// //                               FlutterFlowTheme.of(context)
// //                                   .secondaryBackground,
// //                               border: Border.all(
// //                                 color: Color(0xFFB4B4B4),
// //                                 width: 1,
// //                               ),
// //                             ),
// //                             child: Align(
// //                               alignment:
// //                               AlignmentDirectional(0, 0),
// //                               child: Text(
// //                                 'عبدالرحمن سعيد',
// //                                 textAlign: TextAlign.end,
// //                                 style: FlutterFlowTheme.of(
// //                                     context)
// //                                     .bodyMedium
// //                                     .override(
// //                                   fontFamily:
// //                                   'Readex Pro',
// //                                   fontSize: 10,
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                         Container(
// //                           width: MediaQuery.sizeOf(context)
// //                               .width *
// //                               0.1,
// //                           height: 35,
// //                           decoration: BoxDecoration(
// //                             color:
// //                             FlutterFlowTheme.of(context)
// //                                 .secondaryBackground,
// //                             border: Border.all(
// //                               color: Color(0xFFB4B4B4),
// //                               width: 1,
// //                             ),
// //                           ),
// //                           child: Stack(
// //                             alignment:
// //                             AlignmentDirectional(0, 0),
// //                             children: [
// //                               Container(
// //                                 width: 20,
// //                                 height: 20,
// //                                 decoration: BoxDecoration(
// //                                   color: Color(0x00FFFFFF),
// //                                   borderRadius:
// //                                   BorderRadius.circular(
// //                                       5),
// //                                   border: Border.all(
// //                                     color: Colors.blue,
// //                                     width: 2,
// //                                   ),
// //                                 ),
// //                                 child: ClipRRect(
// //                                   borderRadius:
// //                                   BorderRadius.circular(
// //                                       8),
// //                                   child: SvgPicture.asset(
// //                                     'assets/images/vector.svg',
// //                                     width: 300,
// //                                     height: 200,
// //                                     fit: BoxFit.cover,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     Row(
// //                       mainAxisSize: MainAxisSize.max,
// //                       mainAxisAlignment:
// //                       MainAxisAlignment.end,
// //                       children: [
// //                         Container(
// //                           width: MediaQuery.sizeOf(context)
// //                               .width *
// //                               0.2,
// //                           height: 35,
// //                           decoration: BoxDecoration(
// //                             color:
// //                             FlutterFlowTheme.of(context)
// //                                 .secondaryBackground,
// //                             border: Border.all(
// //                               color: Color(0xFFB4B4B4),
// //                               width: 1,
// //                             ),
// //                           ),
// //                           child: Align(
// //                             alignment:
// //                             AlignmentDirectional(0, 0),
// //                             child: Text(
// //                               'دفع الراتب',
// //                               textAlign: TextAlign.end,
// //                               style: FlutterFlowTheme.of(
// //                                   context)
// //                                   .bodyMedium
// //                                   .override(
// //                                 fontFamily: 'Readex Pro',
// //                                 color: Colors.blue,
// //                                 fontSize: 10,
// //                                 decoration: TextDecoration
// //                                     .underline,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                         Container(
// //                           width: MediaQuery.sizeOf(context)
// //                               .width *
// //                               0.35,
// //                           height: 35,
// //                           decoration: BoxDecoration(
// //                             color:
// //                             FlutterFlowTheme.of(context)
// //                                 .secondaryBackground,
// //                             border: Border.all(
// //                               color: Color(0xFFB4B4B4),
// //                               width: 1,
// //                             ),
// //                           ),
// //                           child: Align(
// //                             alignment:
// //                             AlignmentDirectional(0, 0),
// //                             child: Text(
// //                               '+20 000 000 0000',
// //                               textAlign: TextAlign.end,
// //                               style: FlutterFlowTheme.of(
// //                                   context)
// //                                   .bodyMedium
// //                                   .override(
// //                                 fontFamily: 'Readex Pro',
// //                                 fontSize: 10,
// //                                 decoration: TextDecoration
// //                                     .underline,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                         Align(
// //                           alignment:
// //                           AlignmentDirectional(1, 0),
// //                           child: Container(
// //                             width: MediaQuery.sizeOf(context)
// //                                 .width *
// //                                 0.35,
// //                             height: 35,
// //                             decoration: BoxDecoration(
// //                               color:
// //                               FlutterFlowTheme.of(context)
// //                                   .secondaryBackground,
// //                               border: Border.all(
// //                                 color: Color(0xFFB4B4B4),
// //                                 width: 1,
// //                               ),
// //                             ),
// //                             child: Align(
// //                               alignment:
// //                               AlignmentDirectional(0, 0),
// //                               child: Text(
// //                                 'عبدالرحمن سعيد',
// //                                 textAlign: TextAlign.end,
// //                                 style: FlutterFlowTheme.of(
// //                                     context)
// //                                     .bodyMedium
// //                                     .override(
// //                                   fontFamily:
// //                                   'Readex Pro',
// //                                   fontSize: 10,
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                         Container(
// //                           width: MediaQuery.sizeOf(context)
// //                               .width *
// //                               0.1,
// //                           height: 35,
// //                           decoration: BoxDecoration(
// //                             color:
// //                             FlutterFlowTheme.of(context)
// //                                 .secondaryBackground,
// //                             border: Border.all(
// //                               color: Color(0xFFB4B4B4),
// //                               width: 1,
// //                             ),
// //                           ),
// //                           child: Stack(
// //                             alignment:
// //                             AlignmentDirectional(0, 0),
// //                             children: [
// //                               Container(
// //                                 width: 20,
// //                                 height: 20,
// //                                 decoration: BoxDecoration(
// //                                   color: Color(0x00FFFFFF),
// //                                   borderRadius:
// //                                   BorderRadius.circular(
// //                                       5),
// //                                   border: Border.all(
// //                                     color: Colors.blue,
// //                                     width: 2,
// //                                   ),
// //                                 ),
// //                                 child: ClipRRect(
// //                                   borderRadius:
// //                                   BorderRadius.circular(
// //                                       8),
// //                                   child: SvgPicture.asset(
// //                                     'assets/images/vector.svg',
// //                                     width: 300,
// //                                     height: 200,
// //                                     fit: BoxFit.cover,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ].divide(SizedBox(height: 20)),
// //               ),
// //             ]
// //               .divide(SizedBox(height: 20))
// //               .addToStart(SizedBox(height: 10))
// //               .addToEnd(SizedBox(height: 10)),
// //         );
// //       },
// //     ),
// //           ), fallback: (BuildContext context) {
// //       return Center(
// //         child: CircularProgressIndicator(),
// //       );
// //      },
// //     );
// //   }
// // ),
// //                     Container(
// //                       width: MediaQuery.sizeOf(context).width,
// //                       height: MediaQuery.sizeOf(context).height * 1,
// //                       decoration: BoxDecoration(
// //                         color: Colors.white,
// //                         border: Border.all(
// //                           color: Color(0x009A7D7D),
// //                           width: 0,
// //                         ),
// //                       ),
// //                     ),
// //                   ].divide(SizedBox(height: 60)),
// //                 ),
// //               ].addToStart(SizedBox(height: 10)),
// //             ),
//           ),
//               fallback: (context) => //shimmer loading widget
//                   Center(
//                     child: shimmerLoading(context),
//                   ),
//               condition: ManageAttendenceCubit.schedulesList.length != 0,
//
//             ),
//           );
//         }, future: null,
//     );
//   }
//
//   shimmerLoading(BuildContext context) {
//     return ListView.builder(
//       itemCount: 10,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: 100,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Shimmer.fromColors(
//               baseColor: Colors.grey[300]!,
//               highlightColor: Colors.grey[100]!,
//               child: Row(
//                 children: [
//                   Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       color: Colors.grey,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: 100,
//                           height: 20,
//                           decoration: BoxDecoration(
//                             color: Colors.grey,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Container(
//                           width: 100,
//                           height: 20,
//                           decoration: BoxDecoration(
//                             color: Colors.grey,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Container(
//                           width: 100,
//                           height: 20,
//                           decoration: BoxDecoration(
//                             color: Colors.grey,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
