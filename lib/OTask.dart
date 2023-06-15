import 'package:cloud_firestore/cloud_firestore.dart';

class Task_todo{
   String ? date;
   String ? duedate;
  final bool ? completed;
  final String ? reminder;
  late String ? name;
  final String ? id;
  final String ? state;
   String ? type;


  Task_todo({this.duedate, this.completed, this.reminder, this.date, this.name,this.id, this.state,this.type});

  factory Task_todo.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Task_todo(
      date: data?['date'],
      state: data?['state'],
      name: data?['name'],
      id: data?['id'],
      completed:  data?['completed'],
      reminder:  data?['reminder'],
      duedate:  data?['duedate'],
      type:  data?['type'],
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
      if (state != null) "state": state,
      if (type != null) "type": type,
    };
  }
}