import 'package:admin_future/core/flutter_flow/flutter_flow_util.dart';
import 'package:admin_future/home/presenation/widget/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../add_grouup_of_schedules/presentation/select_coaches.dart';
import '../../core/constants/routes_manager.dart';
import '../../core/flutter_flow/flutter_flow_theme.dart';
import '../business_logic/manage_users_cubit.dart';

class ManageUsersScreen extends StatelessWidget {
  const ManageUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
           Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton:  BlocBuilder<ManageUsersCubit, ManageUsersState>(
              builder: (context, state) {
                return

                  ManageUsersCubit.get(context).showRollbackButton
                      ?
                  InkWell(
                    onTap: ()// async
                    {
                      //todo: add rollback salary
                      //await
                       ManageUsersCubit.get(context).rollbackSession().then((value) =>
                           ManageUsersCubit.get(context).updateShowRollbackButtonSession()
                       );
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

            appBar: const CustomAppBar(text:
            //'ادارة المدربين'
           'ادارة المتدربين',
            ),
            // key: scaffoldKey,
            backgroundColor: Colors.white,
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  //   mainAxisSize: MainAxisSize.max,
                  children: [

                    //60
                    SizedBox(
                      height: 50.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 579.h,
                      child: ShowCoachesInDialog(
                        isUserInfoList: true,
                        selectedUsers: const [],
                        isCoach:  false,
                        onSelectedUsersChanged: (users) {

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
                        SizedBox(height: 5.h,),
                        InkWell(
                          onTap: () async {
                            await Navigator.pushNamed(context,
                                AppRoutes.addCoach,
                                arguments: {
                                  'isCoach':false,
                                }
                              // arguments: ManageSalaryCubit.get(context).users
                            );
                          },
                          child: Container(
                            height: 50.h,
                            width: 180.w,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Text(
                                'اضافة متدرب',
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
                        const SizedBox(height: 5),
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