import 'package:admin_future/registeration/business_logic/auth_cubit/sign_up_cubit.dart';
import 'package:admin_future/registeration/data/userModel.dart';
import 'package:admin_future/registeration/business_logic/auth_cubit/login_cubit.dart';
import 'package:admin_future/registeration/presenation/SignUpScreen.dart';
import 'package:admin_future/registeration/presenation/add_coach_screen.dart';
import 'package:admin_future/registeration/presenation/login_screen.dart';
import 'package:admin_future/registeration/presenation/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workmanager/workmanager.dart';
import 'Notification/presentation/notification_screen.dart';
import 'add_grouup_of_schedules/presentation/onboarding_screen.dart';
import 'core/constants/routes_manager.dart';
import 'core/constants/strings.dart';
import 'home/presenation/widget/add_schedule.dart';
import 'home/presenation/widget/edit_users.dart';
import 'home/presenation/widget/home_layout.dart';
import 'home/presenation/widget/manage_attendence.dart';
import 'manage_users_coaches/presenation/manage_users_screen.dart';
import 'home/presenation/widget/manage_schedules_screen.dart';
import 'manage_users_coaches/presenation/mange_coaches_screen.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      //  final bool? isAdd;
      //   final String? branchId;
      //   final String? groupId;
      //   final List<String>? schedule_days;
      //   final List<String>? userIds;
      //   final List<String>? scheduleId;
      //   final List<String>? coachIds;
      //   final List<String>? coachList;
      //   final List<String>? usersList;
      //   final List<UserModel>? users;
      //   final List<UserModel>? coaches;
      //   final Map<String, Map<dynamic, dynamic>>? days;
      //   final String? maxUsers;
      case AppRoutes.onboarding:
        args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => OnboardingScreen(
                  // isAdd: (args as Map<String, dynamic>)?['isAdd'],
                  //  final bool? isAdd;
                  //   final String? branchId;
                  //   final String? groupId;
                  //   final List<String>? schedule_days;
                  //   final List<String>? userIds;
                  //   final List<String>? scheduleId;
                  //   final List<String>? coachIds;
                  //   final List<String>? coachList;
                  //   final List<String>? usersList;
                  //   final List<UserModel>? users;
                  //   final List<UserModel>? coaches;
                  //   final Map<String, Map<dynamic, dynamic>>? days;
                  //   final String? maxUsers;
                  isAdd: (args as Map<String, dynamic>)?['isAdd'],
                  branchId: (args as Map<String, dynamic>)?['branchId'],
                  groupId: (args as Map<String, dynamic>)?['groupId'],
                  scheduleDays: (args as Map<String, dynamic>)?['scheduleDays'],
                  userIds: (args as Map<String, dynamic>)?['userIds'],
                  scheduleId: (args as Map<String, dynamic>)?['scheduleId'],
                  coachIds: (args as Map<String, dynamic>)?['coachIds'],
                  coachList: (args as Map<String, dynamic>)?['coachList'],
                  usersList: (args as Map<String, dynamic>)?['usersList'],
                  //users in firebase collection is like that
                  // users
                  // (array)
                  // 0
                  // (map)
                  // branches
                  // (array)
                  // currentMonthHours 0
                  // (number)
                  // currentMonthSalary 0
                  // (number)
                  // date December 11, 2023 at 9:36:32 AM UTC+2
                  // (timestamp)
                  // email null
                  // (null)
                  // fname "cccc"
                  // (string)
                  // hourlyRate 30
                  // (number)
                  // image null
                  // (null)
                  // level null
                  // (null)
                  // lname "cc"
                  // (string)
                  // name "cccc cc"
                  // (string)
                  // numberOfSessions 0
                  // (number)
                  // phone "01097061597"
                  // (string)
                  // pid "fJgvzdHfOORBYSw1HeG6HJP9V7o1"
                  // (string)
                  // role "user"
                  // (string)
                  // token ""
                  // (string)
                  // totalHours 0
                  // (number)
                  // totalSalary 0
                  // (number)
                  // uId "19464f4a-5abf-4ce3-8d37-7eccd1978f60"
                  //which is map of map so we need to convert it to list of userModels
                  users: (args as Map<String, dynamic>)?['users'],
                  // coaches: (args as Map<String, dynamic>)?['coaches']?.map((json) => UserModel.fromJson(json)).toList(),
                  days: (args as Map<String, dynamic>)?['days'],
                  maxUsers: (args as Map<String, dynamic>)?['maxUsers'],
                ));
      //NotificationScreen
      case AppRoutes.notification:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
//AddCoachScreen
      case AppRoutes.addCoach:
        args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
  create: (context) => SignUpCubit(),
  child: AddCoachScreen(
                  isCoach: (args as Map<String, dynamic>)?['isCoach'],
                ),
));

      case AppRoutes.addSchedule:
        args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => AddSchedule(
                  toggle: (args as Map<String, dynamic>)?['toggle'],
                  startTime: (args as Map<String, dynamic>)?['startTime'],
                  endTime: (args as Map<String, dynamic>)?['endTime'],
                  date: (args as Map<String, dynamic>)?['date'],
                  usersList: (args as Map<String, dynamic>)?['usersList'],
                  //scheduleId
                  scheduleId: (args as Map<String, dynamic>)?['scheduleId'],
                  //usersIdsusersIds
                  usersIds: (args as Map<String, dynamic>)?['usersIds'],
                ));

      //signUp
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      //ManageSchedulesScreen
      case AppRoutes.manageSchedules:
        return MaterialPageRoute(builder: (_) => const ManageSchedulesScreen());
      //HomeScreen
      case AppRoutes.welcome:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case AppRoutes.login:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LoginCubit(),
                  child: SignInScreen(),
                ));
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeLayout());
      // manage attendence
      //case AppRoutes.manageAttendence:
      //  return MaterialPageRoute(builder: (_) => const ManageAttendence());
      //ManageCoaches
      case AppRoutes.manageUseers:
        return MaterialPageRoute(builder: (_) => const ManageUsersScreen());
      //ManageGroupsScreen
      // Navigator.pushNamed(
      //                                                            context,
      //                                                         AppRoutes.manageGroups,
      //                                                         arguments: {
      //                                                           'isAdd': false,
      //                                                           'branchId': group.name,
      //                                                           'maxUsers': group.maxUsers,
      //                                                           'days': group.days,
      //                                                           'usersList': group.usersList,
      //                                                           'coachList': group.coachList,
      //                                                           'coachIds': group.coachIds,
      //                                                           'userIds': group.userIds,
      //                                                           'scheduleId': group.schedulesIds,
      //                                                           'schedule_days': group.schedulesDays,
      //                                                           'groupId': group.groupId,
      //                                                         },
      //                                                         );
      //  case AppRoutes.manageGroups:
      // args = settings.arguments as Map<String, dynamic>;
      //     return MaterialPageRoute(builder: (_) => ManageGroupsScreen(
      // isAdd: (args as Map<String, dynamic>)?['isAdd'],
      // branchId: (args as Map<String, dynamic>)?['branchId'],
      // maxUsers: (args as Map<String, dynamic>)?['maxUsers'],
      // days: (args as Map<String, dynamic>)?['days'],
      // usersList: (args as Map<String, dynamic>)?['usersList'],
      // coachList: (args as Map<String, dynamic>)?['coachList'],
      // coachIds: (args as Map<String, dynamic>)?['coachIds'],
      // userIds: (args as Map<String, dynamic>)?['userIds'],
      // scheduleId: (args as Map<String, dynamic>)?['scheduleId'],
      // schedule_days: (args as Map<String, dynamic>)?['schedule_days'],
      // groupId: (args as Map<String, dynamic>)?['groupId'],
      //   ));

      // manage Salary
      case AppRoutes.manageSalary:
        return MaterialPageRoute(builder: (_) => const ManageCoaches());
      // default:
      //   return _errorRoute();
      //EditUsers
      //     await Navigator.pushNamed(context,
      //                                  AppRoutes.editProfile,
      //                                  arguments: ManageSalaryCubit.get(context).users[index]);
      case AppRoutes.editProfile:
        //make args as map to get the data from it
        //  args = settings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (_) => EditUsers(
                  user: args,
                  isCoach: (args as UserModel).role == AppStrings.coach,
                ));
      //else if noo route found  show dialog to ask user to exit app
      // default:
      //   return MaterialPageRoute(builder: (_) =>AlertDialog(
      //     title: const Text('Error'),
      //     content: const Text('No route defined for that name.'),
      //     actions: <Widget>[
      //       TextButton(
      //         onPressed: () => exit(0),
      //         child: const Text('Exit'),
      //       ),
      //     ],
      //   ));
    }

    // static Route<dynamic> _errorRoute() {
    //   // Exit the app if there is no route defined for the given route settings
    //   return MaterialPageRoute(builder: (_) {
    //     WidgetsBinding.instance.addPostFrameCallback((_) => exit(0));
    //     return Container();
    //   });
  }
}

class DefaultDialogToAskUserToExitAppOrNot {
  static Future<bool?> show(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data:
          Theme.of(context).copyWith(dialogBackgroundColor: Colors.white, primaryColor: Colors.white),
          child: AlertDialog(
            backgroundColor: Colors.white,
surfaceTintColor: Colors.white,

            title: const Text(
              //arabic
              'تنبيه',
              textDirection: TextDirection.rtl,
            ),
            content: // Text('Are you sure you want to exit the app?'),
            //translate to arabic
            const Text(
              'هل انت متاكد من انك تريد الخروج من التطبيق؟',
              textDirection: TextDirection.rtl,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 100.w,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text("الغاء", style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    width: 100.w,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text("خروج", style: TextStyle(color: Colors.white)),
                      style:
                      ElevatedButton.styleFrom(primary: Colors.red.shade800),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
