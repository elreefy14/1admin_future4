import 'dart:convert';

import 'dart:math';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../business_logic/auth_cubit/sign_up_cubit.dart';

Widget BuildTextFormField2(

    String labelText,
    TextEditingController controller,
    TextInputType input,
    String hintText,
    String? Function(String?) validator,
    IconData? icon, {
      BuildContext? context,
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        labelText,
        style: TextStyle(
          color: const Color(0xFF333333),
          fontSize: 14.sp,
          fontFamily: 'IBM Plex Sans Arabic',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
        textAlign: TextAlign.right,
      ),
      const SizedBox(height: 8),
      TextFormField(
textDirection: TextDirection.ltr,
        textAlign: TextAlign.right,
        controller: controller,
        keyboardType: input,
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
          hintText: hintText,
          hintStyle: TextStyle(
            color: const Color(0xFF333333),
            fontSize: 16.sp,
            fontFamily: 'IBM Plex Sans Arabic',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
          errorStyle: const TextStyle(
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            height: 20.0 / 14.0,
            color: Color(0xFFD92D20),
          ),
          filled: true,
          fillColor: const Color(0xFFF4F4F4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(color: const Color(0xFF2196F3), width: 1.5.w),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w),
          // Add the random password button

          suffixIcon: labelText == 'كلمة المرور'
              ? Padding(padding: EdgeInsets.symmetric(horizontal: 5.0.w),child: ElevatedButton(

            onPressed: () {
              String randomPassword =
              generateRandomPassword(); // Replace with your random password generation logic
              Clipboard.setData(ClipboardData(text: randomPassword));
              //   addGroupCubit.searchController.text = randomPassword;\
              SignUpCubit.get(context).passwordController.text =
                  randomPassword;
              //context.read<AddGroupCubit>().searchController.text = randomPassword;
              ScaffoldMessenger.of(context!).showSnackBar(
                const SnackBar(content: Text('تم نسخ كلمة المرور إلى الحافظة')),
              );
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade100),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ))),
            child: const Text('إنشاء كلمة المرور',  style: TextStyle(
              color: Colors.blue,
            ),),
          ),)
              : //if label text is الاسم الاول //show icon button
          labelText == 'الاسم الاول' ?
          IconButton(
            icon: const Icon(Icons.contacts),
            onPressed: ()  async {
              //check if permission is granted
              if (await Permission.contacts.request().isGranted) {
                // Either the permission was already granted before or the user just granted it.
                print('Permission granted');
               // print('Pressed');
                final Contact? selectedContact = await ContactsService.openDeviceContactPicker();
                if (selectedContact != null) {
                  final String? firstName = selectedContact.givenName ?? '';
                  final String? lastName = selectedContact.familyName ?? '';
                  final String? phoneNumber = selectedContact.phones?.first.value ?? '';
                  //function update Controllers in cubit
                  // SignUpCubit.get(context!).firstNameController.text = firstName??'';
                  //SignUpCubit.get(context).lastNameController.text = lastName??'d';
                  //  SignUpCubit.get(context).phoneController.text = phoneNumber??'';
                  SignUpCubit.get(context).updateControllers(
                    firstName: firstName??'',
                    lastName: lastName??'',
                    phone: phoneNumber??'',
                  );
              }
              else{
                //if permission is not granted
                //ask for permission
                await Permission.contacts.request();
              }


                // Save the first name, last name, and phone number of the selected contact
                // to the device or perform any other desired actions
                // ...

              //  print('Selected Contact: $firstName $lastName, Phone: $phoneNumber');
              }
            },
            iconSize: 20,
            color: Colors.grey,
          )
              : null,

          // IconButton(
          //   icon: Icon(Icons.vpn_key),
          //   onPressed: () {
          //     String randomPassword = generateRandomPassword(); // Replace with your random password generation logic
          //     Clipboard.setData(ClipboardData(text: randomPassword));
          //  //   addGroupCubit.searchController.text = randomPassword;\
          //     SignUpCubit
          //         .get(context)
          //         .passwordController.text = randomPassword;
          //     //context.read<AddGroupCubit>().searchController.text = randomPassword;
          //     ScaffoldMessenger.of(context!).showSnackBar(
          //       SnackBar(content: Text('Password copied to clipboard')),
          //     );
          //   },
          // ): null,
        ),
        validator: validator,
      ),
    ],
  );
}

String generateRandomPassword() {
  //random password with 6 characters
  var random = Random.secure();
  var values = List<int>.generate(6, (i) => random.nextInt(255));
  return base64Url.encode(values);
}

Widget BuildTextFormField(
    String labelText,
    TextEditingController controller,
    TextInputType input,
    String hintText,
    String? Function(String?) validator,
    String? prefixIconPath,
    String? suffixIconPath,
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        labelText,
        style: const TextStyle(
          fontSize: 14.0,
          color: Color(0xFF333333),
          fontFamily: 'IBM Plex Sans Arabic',
        ),
        textAlign: TextAlign.right,
      ),
      const SizedBox(height: 8),
      TextFormField(
        //rtl
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.right,
        //  scrollPadding: //50 from bottom of screen
        //   EdgeInsets.only(bottom: 50.h),
        controller: controller,
        keyboardType: input,
       // obscureText: labelText == 'كلمة المرور' ? true : false,
        decoration: InputDecoration(
          prefixIcon: prefixIconPath != null
              ? ImageIcon(
            AssetImage(prefixIconPath),
            color: const Color(0xFF333333),
          )
              : null,
          suffixIcon: suffixIconPath != null
              ? ImageIcon(
            AssetImage(suffixIconPath),
            color: const Color(0xFF333333),
          )
              : null,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
            height: 24.0 / 16.0,
            color: Color(0xFF666666),
          ),
          errorStyle: const TextStyle(
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            height: 20.0 / 14.0,
            color: Color(0xFFD92D20),
          ),
          filled: true,
          fillColor: const Color(0xFFF4F4F4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(color: Color(0xFF2196F3), width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        validator: validator,
      ),
    ],
  );
}