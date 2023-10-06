import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Feature/Layout/presentation/view/Widget/BottomSheet.dart';
import '../viewmodel/cubit/cubit.dart';
import '../viewmodel/cubit/state.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()..createTable(),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          return Scaffold(
            key: LayoutCubit.get(context).scaffoldKey,
            appBar: AppBar(
              title: Text(LayoutCubit.get(context)
                  .titles[LayoutCubit.get(context).currentIndex]),
            ),
            body: LayoutCubit.get(context)
                .screens[LayoutCubit.get(context).currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // LayoutCubit.get(context).insertToDataBase();
                // showModalBottomSheet(context: context, builder: (context) => Container(),);
                if (LayoutCubit.get(context).isBottomSheetShow) {
                  Navigator.pop(context);
                  LayoutCubit.get(context).changeBottonSheetIcon(value: false);
                } else {
                  LayoutCubit.get(context)
                      .scaffoldKey
                      .currentState!
                      .showBottomSheet(
                        (context) => const BottomSheetScreen(),
                      );
                  LayoutCubit.get(context).changeBottonSheetIcon(value: true);
                }
              },
              child: LayoutCubit.get(context).isBottomSheetShow
                  ? const Icon(Icons.edit)
                  : const Icon(Icons.add),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Task"),
                BottomNavigationBarItem(icon: Icon(Icons.done), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: "Archive"),
              ],
              currentIndex: LayoutCubit.get(context).currentIndex,
              onTap: (value) {
                LayoutCubit.get(context).changeCurrentIndex(newIndex: value);
              },
            ),
          );
        },
      ),
    );
  }
}
