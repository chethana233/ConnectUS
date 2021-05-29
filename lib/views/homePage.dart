import 'package:flutter/material.dart';
import 'package:hackon/helper/constants.dart';
import 'package:hackon/views/groupChatRoom.dart';
import 'package:hackon/views/jobs.dart';
import 'package:hackon/views/search.dart';
import 'package:hackon/widgets/widget.dart';
import 'package:hackon/views/chatRooms.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: appBarMain(context),
        body: Container(
          color: Colors.grey,
          padding: EdgeInsets.all(24),
          //padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Column(
            children: [
              //Text("Welcome ${Constants.myName}", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),),

              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blueGrey),
                height: 150,
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GroupChatRoom()))
                  },
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Skill Groups",
                        style: simpleTextStyle(),
                      )),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blueGrey),
                height: 150,
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JobsPage()))
                  },
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Jobs and Opportunities",
                        style: simpleTextStyle(),
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatRoom()))
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black54),
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "My network",
                        style: simpleTextStyle(),
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()))
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black54),
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Make new connections",
                        style: simpleTextStyle(),
                      )),
                ),
              ),
//            Container(
//              color: Colors.blueGrey,
//              width: MediaQuery.of(context).size.width,
//              height: 100,
//              child: Container(
//                  alignment: Alignment.center,
//                  child: Text("Feel Good", style: simpleTextStyle(),)),
//            )
            ],
          ),
        ));
  }
}
