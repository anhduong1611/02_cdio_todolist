import 'package:cdio/OTask.dart';
import 'package:cdio/Todolist_Color.dart';
import 'package:cdio/wigdet/item_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kDefaultPadding = 20.0;

class MTask extends StatefulWidget {
  const MTask({Key? key}) : super(key: key);

  @override
  State<MTask> createState() => _MTaskState();
}

class _MTaskState extends State<MTask> {
  late String uid;
  @override
  void initState()  {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user != null) {
       uid = user.uid;
      }
    });
  }
  List<Task_todo> list = [new Task_todo(date:'20/10/2002', name:'An com di'),new Task_todo(date:'20/11/2002', name: 'Khong an com dau')];
  final List<String> colors_task = <String>['1','2'];
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
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
                      icon:  const Icon(
                        Icons.search_rounded,
                        size: 30,
                        color: MColor.blue_main,
                      ))
                ],
              ),
              const SizedBox(height: kDefaultPadding * 1.5),
              const Text(
                'TODAY',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.separated(

                  padding: const EdgeInsets.all(8),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemsView(
                      date:list[index].date.toString() ,name: list[index].name.toString(),color: colors_task[index],
                    );
                  },

                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
          onPressed: () async {
            Task_todo task = new Task_todo(date: '20/10/2002',name: 'An com di');
            final docRef = db
            .collection('Users').doc(uid)
                .collection("Tasks")
                .withConverter(
              fromFirestore: Task_todo.fromFirestore,
              toFirestore: (Task_todo city, options) => city.toFirestore(),
            )
                .doc("task1");
            await docRef.set(task);
            print('dc r ne');
          },
          backgroundColor: MColor.blue_main,
          child: const Icon(
            Icons.add,
          )),
    );
  }
}
