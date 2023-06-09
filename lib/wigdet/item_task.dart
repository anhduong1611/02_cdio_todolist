import 'package:cdio/Todolist_Color.dart';
import 'package:cdio/wigdet/AlerDialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemsView extends StatefulWidget {
  String date, name,id;
  int color;
  bool completed;
  ItemsView(
      {Key? key,
      required this.date,
      required this.name,
      required this.color,
        required this.id,
      required this.completed})
      : super(key: key);

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

enum Complete { task_complete }

class _ItemsViewState extends State<ItemsView> {
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
    String formattedDate = this.widget.date != ""
        ? DateFormat('dd-MM-yyyy').format(
            DateTime.fromMillisecondsSinceEpoch(int.parse(this.widget.date)))
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
                    this.widget.name,
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
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: this.widget.completed,
                    onChanged: (bool? value) {
                      setState(() {
                        this.widget.completed = value!;
                      });
                    }),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  child: SvgPicture.asset('assets/icons/ic_edit.svg'),
                )
                ,
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: (){
                    MAlerDialog alert =  MAlerDialog() ;
                    alert.Alert_delete(context,this.widget.id);
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
