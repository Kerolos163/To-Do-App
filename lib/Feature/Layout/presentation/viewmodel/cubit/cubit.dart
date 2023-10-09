import 'dart:developer';

import 'package:flutter/material.dart';
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
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController timeController;
  late TextEditingController dateController;
  bool isBottomSheetShow = false;
  changeCurrentIndex({required int newIndex}) {
    currentIndex = newIndex;
    emit(ChangeIndexLayoutState());
  }

  changeBottonSheetIcon({required bool value}) {
    isBottomSheetShow = value;
    emit(ChangeIconBottomSheetState());
  }

  late Database database;
  List<Map> newTaskList = [];
  List<Map> doneTaskList = [];
  List<Map> archiveTaskList = [];
  createTable() async {
    database = await openDatabase(
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
        getFromDataBase(database: db);
      },
    );
  }

  Future insertToDataBase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO Test(title, date, time, status) VALUES("$title", "$date","$time","new")')
          .then((value) {
        getFromDataBase(database: database);
        log("$value inserted successfuly");
      }).catchError((error) {
        log("Error When Creating Table $error");
      });
    });
  }

  void getFromDataBase({required Database database}) async {
    newTaskList = [];
    doneTaskList = [];
    archiveTaskList = [];
    emit(GetDataLayoutLoadingState());
    database.rawQuery('SELECT * FROM Test').then((value) {
      for (var element in value) {
        if (element["status"] == "new") {
          newTaskList.add(element);
        } else if (element["status"] == "Done") {
          doneTaskList.add(element);
        } else if (element["status"] == "Archive") {
          archiveTaskList.add(element);
        }
      }
      emit(GetDataLayoutSuccessState());
    });
  }

  updateDataBase({required String status, required int id}) async {
    database.rawUpdate(
      'UPDATE Test SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      getFromDataBase(database: database);
      emit(UpdateStatusState());
    });
  }

  deleteFromDataBase({required int id}) async {
    database.rawDelete('DELETE FROM Test WHERE id = ?', [id]).then((value) {
      getFromDataBase(database: database);
      emit(DeleteFromDataBaseState());
    });
  }
}
