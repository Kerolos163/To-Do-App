import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Core/Widget/TaskItem.dart';
import 'package:todoapp/Feature/Layout/presentation/viewmodel/cubit/cubit.dart';
import 'package:todoapp/Feature/Layout/presentation/viewmodel/cubit/state.dart';

class NewTask extends StatelessWidget {
  const NewTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: LayoutCubit.get(context).myList.isNotEmpty,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                  itemBuilder: (context, index) => TaskItem(
                      taskmodel: LayoutCubit.get(context).myList[index]),
                  separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Divider(),
                      ),
                  itemCount: LayoutCubit.get(context).myList.length),
            );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
