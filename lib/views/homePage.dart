import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hackon/helper/authenticate.dart';
import 'package:hackon/helper/constants.dart';
import 'package:hackon/services/auth.dart';
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
  AuthMethods authMethods = new AuthMethods();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
          title: Text("Roving Retirees",

              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                fontFamily: 'Pacifico',
              )),
          toolbarHeight: 80,
          actions: [
            GestureDetector(
              onTap: () {
                authMethods.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      Icon(Icons.exit_to_app),
                      Text(
                        "Logout",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  )),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Images/home2.jpeg"),
                fit: BoxFit.cover),
          ),
          //color: Colors.grey,
          //padding: EdgeInsets.all(24),
          //padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Column(
            children: [
              Container(
                  height: 50,
                  //alignment: Alignment.centerLeft,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 0,
                        ),
                      ])),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "OUR KEY FEATURES",
                    style: TextStyle(color: Colors.black87, fontSize: 20),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        width: 170,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white),
                        height: 150,
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GroupChatRoom()))
                          },
                          child: Container(
                              padding: EdgeInsets.all(30),
                              child: Text(
                                "JOIN HOBBY GROUPS",
                                style: TextStyle(
                                    color: Colors.pinkAccent.shade100,
                                    fontSize: 17),
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.pinkAccent.shade100),
                        height: 150,
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JobsPage()))
                          },
                          child: Container(
                              padding: EdgeInsets.all(40),
                              alignment: Alignment.centerRight,
                              child: Text(
                                "EXPLORE JOBS",
                                style: simpleTextStyle(),
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),

              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "FEEL GOOD ARTICLES",
                  style: TextStyle(color: Colors.black87, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      width: 150,
                      height: 200,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/Images/music.jpeg"),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        width: 150,
                        height: 200,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/Images/retirement.jpeg"),
                                fit: BoxFit.cover),
                          ),
                        )),
                    SizedBox(width: 8),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        width: 150,
                        height: 200,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/Images/religion.jpeg"),
                                fit: BoxFit.cover),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 40,),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ChatRoom()))
                    },
                    child: Container(
                      width: 180,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.pinkAccent.shade50),
                      child: Column(
                        children: [
                          SizedBox(height: 15,),
                          Icon(Icons.account_circle,size: 50,),
                          Text("MY CHATS",style: TextStyle(fontSize: 15),)
                        ],
                      )
                    ),
                  ),
                  SizedBox(width: 15,),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SearchScreen()))
                    },
                    child: Container(
                        height: 100,
                        width: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.pinkAccent.shade50),
                        child: Column(
                          children: [
                            SizedBox(height: 15,),
                            Icon(Icons.alternate_email, size: 50,),

                            Text("SOCIALISE",style: TextStyle(fontSize: 15)),
                          ],
                        )
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),

            ],
          ),
        ));
  }
}
