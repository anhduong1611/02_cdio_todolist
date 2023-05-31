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
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        uid = user.uid;
      }
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
              const Text(
                'TODAY',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: recipes.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(8),
                        itemBuilder: (BuildContext ctx, int index) {
                          return ItemsView(
                              date: snapshot.data?.docs[index].get('date'),
                              name: snapshot.data?.docs[index].get('name'),
                              color: index);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() async {
              DateTime time_ran_id = DateTime.now();
              Task_todo task = new Task_todo(
                  date: '22/10/2002',
                  name: 'Khong thich an com dau',
                  id: time_ran_id.toString());
              final docRef = db
                  .collection('Users')
                  .doc(uid)
                  .collection("Tasks")
                  .withConverter(
                    fromFirestore: Task_todo.fromFirestore,
                    toFirestore: (Task_todo city, options) =>
                        city.toFirestore(),
                  )
                  .doc(time_ran_id.toString());
              await docRef.set(task);
              print('Success add task');
              //list = docdl() ;
            });
          },
          backgroundColor: MColor.blue_main,
          child: const Icon(
            Icons.add,
          )),
    );
  }
}
