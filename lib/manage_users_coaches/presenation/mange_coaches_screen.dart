import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:admin_future/home/presenation/widget/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../add_grouup_of_schedules/presentation/select_coaches.dart';
import '../../core/constants/routes_manager.dart';
import '../../core/flutter_flow/flutter_flow_theme.dart';
import '../business_logic/manage_users_cubit.dart';

class ManageCoaches extends StatelessWidget {
  const ManageCoaches({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton:  BlocBuilder<ManageUsersCubit, ManageUsersState>(
        builder: (context, state) {
          return

            ManageUsersCubit.get(context).showRollbackButton
                ?
            InkWell(
              onTap: ()  {
                //todo zbat il sync
                ManageUsersCubit.get(context).rollbackSalary().then((value)
                =>  ManageUsersCubit.get(context).updateShowRollbackButton());
              },
              child: // circle button for rollback show for 5 seconds
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Icon(
                    Icons.history_sharp,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ):Container();
        },
      ),

      appBar: const CustomAppBar(text: 'ادارة المدربين'),
      // key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            //   mainAxisSize: MainAxisSize.max,
            children: [

              //60
              SizedBox(
                height: 50.h,
              ),
              SizedBox(
                width: double.infinity,
                height: 550.h,
                child: ShowCoachesInDialog(
                  isCoachInfoList: true,
                  selectedUsers: const [],
                  isCoach:  true,
                  //   selectedUsers: isCoach
                  //       ? context.read<AddGroupCubit>().state.selectedCoaches
                  //       : context.read<AddGroupCubit>().state.selectedUsers,
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

              SizedBox(height: 20.h,),
              // is //showRollbackButton
              //10
              SizedBox(height: 10.h,),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: ()  {
                      Navigator.pushNamed(context,
                          AppRoutes.addCoach,
                          arguments: {
                            'isCoach':true,
                          }
                        // arguments: ManageSalaryCubit.get(context).users
                      ) ;
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 30.h,
                      ),

                      height: 50.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Text(
                          'اضافة مدرب',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                            fontFamily: 'Readex Pro',
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 5),
                  // const Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'مجموع مرتب كل المدربين',
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //         color: Color(0xFF333333),
                  //         fontSize: 16,
                  //         fontFamily: 'Montserrat-Arabic',
                  //         fontWeight: FontWeight.w400,
                  //         height: 1.62,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  //todo: add total salary
//                                             SizedBox(
//                                               width: 48,
//                                               child: BlocBuilder<ManageUsersCubit, ManageUsersState>(
//         builder: (context, state) {
//           return Text(
//                                                 ManageUsersCubit.get(context).globalTotalSalary.toString(),
//                                                 textAlign: TextAlign.center,
//                                                 style: const TextStyle(
//                                                   color: Color(0xFF2196F3),
//                                                   fontSize: 14,
//                                                   fontFamily: 'Montserrat-Arabic',
//                                                   fontWeight: FontWeight.w400,
//                                                   height: 1.30,
//                                                 ),
//                                               );
//         },
// ),
//                                             ),

                ],
              ),
              //20
              SizedBox(height: 50.h,),

            ].divide(const SizedBox(height: 0)),
          ),
        ),


      ),



    );
  }
}


