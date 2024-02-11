// BackgroundFetch.scheduleTask(
//     TaskConfig
//       (
//       taskId: "com.transistorsoft.customtask",
//       delay: 30000,
//       periodic: true,
//       forceAlarmManager: true,
//       stopOnTerminate: false,
//       enableHeadless: true,
//       startOnBoot: true,
//
//     ),
//   );
import 'package:background_fetch/background_fetch.dart';

void scheduleTask() {
  BackgroundFetch.scheduleTask(
    TaskConfig(
      taskId: "com.transistorsoft.customtask",
      delay: 30000,
      periodic: true,
      forceAlarmManager: true,
      stopOnTerminate: false,
      enableHeadless: true,
      startOnBoot: true,
      requiresNetworkConnectivity: true,
      requiresBatteryNotLow: true,
    ),
  );

}