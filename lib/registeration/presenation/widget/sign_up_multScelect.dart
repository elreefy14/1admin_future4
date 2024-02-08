import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/auth_cubit/sign_up_cubit.dart';
import '../../business_logic/auth_cubit/sign_up_state.dart';

class MultiSelect extends StatelessWidget {
  final List<String> items;
  //final List<String> selectedItems;
  //final Function(List<String>) onSelectionChanged;

  const MultiSelect({
    Key? key,
    required this.items,
    // required this.selectedItems,
    // required this.onSelectionChanged,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
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
                        value: SignUpCubit.get(context).selectedItems
                            ?.contains(item)??false,
                        title: Text(item),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) {
                          print('isChecked $isChecked');
                          print('item $item');
                          SignUpCubit.get(context)
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
                    print('selectedItems ${SignUpCubit.get(context).selectedItems}');
                    Navigator.pop(context,
                        SignUpCubit.get(context).selectedItems);
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


