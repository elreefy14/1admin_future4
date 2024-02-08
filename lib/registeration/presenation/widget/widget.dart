import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/my_color.dart';


Widget defaultFormField2({
  required context,
  TextEditingController? controller,
  dynamic hintText,
  dynamic labelText,
  IconData? prefix,
  int maxLines = 1,
  String? initialValue,
  TextInputType? keyboardType,
  Function(String)? onSubmit,
  onChange,
  onTap,
  required String? Function(String?) validate,
  bool isPassword = false,
  bool enabled = true,
  IconData? suffix,
  suffixPressed,
}) =>
    Container(
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        textAlign: TextAlign.start,
        onFieldSubmitted: onSubmit,
        enabled: enabled,
        onChanged: onChange,
        onTap: onTap,
        validator: validate,
        textCapitalization: TextCapitalization.words,
        textAlignVertical: TextAlignVertical.center,
        style: Theme.of(context).textTheme.bodyText1,
        initialValue: initialValue,
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: hintText,
          labelText: labelText,
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Colors.grey)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Colors.grey)),
          prefixIcon: Icon(
            prefix,
            color: Colors.blueAccent,
          ),
          prefixStyle: TextStyle(color: Colors.blueAccent),
          suffixStyle: TextStyle(color: Colors.blueAccent),
          suffixIcon: suffix != null
              ? IconButton(
              onPressed: suffixPressed,
              icon: Icon(suffix, color: Colors.blueAccent))
              : null,
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
void navigateAndFinsh(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (route) => false,
);

Widget defaultFormField(
    {required TextEditingController controller,
      required TextInputType type,
      Function? onSubmit,
      Function? onChange,
      bool isPassword = false,
      required String? Function(String? val)? validate,
      double radius = 0.0,
      String? label,
      IconData? prefix,
      IconData? suffix,
      Function? suffixPressed,
      bool isClickable = true,
      double width = double.infinity}) =>
    Container(
      width: width,
      height: 55.h,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: (e) {
          if (onSubmit != null) onSubmit(e);
        },
        onChanged: (s) {
          if (onChange != null) onChange(s);
        },
        validator: validate,
        // textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          errorStyle: TextStyle(

            overflow: TextOverflow.ellipsis,
            height: 2.5,
            color: Colors.red,
          ),
          border: InputBorder.none,
          labelText: label,

          prefixIcon: Icon(
            prefix,
          ),
          hintStyle: TextStyle(
              fontFamily: 'Metropolis-Regular',
              fontSize: 16,
              color: placeholder),
          suffixIcon: suffix != null
              ? IconButton(
            onPressed: () {
              suffixPressed!();
            },
            icon: Icon(
              suffix,
            ),
          )
              : null,
        ),
      ),
    );
Widget defaultButton({
  double width = double.infinity,
  double height = 45,
  Color backgroundColor = mainColor,
  Color borderColor = mainColor,
  Color fontColor = Colors.white,
  bool isUpperCase = true,
  String fontFamily = 'Metropolis-SemiBold',
  double radius = 3.0,
  double borderWidth = 0,
  double fontSize = 16.0,
  required Function function,
  required String text,
  IconData? prefix,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefix != null)
              FaIcon(
                prefix,
                size: 20,
                color: Color(0xFFffffff),
              ),
            if (prefix != null)
              SizedBox(
                width: 20,
              ),
            Text(
              isUpperCase ? text.toUpperCase() : text,
              style: TextStyle(
                  color: fontColor, fontSize: fontSize, fontFamily: fontFamily),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth, color: borderColor),
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: backgroundColor,
      ),
    );
Widget mySeparator() => Container(
  width: double.infinity,
  height: 1,
  color: Colors.grey[500],
);
//showToast2
void showToast({
  required String msg,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Widget CustomTextField(
    {required TextEditingController controller,
      BuildContext ?context,
      required String label,
       IconData? icon,
      TextInputType? type,
       bool? isPassword,
       Function(String)? validate,
       Function(String)? onSubmit,
       Function(String)? onChange,
       FocusNode? focusNode,
       FocusNode? nextFocusNode,
       bool? isLast,
    }) {
return Padding(
padding: const EdgeInsets.symmetric(vertical: 10),
child: TextFormField(
controller: controller,
keyboardType: type,
obscureText: isPassword?? false,
onFieldSubmitted: (value) {

},
focusNode: focusNode,
decoration: InputDecoration(
labelText: label,
prefixIcon: Icon(
icon,
color: Color(0xFFF2F2F2),
),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(20),
),
focusedBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(20),
borderSide: BorderSide(
color:Color(0xFFF2F2F2),
),
),
),
),
);
}
