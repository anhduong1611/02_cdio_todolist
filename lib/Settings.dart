import 'package:cdio/Screen/feedback_screen.dart';
import 'package:cdio/Todolist_Color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MSettings extends StatefulWidget {
  const MSettings({Key? key}) : super(key: key);

  @override
  State<MSettings> createState() => _MSettingsState();
}

class _MSettingsState extends State<MSettings> {
  bool dark_mode = false;
  late final String user_email;
  late final String profilePhoto ;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();

    user_email = FirebaseAuth.instance.currentUser!.email!;
     profilePhoto = FirebaseAuth.instance.currentUser!.photoURL!;
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: MColor.grey_background,
      body: SingleChildScrollView(
        child: Container(
          child:
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: MColor.blue_profile_background,
                height: height/3,
                width: width,
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: width/3,
                      height: width/3,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(profilePhoto),
                        ),

                      ),
                    ),
                    Text(user_email,style: TextStyle(fontWeight: FontWeight.w700),)
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=>MFeedBack()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(

                        children: [
                          SvgPicture.asset('assets/icons/ic_feedback.svg'),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('Feed Back'),
                          ),
                        ],
                      ),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: (){

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(

                        children: [
                          SvgPicture.asset('assets/icons/ic_donate.svg'),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('Donate'),
                          ),
                        ],
                      ),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: (){

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(

                        children: [
                          SvgPicture.asset('assets/icons/ic_logout.svg'),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('Logout'),
                          ),
                        ],
                      ),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),),

            ],
          ),
        ),
      )
    );

  }
}
//ua login mo
