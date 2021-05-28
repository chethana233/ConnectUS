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



  addConversationMessages(String chatRoomId, messageMap) {
  Firestore.instance
      .collection("ChatRoom")
      .document(chatRoomId)
      .collection("chats")
      .add(messageMap);
  }

  getChatRooms(String userName) async{
    return await Firestore.instance.collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots()
    ;
  }
}
