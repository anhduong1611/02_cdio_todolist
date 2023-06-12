import 'package:cdio/Screen/update_screen.dart';
import 'package:cdio/Todolist_Color.dart';
import 'package:cdio/database/FireBaseOptions.dart';
import 'package:cdio/wigdet/AlerDialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../OTask.dart';

class ItemsView extends StatefulWidget {
  final Task_todo task;
  int color;
  ItemsView({Key? key, required this.task, required this.color})
      : super(key: key);

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

enum Complete { task_complete }

class _ItemsViewState extends State<ItemsView> {
  FireBaseOptions option = FireBaseOptions();
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return MColor.blue_main;
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = this.widget.task.duedate != ""
        ? DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(
            int.parse(this.widget.task.duedate.toString())))
        : "";

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20),
      height: 60,
      decoration: BoxDecoration(
          color: this.widget.color % 2 == 0 ? MColor.blue_op : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(100))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    this.widget.task.name.toString(),
                    maxLines: 1,
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(fontSize: 10, color: MColor.red_main),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Checkbox(
                    side:
                    BorderSide(color: Colors.transparent),
                    activeColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: this.widget.task.completed,
                    onChanged: (bool? value) {
                      setState(() {
                        print('checked' + this.widget.task.id.toString());
                        option.checked_task(
                            this.widget.task.id.toString(), value!);
                        option.update_state_task(this.widget.task.id.toString(),this.widget.task.duedate.toString(), value);
                      });
                    }),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  child: SvgPicture.asset('assets/icons/ic_edit.svg'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MUpdateScreen(
                                  task_todo: this.widget.task,
                                )));
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    MAlerDialog alert = MAlerDialog();
                    alert.Alert_delete(context, this.widget.task.id.toString());
                  },
                  child: SvgPicture.asset('assets/icons/ic_bin.svg'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
