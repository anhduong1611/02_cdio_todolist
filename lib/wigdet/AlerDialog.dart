import 'package:cdio/Todolist_Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database/FireBaseOptions.dart';

class MAlerDialog {
  FireBaseOptions options = FireBaseOptions();
  void Alert_delete(BuildContext context,String id_task) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: 170,
              width: double.infinity,
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment:Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel_outlined),
                    ),
                  ),
                  const Text('Do you want to delete this task?',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15)),
                 SizedBox(height: 25,),

                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(child: Text('CANCEL',style: TextStyle(
                              decoration: TextDecoration.none,
                              color: MColor.grey_text,
                              fontWeight: FontWeight.w600,
                              fontSize: 15)),
                          onTap:() {
                            Navigator.pop(context);
                          },),
                          InkWell(child: Text('DELETE',style: TextStyle(
                              decoration: TextDecoration.none,
                              color: MColor.blue_main,
                              fontWeight: FontWeight.w600,
                              fontSize: 15)),
                          onTap: (){
                            options.deleteFireBase(id_task);
                            Navigator.pop(context);
                          },)
                        ],
                      ),
                 ),

                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }
        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
