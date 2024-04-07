import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unimatch/models/message_model.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; //firestore instance
  final FirebaseAuth _auth = FirebaseAuth.instance; //firebaseAuth instance

  //get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String receiverId, message) async { 
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    MessageModel newMessage = MessageModel(
      senderId: currentUserId, 
      senderEmail: currentUserEmail, 
      receiverId: receiverId, 
      message: message, 
      timestamp: timestamp);

    List<String> ids = [currentUserId, receiverId];
    ids.sort(); //ensure that the chatRoomId is the same for any two people
    String chatRoomId = ids.join('_');

    await _firestore.collection("chat_rooms").doc(chatRoomId).collection("messages").add(newMessage.toMap()); //add a new message to firestore
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore.collection("chat_rooms").doc(chatRoomId).collection("messages").orderBy("timestamp", descending: false).snapshots();
  }
}