import 'package:workmanager/workmanager.dart';

void registerPeriodicTask(
    {required String uniqueName, required String taskName,}) {
  {
    Workmanager().registerPeriodicTask(
      uniqueName,
      taskName,
      //8 hours
      frequency: const Duration(seconds: 30),
      //25 seconds
      initialDelay: const Duration(seconds: 35),
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
      ),
    );
  }
  //Workmanager().registerPeriodicTask(
  // //call dummy function to make the app work in the background
  //     '5',
  //     '6',
  //     //8 hours
  //     //frequency: const Duration(seconds: 30),
  //     //25 seconds
  //     frequency: const Duration(seconds:30),
  //     backoffPolicy: BackoffPolicy.linear,
  //    // existingWorkPolicy: ExistingWorkPolicy.replace,
  //     tag: 'tag',
  //     // constraints: Constraints(
  //     //networkType: NetworkType.connected,
  //     //  ),
  //   );

}
void registerPeriodicTask2(
    ){
  Workmanager().registerPeriodicTask(
    '5',
    '6',
    //8 hours
    //frequency: const Duration(seconds: 30),
    //25 seconds
    frequency: const Duration(seconds:30),
    backoffPolicy: BackoffPolicy.linear,
    // existingWorkPolicy: ExistingWorkPolicy.replace,
    tag: 'tag',
    constraints: Constraints(
      networkType: NetworkType.connected,
      requiresBatteryNotLow: true,
    ),
  );
}
//Workmanager().registerPeriodicTask(
// //call dummy function to make the app work in the background
//     '5',
//     '6',
//     //8 hours
//     //frequency: const Duration(seconds: 30),
//     //25 seconds
//     outOfQuotaPolicy: OutOfQuotaPolicy.run_as_non_expedited_work_request,
//     frequency: const Duration(seconds:30),
//
//     backoffPolicy: BackoffPolicy.linear,
//     existingWorkPolicy: ExistingWorkPolicy.replace,
//     tag: 'tag',
//     // constraints: Constraints(
//     //networkType: NetworkType.connected,
//     //  ),
//   );
void registerPeriodicTask3(
    ){
  Workmanager().registerPeriodicTask(
    '5',
    '6',
    //8 hours
    //frequency: const Duration(seconds: 30),
    //25 seconds
    outOfQuotaPolicy: OutOfQuotaPolicy.run_as_non_expedited_work_request,
    frequency: const Duration(seconds:30),
    backoffPolicy: BackoffPolicy.linear,
    existingWorkPolicy: ExistingWorkPolicy.replace,
    tag: 'tag',
    constraints: Constraints(
      networkType: NetworkType.connected,
      requiresBatteryNotLow: true,
    ),
  );
}
//  Workmanager().registerOneOffTask(
// //call dummy function to make the app work in the background
//     '4',
//     '5',
//     //8 hours
//     //frequency: const Duration(seconds: 30),
//     //25 seconds
//     initialDelay: const Duration(seconds:30),
//     // constraints: Constraints(
//     //networkType: NetworkType.connected,
//     //  ),
//   );
void registerOneOffTask(
    ){
  Workmanager().registerOneOffTask(
    '4',
    '5',
    //8 hours
    //frequency: const Duration(seconds: 30),
    //25 seconds
    initialDelay: const Duration(seconds:30),
    constraints: Constraints(
      networkType: NetworkType.connected,
      requiresBatteryNotLow: true,
    ),
  );
}