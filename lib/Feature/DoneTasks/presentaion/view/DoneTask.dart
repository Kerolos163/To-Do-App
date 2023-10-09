import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Widget/TaskItem.dart';
import '../../../Layout/presentation/viewmodel/cubit/cubit.dart';
import '../../../Layout/presentation/viewmodel/cubit/state.dart';

class DoneTask extends StatelessWidget {
  const DoneTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: LayoutCubit.get(context).doneTaskList.isNotEmpty,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                  itemBuilder: (context, index) => TaskItem(
                        taskmodel: LayoutCubit.get(context).doneTaskList[index],
                        archived: () {
                          LayoutCubit.get(context).updateDataBase(
                              status: "Archive",
                              id: LayoutCubit.get(context).doneTaskList[index]
                                  ['id']);
                        },
                      ),
                  separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Divider(),
                      ),
                  itemCount: LayoutCubit.get(context).doneTaskList.length),
            );
          },
          fallback: (context) {
            if (state is GetDataLayoutLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Center(
                child: Image.asset(
                  "asset/image/no-task.png",
                  height: 200,
                  width: 200,
                  opacity: const AlwaysStoppedAnimation(.75),
                ),
              );
            }
          },
        );
      },
    );
  }
}
