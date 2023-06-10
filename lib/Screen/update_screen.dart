import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cdio/OTask.dart';
import 'package:cdio/database/FireBaseOptions.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Todolist_Color.dart';
import '../wigdet/bottomsheet.dart';

class MUpdateScreen extends StatefulWidget {
  Task_todo task_todo;
  MUpdateScreen({Key? key, required this.task_todo}) : super(key: key);




  @override
  State<MUpdateScreen> createState() => _MUpdateScreenState();
}

class _MUpdateScreenState extends State<MUpdateScreen> {
  final name_controller = TextEditingController();

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
  String set_date_choose = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,0,0,0,0).millisecondsSinceEpoch.toString();
  String set_duedate_choose = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,0,0,0,0).millisecondsSinceEpoch.toString();
  String set_time_reminder = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,0,0,0,0).millisecondsSinceEpoch.toString();
  late DateTime time_reminder;

  final controller_name_Task = TextEditingController();
  void onTimeChanged(Time newTime) {
    _time = newTime;
  }
  @override
  Widget build(BuildContext context) {
    List<DateTime?> _dialogCalendarPickerValue = [
      DateTime.fromMillisecondsSinceEpoch(int.parse(widget.task_todo.date.toString())),
      DateTime.fromMillisecondsSinceEpoch(int.parse(widget.task_todo.duedate.toString())),

    ];
    return Scaffold(
      backgroundColor: MColor.grey_background,
      body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
            alignment: Alignment.topLeft,
            image: AssetImage('assets/image/shape_top.png'),
          )),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 55, bottom: 35),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: null,
                          child: Container(
                              height: 30,
                              width: 150,
                              decoration: const BoxDecoration(
                                color: MColor.grey_background,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: const Center(
                                child: Text(
                                  'No type',
                                  style: TextStyle(color: MColor.grey_text),
                                ),
                              ))),
                      InkWell(
                        onTap: (){
                          this.widget.task_todo.name = name_controller.text;

                            options.update_task(this.widget.task_todo.id.toString(), this.widget.task_todo);
                            Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.check_circle,
                          color: MColor.blue_main,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    child: TextField(
                      controller: name_controller,
                        maxLines: 8,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: this.widget.task_todo.name,
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        )),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(

                    children: [
                       InkWell(
                        onTap: () async {
                          final values = await showCalendarDatePicker2Dialog(context: context, config: config, dialogSize: const Size(325, 400),value: _dialogCalendarPickerValue);
                          if (values != null) {
                            print(_getValueText(
                              config.calendarType,
                              values,
                            ));
                            setState(() {
                              _dialogCalendarPickerValue = values;

                              set_date_choose = _dialogCalendarPickerValue[0]!.millisecondsSinceEpoch.toString();
                              set_duedate_choose = _dialogCalendarPickerValue[1]!.millisecondsSinceEpoch.toString();
                              this.widget.task_todo.date = set_date_choose;
                              this.widget.task_todo.duedate = set_duedate_choose;
                            });
                          }},
                        child: const Icon(
                          Icons.calendar_month_rounded,
                          color: MColor.blue_main,
                          size: 35,
                        ),
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: Text('Due Date'),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Container(
                            decoration: const BoxDecoration(
                              color: MColor.duedate,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: Text(this.widget.task_todo.duedate =="" ?"No Due": DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(this.widget.task_todo.duedate.toString()))
                                  ),
                                  style: TextStyle(color: MColor.red_main),
                                ),
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
