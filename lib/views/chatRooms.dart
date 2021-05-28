import 'package:flutter/material.dart';
import 'package:hackon/helper/authenticate.dart';
import 'package:hackon/helper/helperFunctions.dart';
import 'package:hackon/services/auth.dart';
import 'package:hackon/services/database.dart';
import 'package:hackon/views/conversationScreen.dart';
import 'package:hackon/views/search.dart';
import 'package:hackon/helper/constants.dart';
import 'package:hackon/widgets/widget.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  Stream chatRoomsStream;

  @override
  Widget chatRoomList() {
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(height: 10,),
                        ChatRoomTile(
                            snapshot.data.documents[index].data["chatroomid"]
                                .toString()
                                .replaceAll("_", "")
                                .replaceAll(Constants.myName, ""),
                            snapshot.data.documents[index].data["chatroomid"]),
                      ],
                    );
                  })
              : Container();
        });
  }

  void initState() {
    getUserInfo();
    setState(() {});
    super.initState();
  }

  getUserInfo() async {
    dataBaseMethods.getChatRooms(Constants.myName).then((value) {
      chatRoomsStream = value;
    });
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    setState(() {});
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
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoom;
  ChatRoomTile(this.userName, this.chatRoom);
  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 20,),
            Container(

              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                "${userName.substring(0, 1)}",
                style: simpleTextStyle(),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              userName,
              style: simpleTextStyle(),
            )
          ],
        ),
      ),
    );
  }
}
