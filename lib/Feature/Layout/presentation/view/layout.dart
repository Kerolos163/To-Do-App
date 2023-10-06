import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            appBar: AppBar(
              title: Text(LayoutCubit.get(context)
                  .titles[LayoutCubit.get(context).currentIndex]),
            ),
            body: LayoutCubit.get(context)
                .screens[LayoutCubit.get(context).currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                LayoutCubit.get(context).insertToDataBase();
              },
              child: const Icon(Icons.add),
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
