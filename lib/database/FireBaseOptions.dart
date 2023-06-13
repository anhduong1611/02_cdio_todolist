import 'dart:developer';

import 'package:cdio/OTask.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseOptions{
  final db = FirebaseFirestore.instance;
  void deleteFireBase(String id){
    db.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid.toString()).collection("Tasks").doc(id).delete().then(
          (doc) => print("Task deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }
   void SavetoFireBase(Task_todo task) async{
    final docRef = db
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid.toString())
        .collection("Tasks")
        .withConverter(
      fromFirestore: Task_todo.fromFirestore,
      toFirestore: (Task_todo city, options) =>
          city.toFirestore(),
    )
        .doc(task.id);
    await docRef.set(task!);
    print('Success add task');
  }
  void checked_task(String id,bool value){
    final washingtonRef = db.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid.toString()).collection("Tasks").doc(id);
    washingtonRef.update({"completed": value}).then(
            (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }
  void update_state_task(String id,String duedate,bool completed){
    final washingtonRef = db.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid.toString()).collection("Tasks").doc(id);
    washingtonRef.update({"state": setStatetask(duedate,completed)}).then(
            (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }


  void update_task(String id_task,Task_todo task_todo){
    db.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid.toString()).collection("Tasks").doc(id_task)// <-- Doc ID where data should be updated.
        .update(task_todo.toFirestore()) // <-- Nested value
        .then((_) => print('Updated'))
        .catchError((error) => print('Update failed: $error'));
  }
  String setStatetask(String duedate, bool completed){
    DateTime today = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,0,0,0,0);
    if(!completed){
      if(today.millisecondsSinceEpoch.toString().compareTo(duedate) > 0)
        return "1PERIVOUS";
      else if(today.millisecondsSinceEpoch.toString() == duedate)
        return "2TODAY";
      else
        return "3FUTURE";
    }else
      return "4COMPLETED";

  }
}