import 'dart:isolate';
//import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:admin_future/add_grouup_of_schedules/presentation/onboarding_screen.dart';
import 'package:admin_future/home/business_logic/Home/manage_attendence_cubit%20.dart';
import 'package:admin_future/manage_users_coaches/business_logic/manage_users_cubit.dart';
import 'package:admin_future/routiong.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workmanager/workmanager.dart';
import 'core/bloc_observer.dart';
import 'core/constants/routes_manager.dart';

//todo: if phone is huwawi call that function
@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await Firebase.initializeApp(
    );
    FirebaseFirestore.instance.settings =
    const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
    //use android sett up to make the app work in the background
    FirebaseFirestore.instance.enableNetwork();
   // FirebaseFirestore.instance.collection('dummy').doc('dummy').update({'dummy': 'manager'});
   // FirebaseFirestore.instance.collection('dummy').doc('dummy4').set({'count': 1});
    FirebaseFirestore.instance.collection('dummy').doc('dummy4').update({'count': FieldValue.increment(1)});
    print("work manager mbroooooooook Native called background task: \n\n\n\n\n\n\n"
        "work manager "
        ); //simpleTsk will be emitted here.
    return Future.value(true);
  });
}
@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
final taskId = task.taskId;
await Firebase.initializeApp(
);
FirebaseFirestore.instance.settings =
const Settings(
  persistenceEnabled: true,
  cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
);
//use android sett up to make the app work in the background
FirebaseFirestore.instance.enableNetwork();
//FirebaseFirestore.instance.collection('dummy').doc('dummy5').set({'fetch': 1});
FirebaseFirestore.instance.collection('dummy').doc('dummy5').update({'fetch': FieldValue.increment(1)});
print("backgroundFetch mbroooooooook Native called background task: \n\n\n\n\n\n\nbackgroundFetch"); //simpleTask will be emitted here.
  // Do your work here...
  BackgroundFetch.finish(taskId);
}

late String mainRoute;
//final remoteConfig = //firabase remote config
//FirebaseRemoteConfig.instance;

Future<void> main() async {
  //await initializeDateFormatting('ar', null);
  //wait widget tree to be built
  WidgetsFlutterBinding.ensureInitialized();
  //await AndroidAlarmManager.initialize();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      //make bottom bar transparent
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  // use future builder to wait for firebase to be initialized and cache to be initialized
  // await CacheHelper.init();
  //
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
  const Settings(
    persistenceEnabled: true,
  cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  //use android sett up to make the app work in the background
  FirebaseFirestore.instance.enableNetwork();
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
BackgroundFetch.scheduleTask(
    TaskConfig
      (
      taskId: "com.transistorsoft.customtask",
      delay: 30000,
      periodic: true,
      forceAlarmManager: true,
      stopOnTerminate: false,
      enableHeadless: true,
      startOnBoot: true,
    ),
  );
  BackgroundFetch.configure(
    BackgroundFetchConfig(
      minimumFetchInterval: 1, // Set the interval for the task in minutes
      stopOnTerminate: false, // Continue running the task even if the app is closed
      enableHeadless: true, // Enable handling of tasks in the background isolate
      requiresBatteryNotLow: false, // Allow running the task even if the battery is low
      requiresCharging: false,
      forceAlarmManager: true,
    //give all permissions to the app
      startOnBoot: true, // Run the task once the device is powered on
    ),    (String taskId) async {
      // This callback is called when the app is in the background and a task is triggered.
          await Firebase.initializeApp(
    );
    FirebaseFirestore.instance.settings =
    const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
    //use android sett up to make the app work in the background
    FirebaseFirestore.instance.enableNetwork();
    //FirebaseFirestore.instance.collection('dummy').doc('dummy3').set({'fetch': 1});
    FirebaseFirestore.instance.collection('dummy').doc('dummy3').update({'fetch': FieldValue.increment(1)});
    print("dummy3 fetchhhhhhhhhh mbroooooooook Native called background task: \n\n\n\n\n\n\n backgroundFetch"); //simpleTask will be emitted here.
    },
  );
 BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  BackgroundFetch.scheduleTask(
    TaskConfig
      (
      taskId: "com.transistorsoft.customtask",
      delay: 30000,
      periodic: true,
      forceAlarmManager: true,
      stopOnTerminate: false,
      enableHeadless: true,
      startOnBoot: true,
    ),
  );
//  await AndroidAlarmManager.initialize();

     Workmanager().initialize(
         callbackDispatcher,
          isInDebugMode: kDebugMode,
     );


  if (FirebaseAuth.instance.currentUser == null) {
    mainRoute = AppRoutes.login;
  } else {
    if (kDebugMode) {
      print('user is not null');
      print(FirebaseAuth.instance.currentUser!.uid);
    }
    //uid
    if (kDebugMode) {
      print(FirebaseAuth.instance.currentUser!.uid);
    }
    mainRoute = AppRoutes.home;
  }
  //await DioHelper.init();
  // FirebaseMessaging.onMessage.listen((event) {
  //   print('onMessage\n\n\n');
  //   print(event.notification!.title);
  //   print(event.notification!.body);
  // });
  // // when click on notification to open app
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print('onMessageOpenedApp\n\n\n\n\n\n\n');
  //   print(event.notification!.title);
  //   print(event.notification!.body);
  // });
  // background notification
 // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  //firebase messaging PERMISSION
  // await FirebaseMessaging.instance.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  //


  BlocOverrides.runZoned(() => runApp(const MyApp()),
      blocObserver: MyBlocObserver());
   BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  BackgroundFetch.scheduleTask(
    TaskConfig
      (
      taskId: "com.transistorsoft.customtask",
      delay: 30000,
      periodic: true,
      forceAlarmManager: true,
      stopOnTerminate: false,
      enableHeadless: true,
    ),
  );

        Workmanager().registerPeriodicTask(
//call dummy function to make the app work in the background
    '2',
    '3',
    //8 hours
     frequency: const Duration(seconds: 30 ),
    //25 seconds
    initialDelay: const Duration(seconds:35),
    // constraints: Constraints(
    //networkType: NetworkType.connected,
    //  ),
  );
  Workmanager().registerPeriodicTask(
//call dummy function to make the app work in the background
    '3',
    '4',
    //8 hours
    frequency: const Duration(seconds: 30 ),
    //25 seconds
    initialDelay: const Duration(seconds:20),
    // constraints: Constraints(
    //networkType: NetworkType.connected,
    //  ),
  );
  Workmanager().registerOneOffTask(
//call dummy function to make the app work in the background
    '4',
    '5',
    //8 hours
    //frequency: const Duration(seconds: 30),
    //25 seconds
    initialDelay: const Duration(seconds:30),
    // constraints: Constraints(
    //networkType: NetworkType.connected,
    //  ),
  );
  Workmanager().registerPeriodicTask(
//call dummy function to make the app work in the background
    '5',
    '6',
    //8 hours
    //frequency: const Duration(seconds: 30),
    //25 seconds
    frequency: const Duration(seconds:30),
    backoffPolicy: BackoffPolicy.linear,
   // existingWorkPolicy: ExistingWorkPolicy.replace,
    tag: 'tag',
    // constraints: Constraints(
    //networkType: NetworkType.connected,
    //  ),
  );
  Workmanager().registerPeriodicTask(
//call dummy function to make the app work in the background
    '5',
    '6',
    //8 hours
    //frequency: const Duration(seconds: 30),
    //25 seconds
    outOfQuotaPolicy: OutOfQuotaPolicy.run_as_non_expedited_work_request,
    frequency: const Duration(seconds:30),
    constraints: Constraints(
      networkType: NetworkType.connected,
      requiresBatteryNotLow: true,
    ),
    backoffPolicy: BackoffPolicy.linear,
    existingWorkPolicy: ExistingWorkPolicy.replace,
    tag: 'tag',
    // constraints: Constraints(
    //networkType: NetworkType.connected,
    //  ),
  );

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddGroupCubit(
        ),
        //  lazy: false,
        ),
     //   BlocProvider(create: (context) => SignUpCubit()
     //     ..getBranches()
     //   ),
        BlocProvider(create: (context) => ManageUsersCubit()
        //    ,lazy: false
        ),
        BlocProvider(create: (context) => ManageAttendenceCubit(),
         // lazy: false,
          //    ..addToWhatsAppGroup('https://chat.whatsapp.com/FV27zAcLJocKycZDScif1S', '+2001020684123 ')

          //    ..getNearestScedule(
          //  )
        ),
      ],child:  ScreenUtilInit(
      designSize: const Size(390, 845),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) =>
          MaterialApp(
            // localizationsDelegates: [
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            //   GlobalCupertinoLocalizations.delegate,
            // ],
            // supportedLocales: const [
            //   Locale('ar', "AE"),
            // ],
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              timePickerTheme: const TimePickerThemeData(
                elevation: 10,
                entryModeIconColor: Colors.black,
                hourMinuteShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                backgroundColor: Colors.white,
              ),
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Colors.blue,
                selectionColor: Colors.blue,
                selectionHandleColor: Colors.blue,
              ),
              primarySwatch: //use this as material color #4F46E5
              Colors.blue,
              //MyColors.primaryColor,
            ),
            initialRoute:
            mainRoute,
            //AppRoutes.manageGroups,
            onGenerateRoute: RouteGenerator.generateRoute,
          ),

    ),
    );
  }
}


