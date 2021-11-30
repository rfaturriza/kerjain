import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kerjain/controllers/task_controller.dart';
import 'package:kerjain/models/task_model.dart';
import 'package:kerjain/utils/colors.dart';
import 'package:kerjain/utils/text.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskController tc = Get.find();

    return Scaffold(
        body: SafeArea(
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom.heading2(
                  text: 'Kalender', color: ColorsCustom.textPrimary),
              Expanded(
                child: SfCalendar(
                  headerStyle: CalendarHeaderStyle(
                    textStyle: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        color: ColorsCustom.textPrimary),
                  ),
                  selectionDecoration: BoxDecoration(
                    color: ColorsCustom.primary1,
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      ColorsCustom.secondary2.withOpacity(0.5),
                      ColorsCustom.secondary1.withOpacity(0.5)
                    ]),
                  ),
                  showDatePickerButton: true,
                  todayHighlightColor: ColorsCustom.secondary2,
                  viewHeaderStyle: ViewHeaderStyle(
                    dateTextStyle: TextStyle(
                        fontFamily: 'Lato', color: ColorsCustom.textPrimary),
                    dayTextStyle: TextStyle(color: ColorsCustom.textPrimary),
                  ),
                  todayTextStyle: TextStyle(
                      fontFamily: 'Lato', color: ColorsCustom.textPrimary),
                  appointmentTextStyle: TextStyle(
                      fontFamily: 'Lato', color: ColorsCustom.textSecondary),
                  view: CalendarView.day,
                  timeSlotViewSettings: TimeSlotViewSettings(
                    timeIntervalWidth: -1,
                    timeFormat: 'H',
                    timeTextStyle: TextStyle(
                        fontFamily: 'Lato', color: ColorsCustom.textPrimary),
                  ),
                  dataSource: DataSource(tc.allTasks),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<TaskModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startDate;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endDate;
  }

  @override
  String getSubject(int index) {
    return appointments![index].title;
  }

  @override
  Color getColor(int index) {
    return Color(appointments![index].color);
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}
