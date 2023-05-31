import 'package:cdio/Todolist_Color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
class ItemsView extends StatelessWidget {
  String date, name;
  int color;

   ItemsView({Key? key,required this.date,required this.name,required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top:20),
      height: 50,
      decoration: BoxDecoration(
        color : this.color % 2 == 0 ? MColor.blue_op: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(100))
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(this.name,style: TextStyle(fontSize: 13),),
            Row(
              children: [
                Checkbox(value: false, onChanged: (value) => true,),
                SizedBox(width: 20,),
                SvgPicture.asset('assets/icons/ic_edit.svg'),
                SizedBox(width: 20,),
                SvgPicture.asset('assets/icons/ic_bin.svg'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
