import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackon/services/database.dart';
import 'package:hackon/views/search.dart';
import 'package:hackon/widgets/widget.dart';
import 'package:hackon/helper/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file/file.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  TextEditingController message = new TextEditingController();
  Stream <QuerySnapshot> chatMessageStream;

  Widget ChatMessageList() {
    return StreamBuilder(
        stream: chatMessageStream,
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                      snapshot.data.documents[index].data["message"],
                      snapshot.data.documents[index].data["sendBy"] ==
                          Constants.myName,
                    );
                  })
              : Container();
        });
  }

  sendMessage() {
    if (message.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": message.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      dataBaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      setState(() {
        message.text = "";
      });

    }
  }

//  howAttachmentBottomSheet(context){
//    showModalBottomSheet(
//        context: context,
//        builder: (BuildContext bc){
//          return Container(
//            child:  Wrap(
//              children: <Widget>[
//                ListTile(
//                    leading:  Icon(Icons.image),
//                    title:  Text('Image'),
//                    onTap: () => showFilePicker(FileType.image)
//                ),
//                ListTile(
//                    leading:  Icon(Icons.videocam),
//                    title:  Text('Video'),
//                    onTap: () => showFilePicker(FileType.video)
//                ),
//                ListTile(
//                  leading:  Icon(Icons.insert_drive_file),
//                  title:  Text('File'),
//                  onTap: () => showFilePicker(FileType.any),
//                ),
//              ],
//            ),
//          );
//        }
//    );
//  }

  @override
  void initState() {
    dataBaseMethods
        .getConversationMessages(widget.chatRoomId)
        .then((value) {
          setState(() {
            chatMessageStream = value;
          });
    } );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          toolbarHeight: 65,
          title: Text(widget.chatRoomId.toUpperCase()),
        ),
        body: Container(

          child: Stack(

            children: [
              //SizedBox(height: 8,),
              ChatMessageList(),
              Container(
                alignment: Alignment.bottomCenter,
                color: Color(0x54FFFFFF),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(

                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.white,
                          controller: message,
                          style: simpleTextStyle(),
                          decoration: InputDecoration(
                            hintText: "Message",
                            hintStyle: simpleTextStyle(),
                            border: InputBorder.none,
                          )),
                    ),
                    SizedBox(width: 16,),
//                  GestureDetector(
//                    onTap: () => sendMessage(),
//                    child: Container(
//                      decoration: BoxDecoration(
//                          color: Colors.grey,
//                          gradient: LinearGradient(
//                              colors: [
//                                const Color(0x36FFFFFF),
//                                const Color(0x0FFFFFFF)
//                              ],
//                              begin: FractionalOffset.topLeft,
//                              end: FractionalOffset.bottomRight),
//                          borderRadius: BorderRadius.circular(40)),
//                      padding: EdgeInsets.all(12),
//                      child: Icon(Icons.attach_file, color: Colors.white),
//                    ),
//                  ),
                    GestureDetector(
                      onTap: () => sendMessage(),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0x36FFFFFF),
                                  const Color(0x0FFFFFFF)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                            borderRadius: BorderRadius.circular(40)),
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.send, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final isSentByMe;
  MessageTile(this.message, this.isSentByMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSentByMe? 0: 24, right: isSentByMe? 24: 0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSentByMe
                ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                : [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)],
          ),
          borderRadius: !isSentByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23))
              : BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23),
                ),
        ),
        child:
            Text(message, style:
            TextStyle(color: Colors.black, fontSize: 18)),
      ),
    );
  }
}
