// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:uuid/uuid.dart';
// import '../../data/adminModel.dart';
// import '../../data/userModel.dart';
// import '../../presenation/widget/widget.dart';
// import 'sign_up_state.dart';
// //**Collections and Documents:**
// // 1. **users**: A collection to store the information of all coaches.   - Document ID: unique coach ID   - Fields: `name`, `level`, `hourly_rate`, `total_hours`, `total_salary`, `current_month_hours`, `current_month_salary`
// // 2. **branches**: A collection to store the information of all branches.   - Document ID: unique branch ID   - Fields: `name`, `address`
// // 3. **schedules**: A collection to store the information of all schedules.   - Document ID: unique schedule ID   - Fields: `coach_id`, `branch_id`, `start_time`, `end_time`, `date`,  `finished `,
// // 4. **attendanceRequests**: A collection to store the attendance requests sent by coaches.   - Document ID: unique attendance request ID   - Fields: `coach_id`, `schedule_id`, `status`(e.g. 'pending', 'accepted', 'rejected')
// // 5. **salaryHistory**: A subcollection inside the coach document to store the salary history of each coach.   - Document ID: unique salary history ID (usually just the month and year)   - Fields: `month`, `year`, `total_hours`, `total_salary`
//
// // **Workflow:**
// // 1. When a coach logs in, retrieve their information from the `coaches` collection, display their name, training hours, and branches they're assigned to.
// // 2. To display the schedules for each coach, query the `schedules` collection with the `coach_id`. Use the `branch_id` to get branch details from the `branches` collection.
// // 3. When a coach arrives at their schedule, they create a new document in the `attendanceRequests` collection with the `coach_id`, `schedule_id`, and `status` as 'pending'.
// // 4. The admin reviews the attendance requests and updates the `status` field to 'accepted' or 'rejected'.
// // 5. Upon receiving an 'accepted' status, calculate the hours worked for that schedule and update the coach's `total_hours`, `total_salary`, `current_month_hours`, and `current_month_salary` in the `coaches` collection.
// // 6. At the end of each month, create a new document in the `salaryHistory` subcollection for each coach, storing their `total_hours` and `total_salary` for the current month. After that, reset the `current_month_hours` and `current_month_salary` fields in the `coaches` collection.
// // 7. To display the salary history for each coach, query the `salaryHistory` subcollection inside the coach document and show the list containing the current month's total hours and salary, along with all previous months.
// // This design allows you to efficiently handle the required functionality while minimizing the number of reads and writes to the Firestore database.
//
// class SignUpCubit extends Cubit<SignUpState> {
//   SignUpCubit() : super(InitialState());
//
//   static SignUpCubit get(context) => BlocProvider.of(context);
//   void updateSelectedItems(List<String> newSelectedItems) {
//     // selectedItems = newSelectedItems[0];
//     //add first item newSelectedItems to selectedItems
//     selectedItems?.add(newSelectedItems[0]);
//     emit(UpdateSelectedItemsState(
//       selectedItems: selectedItems,
//     ));
//
//   }
//   final formKey = GlobalKey<FormState>();
//   final firstNameController = TextEditingController();
//   //hourlyRateController
//   final hourlyRateController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final passwordController = TextEditingController();
//   List<String>? checkboxGroupValues;
//   //FormFieldController<List<String>>? checkboxGroupValueController;
//   bool showPassword = true;
//   void changePasswordVisibility(){
//     showPassword = !showPassword;
//     emit(ChangePasswordVisibilityState());
//   }
// //sign out
//   Future<void> signOut() async {
//     //emit(SignOutLoadingState());
//     await FirebaseAuth.instance.signOut().then((value) {
//       // emit(SignOutSuccessState());
//     }).catchError((error) {
//       //  emit(SignOutErrorState());
//     });
//   }
// //function to check if email and password are in firebase
//
// //make function yo update new password in firebase
//   Future<void> updatePassword({
//     required String password,
//   }) async {
//     emit(UpdatePasswordLoadingState());
//     FirebaseAuth.instance.currentUser!.updatePassword(password).then((value) {
//       emit(UpdatePasswordSuccessState());
//     }).catchError((error) {
//       String? errorMessage;
//       switch (error.code) {
//         case "weak-password":
//           if (kDebugMode) {
//             print(errorMessage);
//             errorMessage = 'The password provided is too weak.';
//           }
//           break;
//         case "email-already-in-use":
//           if (kDebugMode) {
//             print(errorMessage);
//             errorMessage = 'The account already exists for that email.';
//           }
//           break;
//         case "invalid-email":
//           if (kDebugMode) {
//             print(errorMessage);
//             errorMessage = 'The email address is badly formatted.';
//           }
//           break;
//         case "operation-not-allowed":
//           if (kDebugMode) {
//             print(errorMessage);
//             errorMessage = 'Email/password accounts are not enabled.';
//           }
//           break;
//         default:
//           if (kDebugMode) {
//             errorMessage = 'The error is $error';
//             print(errorMessage);
//           }
//       }
//       emit(UpdatePasswordErrorState(
//         error: errorMessage,
//       ));
//     });
//   }
//
//
//   Future<void> addUser({
//     required String lName,
//     required String fName,
//     required String phone,
//     required String password,
//     required String role,  String? hourlyRate,
//
//   }) async {
//
//     emit(SignUpLoadingState());
//     //if password is empty
//     if (password.isEmpty) {
//       password = '123456';
//     }
//     //if phone number is arabic number start with ٠١ turn it into english number
//     if (phone.startsWith('٠١')) {
//       phone = phone.replaceAll('٠', '0');
//       phone = phone.replaceAll('١', '1');
//       phone = phone.replaceAll('٢', '2');
//       phone = phone.replaceAll('٣', '3');
//       phone = phone.replaceAll('٤', '4');
//       phone = phone.replaceAll('٥', '5');
//       phone = phone.replaceAll('٦', '6');
//       phone = phone.replaceAll('٧', '7');
//       phone = phone.replaceAll('٨', '8');
//       phone = phone.replaceAll('٩', '9');
//     }
//     phone = phone.replaceAll(' ', '');
//     if (phone.startsWith('+2')) {
//       phone = phone.substring(2);
//       //delete any spaces
//     }
//     bool isConnect = await checkInternetConnectivity();
//     //if there is no internet connection
//     if (!isConnect  ) {
//       //if role is coach show error
//       if (role == 'coach') {
//         emit(SignUpErrorState(
//           error: 'لا يمكنك التسجيل كمدرب بدون انترنت',
//         ));
//         showToast(
//           msg: 'لا يمكنك التسجيل كمدرب بدون انترنت',
//           state: ToastStates.ERROR,
//         );
//         return;
//       }
//       //if role is admin
//       //create user with random id
//       String uId = const Uuid().v4();
//       createUser(
//         role: role,
//         isUser: true,
//         // paasword: password,
//         // branches: selectedItems,
//         uId: //random id using uuid package
//         uId,
//
//         phone: phone,
//         fname: fName,
//         lname: lName,
//         hourlyRate :  int.parse(hourlyRate??'30')??30,
//       ); showToast(
//         msg: 'تم التسجيل بنجاح',
//         state: ToastStates.SUCCESS,
//       );
//       firstNameController.clear();
//       lastNameController.clear();
//       phoneController.clear();
//       passwordController.clear();
//       hourlyRateController.clear();
//       //sign out from admin account
//       emit(SignUpSuccessState(uId));
//       return;
//     }
//     String? adminEmail = FirebaseAuth.instance.currentUser!.email;
//     String? adminUid = FirebaseAuth.instance.currentUser!.uid;
//     //remove +2 from phone number
//     //so if phone number begin with +2 remove it
//
//
//     FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: '$phone@placeholder.com',
//         password: password ?? '123456'
//     ).then((value) async {
//       createUser(
//         role: role,
//         isUser: true,
//         // paasword: password,
//         // branches: selectedItems,
//         uId: value.user!.uid,
//         phone: phone,
//         fname: fName,
//         lname: lName,
//         pid: adminUid,
//         hourlyRate :  int.parse(hourlyRate??'30')??30,
//       );
//       //get email from firebase and send it to admin to add it to his list
//       await FirebaseFirestore.instance
//           .collection('admins')
//           .doc(adminUid)
//           .get().then((value) async {
//         showToast(
//           msg: 'تم التسجيل بنجاح',
//           state: ToastStates.SUCCESS,
//         );
//         //sign out from user account
//         await FirebaseAuth.instance.signOut();
//         String? adminPhone = value.data()?['phone'];
//         String? adminPassword = value.data()?['password'];
//         if (kDebugMode) {
//           print(adminEmail);
//           print(adminPassword);
//         }
//         UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: '$adminPhone@placeholder.com',
//           password: adminPassword!,
//         );
//         if (kDebugMode) {
//           print(userCredential.user!.uid);
//         }
//       }
//       );
//
//       //clear text fields
//       firstNameController.clear();
//       lastNameController.clear();
//       phoneController.clear();
//       passwordController.clear();
//       hourlyRateController.clear();
//       //sign out from admin account
//       emit(SignUpSuccessState(value.user!.uid));
//
//     }).catchError((error) {
//       String? errorMessage;
//       switch (error.code) {
//       //case user already exists
//         case "email-already-in-use":
//           if (kDebugMode) {
//             print(errorMessage);
//             errorMessage = 'The account already exists for that email.';
//           }
//           break;
//         case "invalid-email":
//           if (kDebugMode) {
//             print(errorMessage);
//             errorMessage = 'The email address is badly formatted.';
//           }
//           break;
//         case "user-not-found":
//           if (kDebugMode) {
//             print(errorMessage);
//             errorMessage = 'No user found for that email.';
//           }
//           break;
//         case "wrong-password":
//           if (kDebugMode) {
//             print(errorMessage);
//             errorMessage = 'Wrong password provided for that user.';
//           }
//           break;
//         default:
//           if (kDebugMode) {
//             errorMessage = 'The error is $error';
//             print(errorMessage);
//           }
//       }
//       emit(SignUpErrorState(
//         error: errorMessage,
//       ));
//       //show toast error contain error message
//       showToast(
//         msg: errorMessage??'',
//         state: ToastStates.ERROR,
//       );
//     });
//   }
//   void createUser({
//     bool isUser = false,
//     String? paasword,
//     String? role,
//     String? pid,
//     required String? uId,
//     required String? phone,
//     required String? fname,
//     required String? lname,
//     List<String>? branches, int? hourlyRate,
//   }) {
//     emit(CreateUserLoadingState());
//     if (isUser) {
//       UserModel model = UserModel(
//         role: role,
//         hourlyRate: hourlyRate??30,
//         totalHours: 0,
//         totalSalary: 0,
//         currentMonthHours: 0,
//         currentMonthSalary: 0,
//         name: '${fname!} ${lname!}',
//         uId: uId,
//         lname: lname,
//         fname: fname,
//         token: '',
//         phone: phone,
//         pid: pid??FirebaseAuth.instance.currentUser!.uid,
//         numberOfSessions: 0,
//         date: Timestamp.now(),
//         branches: branches??[],
//       );
//       //if phone number is not saved already in the contact list
//
//       saveUserToContactList(
//         name: '$fname $lname',
//         phoneNumber: phone!,
//       );
//       //use batches
//       WriteBatch batch = FirebaseFirestore.instance.batch();
//
//       batch.set(
//         FirebaseFirestore.instance
//             .collection('users')
//             .doc(uId),
//         model.toMap(),
//       );
//       if (role == 'user') {
//         batch.set(
//             FirebaseFirestore.instance.collection('admins').
//             doc(FirebaseAuth.instance.currentUser?.uid).collection('dates').doc('${DateTime.now().month.toString()}-${DateTime.now().year.toString()}'),
//             {
//               'setFlag': true,
//             },
//             SetOptions(merge: true));
//         batch.update(
//           FirebaseFirestore.instance.collection('admins').
//           doc(FirebaseAuth.instance.currentUser?.uid).collection('dates').doc('${DateTime.now().month.toString()}-${DateTime.now().year.toString()}'),
//           {
//             'numberOfNewMembers':FieldValue.increment(1),
//           },
//         );
//       }
//       batch.commit();
//       emit(CreateUserSuccessState(uId!));
//
//
//     } else {
//       AdminModel model = AdminModel(
//         password: paasword,
//         branches: branches,
//         lname: lname,
//         fname: fname,
//         date: Timestamp.now(),
//         token: '',
//         totalMoneyearned: 0,
//         totalMoneySpentOnCoaches: 0,
//         Salary: 0,
//         phone: phone,
//         pId: uId,
//
//       );
//       FirebaseFirestore.instance
//           .collection('admins')
//           .doc(uId)
//           .set(model.toMap())
//           .then((value) {
//         emit(CreateUserSuccessState(uId!));
//       }).catchError((error) {
//         emit(CreateUserErrorState());
//       });
//     }
//   }
//   Future<void> signUp({
//     required String lName,
//     required String fName,
//     required String phone,
//     required String password,
//   }) async {
//     emit(SignUpLoadingState());
//     FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: '$phone@placeholder.com',
//         password: password
//     ).then((value) {
//       createUser(
//         branches: selectedItems,
//         uId: value.user!.uid,
//         phone: phone,
//         fname: fName,
//         lname: lName,
//       );
//       emit(SignUpSuccessState(value.user!.uid));
//     }).catchError((error) {
//       String? errorMessage;
//       switch (error.code) {
//       //case user already exists
//         case "email-already-in-use":
//           if (kDebugMode) {
//             print(errorMessage);
//             errorMessage = 'The account already exists for that email.';
//           }
//           break;
//         case "invalid-email":
//           if (kDebugMode) {
//             print(errorMessage);
//             errorMessage = 'The email address is badly formatted.';
//           }
//           break;
//         case "user-not-found":
//           if (kDebugMode) {
//             print(errorMessage);
//             errorMessage = 'No user found for that email.';
//           }
//           break;
//         case "wrong-password":
//           if (kDebugMode) {
//             print(errorMessage);
//             errorMessage = 'Wrong password provided for that user.';
//           }
//           break;
//         default:
//           if (kDebugMode) {
//             errorMessage = 'The error is $error';
//             print(errorMessage);
//           }
//       }
//       emit(SignUpErrorState(
//         error: errorMessage,
//       ));
//     });
//   }
//
//   //selected items
//   List<String>? selectedItems;
//   void add(String itemValue) {
//     selectedItems ??= [];
//     selectedItems?.add(itemValue.toString());
//
//
//
//     emit(UpdateSelectedItemsState(
//       selectedItems: selectedItems,
//     ));
//   }
//
//   void remove(String itemValue) {
//     selectedItems ??= [];
//     selectedItems?.remove(itemValue.toString());
//     emit(UpdateSelectedItemsState(
//       selectedItems: selectedItems,
//     ));
//   }
//   void itemChange(String itemValue, bool isSelected, BuildContext context) {
//     //final List<String> updatedSelection = List.from(
//     //   SignUpCubit.get(context).selectedItems ?? []);
//
//     if (isSelected) {
//       add(itemValue);
//       // updatedSelection.add(itemValue);
//     } else {
//       remove(itemValue);
//       //  updatedSelection.remove(itemValue);
//     }
//
//     //  onSelectionChanged(updatedSelection);
//   }
//   // final List<String> items = ['Flutter',
// //         'Node.js',
// //         'React Native',
// //         'Java',
// //         'Docker',
// //         'MySQL'
// //       ];
//   //add list of branches names to branches collection in firebase
//   Future<void> addBranches() async {
//     emit(AddBranchesLoadingState());
//     List<String> branches = [
//       'المعادي',
//       'المهندسين',
//       'المقطم',
//       'المنصورة',
//       'المنيا',
//       'النزهة',
//     ];
//     branches.forEach((element) {
//       FirebaseFirestore.instance.collection('branches').add({
//         'name': element,
//       }).then((value) {
//         emit(AddBranchesSuccessState());
//       }).catchError((error) {
//         emit(AddBranchesErrorState());
//       });
//     });
//   }
//   List<String>? items ;
//   Future<void> getBranches() async {
//     items = [];
//     emit(GetBranchesLoadingState());
//     FirebaseFirestore.instance.collection('branches').get().then((value) {
//       value.docs.forEach((element) {
//         items?.add(element['name']);
//       });
//       emit(GetBranchesSuccessState());
//     }).catchError((error) {
//       emit(GetBranchesErrorState());
//     });
//   }
//
//   checkInternetConnectivity() async {
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//     } catch (_) {
//       return false;
//     }
//   }
//
//   // void saveUserToContactList({required String name, String? phone}) {
//   //   //use package contact_service to save user to contact list in the device
//   //  print('saveUserToContactList\n\n\n\n\'');
//   //   Contact newContact = new Contact(
//   //     givenName: name,
//   //     phones: [Item(label: "mobile", value: phone)],
//   //   );
//   //   ContactsService.addContact(newContact);
//   //
//   // }
//
//
//   Future<void> saveUserToContactList({required String name, required String phoneNumber}) async {
//     // Check if the permission has already been granted
//     PermissionStatus status = await Permission.contacts.status;
//     //first check if phone number is saved or not in the contact list
//     Iterable<Contact> contacts = await ContactsService.getContactsForPhone(phoneNumber);
//     print(contacts.length);
//     print('dghhhhhhhhhhhhhthdsr');
//     if (contacts.isNotEmpty) {
//       //if phone number is already saved in the contact list
//       return;
//     }
//     if (status.isGranted) {
//       // Permission has already been granted, proceed with saving the contact
//       final newContact = Contact();
//
//       // Set the display name of the contact
//       newContact.givenName = name;
//
//       // Create a new phone number for the contact
//       final phoneNumberObj = Item(label: 'mobile', value: phoneNumber);
//
//       // Add the phone number to the contact
//       newContact.phones = [phoneNumberObj];
//
//       // Save the contact to the device's contact list
//       await ContactsService.addContact(newContact);
//
//     } else {
//       // Permission has not been granted, request the permission from the user
//       status = await Permission.contacts.request();
//
//       if (status.isGranted) {
//         // Permission has been granted, proceed with saving the contact
//         final newContact = Contact();
//
//         // Set the display name of the contact
//         newContact.givenName = name;
//
//         // Create a new phone number for the contact
//         final phoneNumberObj = Item(label: 'mobile', value: phoneNumber);
//
//         // Add the phone number to the contact
//         newContact.phones = [phoneNumberObj];
//
//         // Save the contact to the device's contact list
//         await ContactsService.addContact(newContact);
//
//       } else {
//         // Permission has been denied, handle the error or show a message to the user
//       }
//     }
//   }
//
//   void updateControllers({required String firstName,
//     required String lastName,
//     required String phone
//   }) {
//     firstNameController.text = firstName;
//     lastNameController.text = lastName;
//     phoneController.text = phone;
//     emit(UpdateControllersState());
//   }
//
// }
