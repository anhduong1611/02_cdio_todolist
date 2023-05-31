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
  final db = FirebaseFirestore.instance;

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
                onTap: () async {
                  DateTime time_ran_id = DateTime.now();
                    Task_todo task = new Task_todo(
                        date: controller_name_Task.text,
                        name: controller_name_Task.text,
                        id: time_ran_id.toString());
                    final docRef = db
                        .collection('Users')
                        .doc(FirebaseAuth.instance.currentUser?.uid.toString())
                        .collection("Tasks")
                        .withConverter(
                          fromFirestore: Task_todo.fromFirestore,
                          toFirestore: (Task_todo city, options) =>
                              city.toFirestore(),
                        )
                        .doc(time_ran_id.toString());
                    await docRef.set(task);
                    print('Success add task');
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
                onTap: (){
                  showCalendarDatePicker2Dialog(context: context, config: config, dialogSize: const Size(325, 400),);
                },
                child: Icon(
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
                          });

                        print(time_reminder);
                        debugPrint("[debug datetime]:  $dateTime");
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
void showCustomDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: 240,
          width: double.infinity,
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Set Time',style: TextStyle(decoration: TextDecoration.none,color: Colors.black,fontSize: 14))

            ],
          ),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}

