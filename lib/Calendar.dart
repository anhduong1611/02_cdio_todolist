import 'package:cdio/wigdet/bottomsheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
   

        print(_selectedDate);
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }
  // void refreshpage() {
  //   setState(() {
  //     count++;
  //   });
  // }

  Future<void> getDataFromFireStore() async {
    var snapShotsValue = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid.toString())
        .collection('Tasks')
        .get();

    //   list = snapShotsValue.docs
    //       .map((e) => Meeting(
    //           date: e.data()['date'],
    //           id: e.data()['id'],
    //           name: e.data()['name'],
    //           duedate: e.data()['duedate'],
    //           color: Color.fromARGB(255, 21, 207, 167),
    //           reminder: e.data()['reminder']))
    //       .toList();
    //   setState(() {
    //     events = MeetingDataSource(list);
    //   });
    // }
  }
  CollectionReference user = FirebaseFirestore.instance.collection('Users')
  .doc(FirebaseAuth.instance.currentUser?.uid.toString())
  .collection('Tasks');

  String currentDate = DateFormat('MMddyyyy').format(DateTime.now());

  var color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min  ,
        children: [
          SfDateRangePicker(
            backgroundColor: color,
            onSelectionChanged:(dateRangePickerSelectionChangedArgs) {
              setState(() {
                currentDate = DateFormat('MMddyyyy').format(dateRangePickerSelectionChangedArgs.value);
              });
              print(currentDate);
            },
            selectionMode: DateRangePickerSelectionMode.single,
            initialSelectedRange: PickerDateRange(
                DateTime.now().subtract(const Duration(days: 4)),
                DateTime.now().add(const Duration(days: 3))),
          ),
          FutureBuilder<QuerySnapshot>(
              future: user.get(),
              builder: (context, snapshot) {
                 if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: ListView(
                      children: snapshot.data!.docs.where((element) {
                        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
                        return DateFormat('MMddyyyy').format(DateTime.fromMillisecondsSinceEpoch(int.parse(data!["date"]))) == currentDate;
                      },).map((DocumentSnapshot doc) {
                        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                        var time = DateTime.fromMillisecondsSinceEpoch(int.parse(data["date"]),isUtc: true).toString()
                        .split(' ')[0]
                        .split('-')
                        .reversed
                        .toList()
                        .join('/');
                        print(time);
                
                    
                        return SizedBox(
                          height: 100,
                          child: ListTile(
                              title:  Text('name:${data['name']}', style: TextStyle(color: Colors.black),),
                              subtitle:  Text('date: $time',style: TextStyle(color: Colors.black),),
                              tileColor: Colors.cyan,
                          ),
                        );
                        
                        ;
                      }).toList(),
                    ),
                  );
                  
                } else{
                return Text("loading");
                }
              },
              )
        ],
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
                });
          },
          backgroundColor: MColor.blue_main,
          child: const Icon(
            Icons.add,
          )),
    );
  }
}

class Meeting {
  String? date;
  String? duedate;
  bool? completed;
  String? reminder;
  String? name;
  String? id;
  Color? color;
  Meeting(
      {this.duedate,
      this.completed,
      this.reminder,
      this.date,
      this.name,
      this.id,
      this.color});
  // // Getters
  // String? get getDate => date;
  // String? get getDuedate => duedate;
  // bool? get isCompleted => completed;
  // String? get getReminder => reminder;
  // String? get getName => name;
  // String? get getId => id;
  // Color? get getColor => color;

  // // Setters
  // set setDate(String? value) {
  //   date = value;
  // }

  // set setDuedate(String? value) {
  //   duedate = value;
  // }

  // set setCompleted(bool? value) {
  //   completed = value;
  // }

  // set setReminder(String? value) {
  //   reminder = value;
  // }

  // set setName(String? value) {
  //   name = value;
  // }

  // set setId(String? value) {
  //   id = value;
  // }

  // set setColor(Color? value) {
  //   color = value;
  // }
}
