import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Widget/TaskItem.dart';
import '../../../Layout/presentation/viewmodel/cubit/cubit.dart';
import '../../../Layout/presentation/viewmodel/cubit/state.dart';

class ArchivedTask extends StatelessWidget {
  const ArchivedTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: LayoutCubit.get(context).archiveTaskList.isNotEmpty,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                  itemBuilder: (context, index) => TaskItem(
                        taskmodel:
                            LayoutCubit.get(context).archiveTaskList[index],
                        doneTask: () {
                          LayoutCubit.get(context).updateDataBase(
                              status: "Done",
                              id: LayoutCubit.get(context)
                                  .archiveTaskList[index]['id']);
                        },
                        dismissiblekey: LayoutCubit.get(context)
                            .archiveTaskList[index]['id']
                            .toString(),
                        onDismissed: (p0) {
                          LayoutCubit.get(context).deleteFromDataBase(
                              id: LayoutCubit.get(context).archiveTaskList[index]
                                  ['id']);
                        },
                      ),
                  separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Divider(),
                      ),
                  itemCount: LayoutCubit.get(context).archiveTaskList.length),
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
