import 'package:flutter/cupertino.dart';
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
  TextEditingController groupName = new TextEditingController();
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

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      color: Colors.black54,
      child: Text("CANCEL"),
      onPressed: () {
        setState(() {
          groupName.text = "";
        });
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      color: Colors.black54,
      child: Text("OK"),
      onPressed: () {
        addNewGroup();
        setState(() {
          groupName.text = "";
        });

        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //backgroundColor: Colors.white,
      title: Text("Yayy! Create your new group now"),
      content: Container(
          color: Colors.black54,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            TextField(
                controller: groupName,
                style: simpleTextStyle(),
                decoration: InputDecoration(
                  hintText: "Enter a Group Name",
                  hintStyle: TextStyle(color: Colors.grey),
                )),
          ])),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  addNewGroup() {
    String groupId = groupName.text;
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
    getMyGroups();
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
        backgroundColor: Colors.black54,
        toolbarHeight: 80,
        title: Text("Hobby Groups",style: TextStyle(fontFamily: 'Pacifico'),),
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(padding: EdgeInsets.symmetric(horizontal: 16)),
            //child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Images/HobbyGroup.jpeg"),
                fit: BoxFit.cover),
          ),
          child: allGroupsList()),
      floatingActionButton: FloatingActionButton(
          materialTapTargetSize: MaterialTapTargetSize.padded,
          backgroundColor: Colors.black54,
          child: Icon(
            Icons.add,
            size: 35,
          ),
          onPressed: () {
            showAlertDialog(context);
          }),
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
                    "${chatRoom.substring(0, 1)}",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  chatRoom.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      color: Colors.black),
                ),
              ],
            ),
            Text("___________________________________",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: Colors.black26))
          ],
        ),
      ),
    );
  }
}
