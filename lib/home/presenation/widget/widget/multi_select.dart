import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/Home/manage_attendence_cubit .dart';
import '../../../business_logic/Home/manage_attendence_state.dart';


class MultiSelectUserNames extends StatelessWidget {
  final List<String> items;
  //final List<String> selectedItems;
  //final Function(List<String>) onSelectionChanged;

  const MultiSelectUserNames({
    Key? key,
    required this.items,
    // required this.selectedItems,
    // required this.onSelectionChanged,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageAttendenceCubit, ManageAttendenceState>(
      builder: (context, state) {
        return  AlertDialog(
          title: const Text(
            //translate(context, 'select_your_branches'),
              'برجاء اختيار الفروع المسؤول عنها'),
          content: SingleChildScrollView(
            child: ListBody(
              children: items
                  .map(
                    (item) =>
                    CheckboxListTile(
                        value: ManageAttendenceCubit.get(context).selectedCoaches
                            ?.contains(item)??false,
                        title: Text(item),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) {
                          print('isChecked $isChecked');
                          print('item $item');
                          ManageAttendenceCubit.get(context)
                              .itemChange(item, isChecked!,context);
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
                    print('selectedItems ${ManageAttendenceCubit.get(context).selectedCoaches}');
                    Navigator.pop(context,
                        ManageAttendenceCubit.get(context).selectedCoaches);
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


