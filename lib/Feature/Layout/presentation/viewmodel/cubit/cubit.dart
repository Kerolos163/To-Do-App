import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../ArchivedTasks/presentaion/view/ArchivedTask.dart';
import '../../../../DoneTasks/presentaion/view/DoneTask.dart';
import '../../../../NewTasks/presentaion/view/NewTask.dart';

import 'state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(InitialLayoutState());
  static LayoutCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<String> titles = [
    "New Tasks",
    "Done Tasks",
    "Archived Tasks",
  ];
  final List screens = [
    const NewTask(),
    const DoneTask(),
    const ArchivedTask(),
  ];
  changeCurrentIndex({required int newIndex}) {
    currentIndex = newIndex;
    emit(ChangeIndexLayoutState());
  }

  createTable() async {
    await openDatabase(
      'ToDo.db',
      version: 1,
      onCreate: (db, version) {
        log("create Table");
        db
            .execute(
                'CREATE TABLE Test (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          log("created Table");
        }).catchError((error) {
          log("There Are Error $error");
        });
      },
      onOpen: (db) {
        log("Open Table");
      },
    );
  }
}
