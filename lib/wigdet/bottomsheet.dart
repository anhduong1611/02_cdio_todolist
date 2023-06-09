import 'package:cdio/database/FireBaseOptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cdio/Todolist_Color.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

import '../OTask.dart';
class BottomSheetTask extends StatefulWidget {
  BottomSheetTask({Key? key}) : super(key: key);
  static List<String> title_week =['Sun','Mon',"Tue","Wed","Thur","Fri","Sta"];
  static const dayTextStyle =
  TextStyle(color: Colors.black, fontWeight: FontWeight.w700);

  @override
  State<BottomSheetTask> createState() => _BottomSheetTaskState();
}

class _BottomSheetTaskState extends State<BottomSheetTask> {
  List<DateTime?> _dialogCalendarPickerValue = [
    DateTime.now(),
    DateTime.now(),
  ];
  final FireBaseOptions options = new FireBaseOptions();
  String _getValueText(
      CalendarDatePicker2Type datePickerType,
      List<DateTime?> values,
      ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
          .map((v) => v.toString().replaceAll('00:00:00.000', ''))
          .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }
  final config = CalendarDatePicker2WithActionButtonsConfig(
      dayTextStyle: BottomSheetTask.dayTextStyle,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: MColor.red_main,
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 0,
      weekdayLabels: BottomSheetTask.title_week,
      weekdayLabelTextStyle: const TextStyle(
        color: Color(0xff696969),
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,)
      );

  Time _time = Time(hour: 11, minute: 30, second: 20);

  bool iosStyle = true;
  String set_date_choose ="";
  String set_time_reminder ="";
  late DateTime time_reminder;

  final controller_name_Task = TextEditingController();
  void onTimeChanged(Time newTime) {
      _time = newTime;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          top: 10,
          left: 30,
          right: 30),
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: controller_name_Task,
                  decoration: InputDecoration(
                      hintText: 'Input new task here',
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              InkWell(
                onTap: ()  {
                  DateTime time_ran_id = DateTime.now();
                  Task_todo task =  Task_todo(
                      date: set_date_choose,
                      name: controller_name_Task.text,
                      reminder: set_time_reminder,
                      completed: false,
                      duedate: set_date_choose,//DateTime.fromMillisecondsSinceEpoch(msIntFromServer)
                      id: time_ran_id.toString());
                   options.SavetoFireBase(task);
                   Navigator.pop(context);
                },
                child: Icon(
                  Icons.add,
                  color: MColor.blue_main,
                  size: 40,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: null,
                child: Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                    color: MColor.grey_background,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: Text('No type',style: TextStyle(color: MColor.grey_text),),
                  )
                )),
              InkWell(
                onTap: () async {
                  final values = await showCalendarDatePicker2Dialog(context: context, config: config, dialogSize: const Size(325, 400),value: _dialogCalendarPickerValue);
                  if (values != null) {
                    // ignore: avoid_print
                    print(_getValueText(
                      config.calendarType,
                      values,
                    ));
                    setState(() {
                      _dialogCalendarPickerValue = values;
                      set_date_choose = _dialogCalendarPickerValue[0]!.millisecondsSinceEpoch.toString();
                      });
                  }
                },
                child: const Icon(
                  Icons.calendar_month_rounded,
                  color: MColor.blue_main,
                  size: 35,
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(
                     showPicker(
                      accentColor: MColor.blue_main,
                      showSecondSelector: false,
                      context: context,
                      value: _time,
                      is24HrFormat: true,
                      onChange: onTimeChanged,
                      cancelStyle: TextStyle(color: MColor.cancel_text,fontSize: 14,fontWeight: FontWeight.bold),
                      okStyle: TextStyle(color: MColor.blue_main,fontSize: 14,fontWeight: FontWeight.bold),
                      minuteInterval: TimePickerInterval.FIVE,
                      // Optional onChange to receive value as DateTime
                      onChangeDateTime: (DateTime dateTime)  {
                          setState(() {
                            time_reminder = dateTime;
                            set_time_reminder = time_reminder.toString();
                          });
                      },
                    ),
                  );
                },
                child: Icon(
                  Icons.add_alert_rounded,
                  color: MColor.red_main,
                  size: 35,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


