import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:kerjain/controllers/task_controller.dart';
import 'package:kerjain/models/task_model.dart';

class SearchController extends GetxController {
  final TaskController tc = Get.find();
  var formKeyController = GlobalKey<FormState>().obs;
  var query = ''.obs;
  var resultQuery = <TaskModel>[].obs;

  updateQuery(String queryText) {
    query.value = queryText;
    searchResult();
  }

  void searchResult() {
    final List<TaskModel> task = tc.allTasks.where((task) {
      final titleLower = task.title!.toLowerCase();
      final descLower = task.description!.toLowerCase();
      final searchLower = query.value.toLowerCase();

      return titleLower.contains(searchLower) ||
          descLower.contains(searchLower);
    }).toList();
    resultQuery.value = task;
  }
}
