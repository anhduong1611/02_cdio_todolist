import 'package:flutter/cupertino.dart';

class MTask extends StatefulWidget {
  const MTask({Key? key}) : super(key: key);

  @override
  State<MTask> createState() => _MTaskState();
}

class _MTaskState extends State<MTask> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Task Screen")),
    );
  }
}
