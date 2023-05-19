
import 'package:flutter/material.dart';
class ItemsView extends StatelessWidget {
  String date, name;
   ItemsView({Key? key,required this.date,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Text(this.name,style: TextStyle(fontSize: 13),),
          Row(
            children: [
              Checkbox(value: false, onChanged: (value) => true,),

            ],
          )
        ],
      ),
    );
  }
}
