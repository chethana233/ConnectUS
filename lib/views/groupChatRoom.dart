import 'package:flutter/material.dart';
import 'package:hackon/helper/authenticate.dart';
import 'package:hackon/helper/helperFunctions.dart';
import 'package:hackon/services/auth.dart';
import 'package:hackon/services/database.dart';
import 'package:hackon/views/conversationScreen.dart';
import 'package:hackon/views/search.dart';
import 'package:hackon/helper/constants.dart';
import 'package:hackon/widgets/widget.dart';

class GroupChatRoom extends StatefulWidget {
  @override
  _GroupChatRoomState createState() => _GroupChatRoomState();
}

class _GroupChatRoomState extends State<GroupChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  Stream groupChatRoomsStream;

  @override
  Widget allGroupsList() {
    return StreamBuilder(
        stream: groupChatRoomsStream,
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        ChatRoomTile(
                            snapshot.data.documents[index].data["groupID"],
                            snapshot.data.documents[index].data["groupID"]),
                      ],
                    );
                  })
              : Container();
        });
  }


  addNewGroup() {
    String groupId = "1234 Group";
    Map<String, String> groupChatRoomMap = {
      "groupID": groupId,
      "createdBy": Constants.myName
    };
    Map<String, String> userMap = {"userName": Constants.myName};
    dataBaseMethods.createGroupChatRoom(groupId, groupChatRoomMap);
    dataBaseMethods.addParticipantToGroup(groupId, userMap);
    setState(() {});
  }

  void initState() {
    getUserGroups();
    setState(() {});
    super.initState();
  }

  getUserGroups() async {
    dataBaseMethods.getAllGroups().then((value) {
      groupChatRoomsStream = value;
    });
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
  }

  getMyGroups() async {
    dataBaseMethods.getAllGroups().then((value) {
      groupChatRoomsStream = value;
    });
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: allGroupsList(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            addNewGroup();
          }),
//           Column(
//            mainAxisSize: MainAxisSize.min,
//              children:[
//            ,
//            GestureDetector(
//              onTap: () => addNewGroup(),
//              child: Container(
//                alignment: Alignment.bottomCenter,
//                decoration: BoxDecoration(
//                    color: Colors.grey,
//                    gradient: LinearGradient(
//                        colors: [
//                          const Color(0x36FFFFFF),
//                          const Color(0x0FFFFFFF)
//                        ],
//                        begin: FractionalOffset.topLeft,
//                        end: FractionalOffset.bottomRight),
//                    borderRadius: BorderRadius.circular(40)),
//                padding: EdgeInsets.all(12),
//                child: Row(
//                  mainAxisSize: MainAxisSize.max,
//                  children: [
//                    Text("Add new group", style: simpleTextStyle(),),
//                    Icon(
//
//                        Icons.add,
//                        size: 40,
//                        color: Colors.white
//                    ),
//                  ],
//                ),
//              ),
//            )
//          ]),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoom;

  ChatRoomTile(this.userName, this.chatRoom);

  @override
  Widget build(BuildContext context) {
    print(chatRoom);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(chatRoom)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                "${chatRoom.substring(0,1)}",
                style: simpleTextStyle(),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              chatRoom,
              style: simpleTextStyle(),
            )
          ],
        ),
      ),
    );
  }
}
