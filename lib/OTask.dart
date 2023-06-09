import 'package:cloud_firestore/cloud_firestore.dart';

class Task_todo{
  final String ? date;
  final String ? duedate;
  final bool ? completed;
  final String ? reminder;
  final String ? name;
  final String ? id;

  Task_todo({this.duedate, this.completed, this.reminder, this.date, this.name,this.id});

  factory Task_todo.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Task_todo(
      date: data?['date'],
      name: data?['name'],
      id: data?['id'],
      completed:  data?['completed'],
      reminder:  data?['reminder'],
      duedate:  data?['duedate'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (date != null) "date": date,
      if (completed != null) "completed": completed,
      if (reminder != null) "reminder": reminder,
      if (duedate != null) "duedate": duedate,
      if (id != null) "id": id,

    };
  }
}