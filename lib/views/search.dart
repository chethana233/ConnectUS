import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackon/helper/constants.dart';
import 'package:hackon/services/database.dart';
import 'package:hackon/widgets/widget.dart';

import 'conversationScreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}
String myName;
class _SearchScreenState extends State<SearchScreen> {
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  TextEditingController searchText = new TextEditingController();

  QuerySnapshot searchSnapshot;

  initiateSearch() {
    dataBaseMethods.getUsersByUserName(searchText.text).then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  createChatRoomForConversation(String username) {
    if (username != Constants.myName) {
      List<String> users = [username, Constants.myName];
      var chatRoomId = getChatRoomId(username, Constants.myName);
      Map<String, dynamic> chatRoomMap = {
        "chatroomid": chatRoomId,
        "users": users
      };

      DataBaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ConversationScreen(chatRoomId)));
    }
  }

  @override
  void initState() {
    super.initState();
  }



  Widget searchTile(String userName, String userEmail) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: TextStyle(color: Colors.black,fontSize: 17), ),
              Text(userEmail, style:TextStyle(color: Colors.black,fontSize: 17),),
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(50),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onTap: () => createChatRoomForConversation(userName),
              child: Text(
                "Message",
                style: simpleTextStyle(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget searchList(QuerySnapshot searchSnapshot) {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchTile(searchSnapshot.documents[index].data["name"],
                  searchSnapshot.documents[index].data["email"]);
            }
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Make New Connections", style: TextStyle(fontFamily: 'Pacifico'),),
          backgroundColor: Colors.black54,
          toolbarHeight: 80,
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/Images/oldMan.jpeg"), fit: BoxFit.cover),
            ),
            child: Column(
          children: [
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  
                  Expanded(
                    child: TextField(
                        controller: searchText,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "search username",
                          hintStyle: simpleTextStyle(),
                          border: InputBorder.none,
                        )),
                  ),
                  GestureDetector(
                    onTap: () => initiateSearch(),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          gradient: LinearGradient(
                              colors: [
                                const Color(0x36FFFFFF),
                                const Color(0x9FFFFFFF)
                              ],
                              begin: FractionalOffset.topLeft,
                              end: FractionalOffset.bottomRight),
                          borderRadius: BorderRadius.circular(40)),
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.search, color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            searchList(searchSnapshot),
          ],
        )));
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
