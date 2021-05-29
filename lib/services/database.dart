//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  getUsersByUserName(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  getUsersByEmail(String email) async {
    return await Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments();
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  createGroupChatRoom(String groupId, groupChatRoomMap) {
    Firestore.instance
        .collection("GroupChatRooms")
        .document(groupId)
        .setData(groupChatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  uploadUserInfo(userMap) {
    Firestore.instance.collection("users").add(userMap);
  }


  getConversationMessages(String chatRoomId) async{
    return await Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time",descending: false)
        .snapshots();
  }

  getGroupConversationMessages(String groupChatRoomId) async{
    return await Firestore.instance
        .collection("GroupChatRooms")
        .document(groupChatRoomId)
        .collection("chats")
        .orderBy("time",descending: false)
        .snapshots();
  }


  addConversationMessages(String chatRoomId, messageMap) {
  Firestore.instance
      .collection("ChatRoom")
      .document(chatRoomId)
      .collection("chats")
      .add(messageMap);
  }

  addGroupConversationMessages(String groupChatRoomId, messageMap) {
    Firestore.instance
        .collection("GroupChatRooms")
        .document(groupChatRoomId)
        .collection("chats")
        .add(messageMap);
  }

  getChatRooms(String userName) async {
    return await Firestore.instance.collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots()
    ;
  }

  getMyChatRooms(String userName) async{

  }


//  getGroupChatRooms(String userName) async{
//    QuerySnapshot querySnapshot1;
//    int index = 0;
//    return await Firestore.instance.collection("GroupChatRooms").where((querySelector) =>
//        querySelector.forEach((document) {
//          document
//          .where(document., arrayContains: userName)
//          .snapshots();
//    }
//        )
//
//    )
//
//
//        .where("participants", arrayContains: userName)
//        .snapshots()
//    ;
//  }

  getAllGroups() async {
    return await Firestore.instance.collection("GroupChatRooms")
        .snapshots();
  }


  addParticipantToGroup(String groupChatRoomName, userMap) {
    Firestore.instance
        .collection("GroupChatRooms")
        .document(groupChatRoomName)
        .collection("participants")
        .add(userMap);
  }

  getAllJobs() async
  {
    return await  Firestore.instance
        .collection("opportunities").snapshots();
  }

}
