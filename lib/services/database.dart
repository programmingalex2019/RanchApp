import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:the_ranch_app/models/memory_models/memory_model.dart';
import 'package:the_ranch_app/models/ranch_user.dart';
import 'package:the_ranch_app/services/auth.dart';

class Database {
  final Firestore _firestore = Firestore.instance;
  AuthBase auth = Auth();

  Stream<RanchUser> getUserData(String uid) {
    return _firestore
        .collection('RanchMembers')
        .document('$uid')
        .snapshots()
        .map((snap) => RanchUser.getUserProfile(snap.data, uid));
  }

  Future<List<RanchUser>> getRanchMembers() async {
    var data = await _firestore.collection('RanchMembers').getDocuments();
    // gets all the data
    return data.documents
        .map((doc) => RanchUser.getUserProfile(doc.data, ''))
        .toList();
  }

  Stream<List<RanchUser>> get ranchMembersStream {
    return _firestore.collection('RanchMembers').snapshots().map((event) =>
        event.documents.map((e) => RanchUser.getUserProfile(e.data, '')));
  }

  Stream<List<MemoryModel>> get getMemories {
    return _firestore
        .collection('RanchMemories')
        .orderBy('timeStamp', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((e) => MemoryModel.fromJson(e.data))
            .toList());
  }

  Stream<DocumentSnapshot> currentUserImage(String uid) {
    return Firestore.instance
        .collection('RanchMembers')
        .document('$uid')
        .snapshots();
  }

  Future<void> updateUserData({Map<String, dynamic> data}) async {
    String uid = await auth.currentUser.then((currentUser) => currentUser.uid);

    _firestore
        .collection('RanchMembers')
        .document('$uid')
        .updateData(data)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addPathToDatabase() async {
    try {
      //current Uid of the user
      String uid =
          await auth.currentUser.then((currentUser) => currentUser.uid);
      // Get image URL from firebase
      final ref = FirebaseStorage().ref().child('images/$uid.png');
      var imageString = await ref.getDownloadURL();
      // Add location and url to database

      await Firestore.instance
          .collection('RanchMembers')
          .document(uid)
          .setData({'profileImage': imageString}, merge: true);
    } catch (e) {
      print(e.message);
    }
  }

  // Memories

  Future<void> addMemory(
      String description, filePath, RanchUser ranchUser) async {
    try {
      final ref = FirebaseStorage().ref().child(filePath);
      var imageString = await ref.getDownloadURL();

      String uid =
          await auth.currentUser.then((currentUser) => currentUser.uid);

      print(imageString);

      MemoryModel memoryModel = MemoryModel(
          description: description,
          timeStamp: DateTime.now().toString(),
          id: uid,
          image: imageString,
          addedBy: ranchUser.name);

      await Firestore.instance
          .collection('RanchMemories')
          .add(memoryModel.toJson());
    } catch (e) {
      print(e.toString());
    }
  }
}
