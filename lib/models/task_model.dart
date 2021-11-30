import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String? uid;
  @HiveField(1)
  final DateTime? startDate;
  @HiveField(2)
  final DateTime? endDate;
  @HiveField(3)
  final String? title;
  @HiveField(4)
  final String? description;
  @HiveField(5)
  final String? category;
  @HiveField(6)
  final String? status;
  @HiveField(7)
  final int? color;
  @HiveField(8)
  final bool? isAllDay;
  @HiveField(9)
  final bool? enableNotification;
  TaskModel(
      {this.color,
      this.isAllDay,
      this.enableNotification,
      this.uid,
      this.startDate,
      this.endDate,
      this.title,
      this.description,
      this.category,
      this.status});

  Map<String, dynamic> toJson(data) {
    return {
      'uid': uid,
      'startDate': startDate,
      'endDate': endDate,
      'title': title,
      'description': description,
      'category': category,
      'status': status,
      'color': color,
      'isAllDay': isAllDay,
      'enableNotification': enableNotification,
    };
  }

  factory TaskModel.fromJson(data) {
    return TaskModel(
      startDate: data['startDate'],
      endDate: data['endDate'],
      title: data['title'],
      description: data['description'],
      category: data['category'],
      status: data['status'],
      uid: data['uid'],
      color: data['color'],
      isAllDay: data['isAllDay'],
      enableNotification: data['enableNotification'],
    );
  }
}
