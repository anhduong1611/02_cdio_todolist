import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class MCalendar extends StatefulWidget {
  const MCalendar({Key? key}) : super(key: key);

  @override
  State<MCalendar> createState() => _MCalendarState();
}

class _MCalendarState extends State<MCalendar> {
  List<Color> _colorCollection = <Color>[];
  MeetingDataSource? events;
  String? selected_date;
  final myController = TextEditingController();
  late List<Meeting> list;
  int count = 0;
  late DateTime _minDate, _maxDate;
  final List<String> options = <String>['Add', 'Delete', 'Update'];
  final databaseReference = FirebaseFirestore.instance;
   String id = DateTime.now().toString();

  @override
  void initState() {
    _initializeEventColor();
    _minDate = DateTime(2020, 3, 5, 9, 0, 0);
    _maxDate = DateTime(2024, 3, 25, 9, 0, 0);
    getDataFromFireStore().then((results) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    super.initState();
  }
  // void refreshpage() {
  //   setState(() {
  //     count++;
  //   });
  // }

  Future<void> getDataFromFireStore() async {
    var snapShotsValue = await databaseReference
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid.toString())
        .collection('Tasks')
        .get();

    // if (snapShotsValue.exists) {
    //   var data = snapShotsValue.data();
    //   if (data != null) {
    //     var meeting = Meeting(
    //       eventName: data['Subject'],
    //       from: DateFormat('dd/MM/yyyy').parse(data['StartTime']),
    //       to: DateFormat('dd/MM/yyyy').parse(data['EndTime']),
    //       background: Color.fromARGB(255, 21, 207, 167),
    //       isAllDay: false,
    //     );
    //     print('ghi thanh cong');
    //   }
    // }

    list = snapShotsValue.docs
        .map((e) => Meeting(
            date: e.data()['date'],
            id: e.data()['id'],
            name: e.data()['name'],
            duedate: e.data()['duedate'],
            color: Color.fromARGB(255, 21, 207, 167),
            reminder: e.data()['reminder']))
        .toList();
    setState(() {
      events = MeetingDataSource(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: SfCalendar(
                minDate: _minDate,
                maxDate: _maxDate,
                view: CalendarView.month,
                todayHighlightColor: const Color.fromARGB(40, 10, 10, 191),
                initialDisplayDate: DateTime(2023, 6, 6, 9, 0, 0),
                dataSource: events,
                // showCurrentTimeIndicator: true,
                onTap: (CalendarTapDetails details) {
                  selected_date = details.date!
                      .toString()
                      .split(' ')[0]
                      .split('-')
                      .reversed
                      .toList()
                      .join('/');

                  print(selected_date);
                },
                monthViewSettings: MonthViewSettings(
                  showAgenda: true,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 500),
              child: TextField(
                  controller: myController,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your username')),
            )
            // ListView.builder(
            //   itemCount: list.length,
            //   itemBuilder: (context, index) {
            //     Meeting meeting = list[index];
            //     return ListTile(
            //       title: Text('${meeting.eventName}'),
            //       subtitle: Text('From: ${meeting.from}, To: ${meeting.to}'),
            //       trailing: ElevatedButton(
            //         child: Text('Button Text'),
            //         onPressed: () {
            //           // Button Clicked
            //         },
            //       ),
            //     );
            //   },
            // )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

            print(myController);
            databaseReference
                .collection("Users")
                .doc(FirebaseAuth.instance.currentUser?.uid.toString())
                .collection('Tasks')
                .doc(id)
                .set({
              'date': '$selected_date',
              'duedate': '$selected_date',
              'id': id,
              'name': myController.text,
              'reminder': '$selected_date',
            });
            getDataFromFireStore();

            print(selected_date);
          },
          child: Icon(Icons.add),
        ));
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
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
  // Getters
  String? get getDate => date;
  String? get getDuedate => duedate;
  bool? get isCompleted => completed;
  String? get getReminder => reminder;
  String? get getName => name;
  String? get getId => id;
  Color? get getColor => color;

  // Setters
  set setDate(String? value) {
    date = value;
  }

  set setDuedate(String? value) {
    duedate = value;
  }

  set setCompleted(bool? value) {
    completed = value;
  }

  set setReminder(String? value) {
    reminder = value;
  }

  set setName(String? value) {
    name = value;
  }

  set setId(String? value) {
    id = value;
  }

  set setColor(Color? value) {
    color = value;
  }
}
