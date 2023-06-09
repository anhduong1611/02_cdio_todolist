import 'package:cloud_firestore/cloud_firestore.dart';

class Task_todo{
  final String ? date;
  final String ? name;

  Task_todo({this.date, this.name});

  factory Task_todo.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Task_todo(
      date: data?['date'],
      name: data?['name']
      // state: data?['state'],
      // country: data?['country'],
      // capital: data?['capital'],
      // population: data?['population'],
      // regions:
      // data?['regions'] is Iterable ? List.from(data?['regions']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (date != null) "date": date,

    };
  }
}