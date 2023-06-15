import 'dart:core';

import 'package:cdio/wigdet/bottomsheet.dart';
import 'package:cdio/wigdet/item_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'OTask.dart';
import 'Todolist_Color.dart';

class MCalendar extends StatefulWidget {
  const MCalendar({Key? key}) : super(key: key);

  @override
  State<MCalendar> createState() => _MCalendarState();
}

class _MCalendarState extends State<MCalendar> {
  // String? selected_date;
  //   // selected_date = details.date!
  //   //                     .toString()
  //   //                     .split(' ')[0]
  //   //                     .split('-')
  //   //                     .reversed
  //   //                     .toList()
  //   //                     .join('/');
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final String? uid = FirebaseAuth.instance.currentUser?.uid.toString();
  @override
  void initState() {
    getDataFromFireStore().then((results) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value
            .toString()
            .split(' ')[0]
            .split('-')
            .reversed
            .toList()
            .join('/');
        ;
        //bien lay cai gia tri ngay tren lich day bien

        print(_selectedDate);
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  //reload lai cai trang
  bool isLoad = false;
  Future<void> refresh() async {
    setState(() {
      isLoad = true;
    });
    Future.delayed(Duration(microseconds: 1));
    setState(() {
      isLoad = false;
    });
  }

  Future<void> getDataFromFireStore() async {
    var snapShotsValue = await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection('Tasks')
        .get();
  }

  String currentDate = DateFormat('MMddyyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance
        .collection("Users")
        .doc(uid )
        .collection('Tasks');
    double screenHeight = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: screenW,
        height: screenHeight,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30,left: 10,right: 10,bottom: 10),
              child: SfDateRangePicker(

                rangeTextStyle: TextStyle(fontWeight: FontWeight.bold),
                toggleDaySelection: true,
                allowViewNavigation: true,

                navigationDirection: DateRangePickerNavigationDirection.horizontal,
                selectionColor: MColor.red_main,
                backgroundColor: MColor.blue_background_calendar,
                showNavigationArrow: true,
                onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                  setState(() {
                    currentDate = DateFormat('MMddyyyy')
                        .format(dateRangePickerSelectionChangedArgs.value);
                  });
                },
                selectionMode: DateRangePickerSelectionMode.single,
                initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(const Duration(days: 4)),
                    DateTime.now().add(const Duration(days: 3))),
              ),
            ),
             Expanded(
               child: StreamBuilder(
                      stream: user.orderBy('state', descending: false).snapshots(),
                      builder: (context, snapshot) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: (snapshot.data?.docs.length) ?? 0,
                                itemBuilder: ((context, index) {
                              if (DateFormat('MMddyyyy').format(
                                      DateTime.fromMillisecondsSinceEpoch(int.parse(
                                          snapshot.data?.docs[index]
                                              .get('duedate')))) ==
                                  currentDate) {
                                Task_todo task = Task_todo(
                                    date: snapshot.data?.docs[index].get('date'),
                                    duedate:
                                        snapshot.data?.docs[index].get('duedate'),
                                    name: snapshot.data?.docs[index].get('name'),
                                    id: snapshot.data?.docs[index].get('id'),
                                    state: snapshot.data?.docs[index].get('state'),
                                    type: snapshot.data?.docs[index].get('type'),
                                    completed: snapshot.data?.docs[index]
                                        .get('completed'));

                                return ItemsView(task: task, color: index);
                              } else {
                                return Container(
                                  height: 0,
                                );
                              }
                            })),
                          );

                      },
                    ),
             )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Colors.white,
                context: context,
                builder: (BuildContext contexxt) {
                  return BottomSheetTask();
                }).whenComplete(() => refresh());
          },
          backgroundColor: MColor.blue_main,
          child: const Icon(
            Icons.add,
          )),
    );
  }
}
// itemBuilder: (BuildContext context, int index) {
// snapshot.data!.docs.where(
// (element) {
// Map<String, dynamic> data =
// // element.data() as Map<String, dynamic>;
// return DateFormat('MMddyyyy').format(
// DateTime.fromMillisecondsSinceEpoch(
// int.parse(data!["date"]))) ==
// currentDate;
// },
// ).map((DocumentSnapshot doc) {
// Map<String, dynamic> data =
// doc.data() as Map<String, dynamic>;
// DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
// int.parse(data["date"]));
// String time = DateFormat('dd/MM/yyyy').format(dateTime);
// Task_todo task = Task_todo(
// type: data['type'],
// date:data['date'],
// duedate:data['duedate'],
// name:data['name'],
// id: data['id'],
// state: data['state'],
// completed:data['completed']);
// return ItemsView(
// task:  task,color: 1,
// );
// },
