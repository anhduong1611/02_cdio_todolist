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
//     DateTime time_ran_id = DateTime.now();
      task.id = DateTime.now().millisecondsSinceEpoch.toString();
    final docRef = db
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid.toString())
        .collection("Tasks")
        .withConverter(
      fromFirestore: Task_todo.fromFirestore,
      toFirestore: (Task_todo city, options) =>
          city.toFirestore(),
    )
//         .doc(time_ran_id.toString());
//     await docRef.set(task!);
       .doc(task.id).set(task);
    print('Success add task');
  }
}
