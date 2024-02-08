import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/Home/manage_attendence_cubit .dart';
import '../../../business_logic/Home/manage_attendence_state.dart';


class MultiSelectDays extends StatelessWidget {
  final List<String> items2;
  //final List<String> selectedItems2;
  //final Function(List<String>) onSelectionChanged;

  const MultiSelectDays({
    Key? key,
    required this.items2,
    // required this.selectedItems2,
    // required this.onSelectionChanged,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageAttendenceCubit, ManageAttendenceState>(
      builder: (context, state) {
        return  AlertDialog(
          title: const Text(
            //translate(context, 'select day of the week'),
              'برجاء اختيار الايام'),
          content: SingleChildScrollView(
            child: ListBody(
              children: items2
                  .map(
                    (item) =>
                    CheckboxListTile(
                        value: ManageAttendenceCubit.get(context).selectedDays
                            ?.contains(item)??false,
                        title: Text(item),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) {
                          print('isChecked $isChecked');
                          print('item $item');
                          ManageAttendenceCubit.get(context)
                              .itemChange2(item, isChecked!,context);
                        }

                    ),
              )
                  .toList(),
            ),
          ),
          actions: [
            // TextButton(
            //   onPressed: () => Navigator.pop(context),
            //   child: const Text('Cancel'),
            // ),
            Center(
              child: Container(
                width: 100.w,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: () {
                    print('selectedItems2 ${ManageAttendenceCubit.get(context).selectedDays}');
                    Navigator.pop(context,
                        ManageAttendenceCubit.get(context).selectedDays);
                  },

                  child: const Text('Submit'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


