// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todoapp/Core/Widget/TextFormField.dart';
import 'package:todoapp/Feature/Layout/presentation/viewmodel/cubit/cubit.dart';

class BottomSheetScreen extends StatefulWidget {
  const BottomSheetScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomSheetScreen> createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends State<BottomSheetScreen> {
  @override
  void initState() {
    LayoutCubit.get(context).titleController = TextEditingController();
    LayoutCubit.get(context).timeController = TextEditingController();
    LayoutCubit.get(context).dateController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: LayoutCubit.get(context).formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormFiled(
              label: "Title",
              hintText: "Please Enter Title",
              prefix: const Icon(Icons.title),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "The Title Is Empty";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              controller: LayoutCubit.get(context).titleController,
            ),
            const SizedBox(height: 16),
            TextFormFiled(
              label: "Time",
              hintText: "Please Enter Time",
              prefix: const Icon(Icons.watch_later_outlined),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "The Time Is Empty";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              controller: LayoutCubit.get(context).timeController,
              onTap: () {
                showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                ).then((value) {
                  if (value != null) {
                    LayoutCubit.get(context).timeController.text =
                        value.format(context).toString();
                    log(value.format(context));
                  }
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormFiled(
              label: "Date",
              hintText: "Please Enter Date",
              prefix: const Icon(Icons.calendar_month_outlined),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "The Date Is Empty";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              controller: LayoutCubit.get(context).dateController,
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.parse('2024-11-01'))
                    .then((value) {
                  if (value != null) {
                    print(DateFormat.yMMMd().format(value));
                    LayoutCubit.get(context).dateController.text =
                        DateFormat.yMMMd().format(value);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
