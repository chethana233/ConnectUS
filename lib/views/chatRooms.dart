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
        backgroundColor: Colors.black54,
        toolbarHeight: 80,
        title: Text("Direct Message",style: TextStyle(fontFamily: 'Pacifico')),
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16)),
                //child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/Images/HobbyGroup.jpeg"), fit: BoxFit.cover),
          ),
          child: chatRoomList()),
      floatingActionButton: FloatingActionButton(

        backgroundColor: Colors.black54,
        child: Container(
          height: 200,
            width: 200,
            child: Icon(Icons.search)),
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
    print(chatRoom);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(userName)));
      },
      child: Container(
        //color: Colors.grey,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          children: [
            Row(

              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Text(
                    "${userName.substring(0, 1)}",
                    style:  TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  userName,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
                ),

              ],
            ),
            Text("___________________________________",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Colors.black26))
          ],
        ),

      ),
    );
  }
}
