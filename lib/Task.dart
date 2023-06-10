import 'package:cdio/OTask.dart';
import 'package:cdio/Todolist_Color.dart';
import 'package:cdio/wigdet/bottomsheet.dart';
import 'package:cdio/wigdet/item_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';
const kDefaultPadding = 20.0;

class MTask extends StatefulWidget {
  const MTask({Key? key}) : super(key: key);

  @override
  State<MTask> createState() => _MTaskState();
}

class _MTaskState extends State<MTask> {
  final String? uid = FirebaseAuth.instance.currentUser?.uid.toString();
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference recipes = FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection('Tasks');
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: SizedBox(
                      height: 55,
                      child: TextField(
                          decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Search',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                      )),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search_rounded,
                        size: 30,
                        color: MColor.blue_main,
                      ))
                ],
              ),
              const SizedBox(height: kDefaultPadding * 1.5),
              Expanded(
                child: StreamBuilder(
                    stream: recipes
                        .orderBy('duedate', descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.all(8),
                            itemBuilder: (BuildContext ctx, int index) {
                              Task_todo task = Task_todo(
                                  date: snapshot.data?.docs[index].get('date'),
                                  duedate: snapshot.data?.docs[index].get('duedate'),
                                  name: snapshot.data?.docs[index].get('name'),
                                  id: snapshot.data?.docs[index].get('id'),
                                  completed: snapshot.data?.docs[index].get('completed'));
                              bool isSameDate = true;
                              DateTime today = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,0,0,0,0);
                              final String dateString =
                                  snapshot.data?.docs[index].get('duedate');
                              String date_to_view = DateFormat('dd-MM-yyyy')
                                  .format(DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(dateString.toString())));
                              if (index == 0) {
                                isSameDate = false;
                              } else {
                                final String prevDateString = snapshot
                                    .data?.docs[index - 1]
                                    .get('duedate');
                                if (dateString == prevDateString)
                                  isSameDate = true;
                                else
                                  isSameDate = false;
                              }
                              if ((index == 0 || !(isSameDate))&& dateString == today.millisecondsSinceEpoch.toString()  ) {
                                return Column(children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(dateString != today.millisecondsSinceEpoch.toString()?date_to_view:"TODAY")),
                                  ItemsView(
                                    task: task,
                                    color: index,
                                  )
                                ]);
                              }
                              else if ((index == 0 || !(isSameDate))&& dateString.compareTo(today.millisecondsSinceEpoch.toString()) == 1) {
                                return Column(children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Future")),
                                  ItemsView(
                                    task: task,
                                    color: index,
                                  )
                                ]);
                              }
                              else {
                                return ItemsView(
                                  task: task,
                                  color: index,
                                );
                              }
                            });
                      }
                    }),
              ),
            ],
          ),
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
                });
          },
          backgroundColor: MColor.blue_main,
          child: const Icon(
            Icons.add,
          )),
    );
  }
}

const String dateFormatter = 'MMMM dd, y';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
