import 'package:cdio/Todolist_Color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class MFeedBack extends StatefulWidget {
  const MFeedBack({Key? key}) : super(key: key);

  @override
  State<MFeedBack> createState() => _MFeedBackState();
}

class _MFeedBackState extends State<MFeedBack> {
  late final String user_email;
  TextEditingController tx_title = TextEditingController();
  TextEditingController tx_body = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user_email = FirebaseAuth.instance.currentUser!.email!;
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset : true,
      backgroundColor: MColor.grey_background,
      body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topLeft,
              image: AssetImage('assets/image/shape_top.png'),
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'FEED BACK PLAN PRO!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'We would like your feedback to improve our app',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20,bottom: 20),
                    child: Image.asset('assets/image/banner_feedback.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Title',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        TextField(
                          controller: tx_title,
                          decoration: InputDecoration(
                              hintText: 'Was Plan Pro helpful?',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)))),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child:
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Your Feedback',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                              TextField(
                                controller: tx_body,
                                maxLines: 4,
                                decoration: InputDecoration(
                                    hintText: 'Give as many details as possible',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(4)))),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            // final Email email = Email(
                            //   body: tx_body.text,
                            //   subject: tx_title.text,
                            //   recipients: ['hothianhduong1611@gmail.com'],
                            //   cc: [user_email],
                            //   bcc: ['hothianhduong16112002@gmail.com'],
                            // );
                            // await FlutterEmailSender.send(email);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: MColor.blue_main,
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            width: width/2,
                            padding: EdgeInsets.all(10),

                            child: Center(child: Text('Submit Feedback',style: TextStyle(color: Colors.white,fontSize: 14),)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
