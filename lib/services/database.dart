import 'package:brew_app/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_app/models/MyUser.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid}); // Constructor for databaseservice

  // Collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brews");

  // Update user data
  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // Brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.get("name") ?? "",
          strength: doc.get("strength") ?? 0,
          sugars: doc.get("sugars") ?? "0");
    }).toList();
  }

  // Convert user doc to user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.get("name"),
        sugars: snapshot.get("sugars"),
        strength: snapshot.get("strength"));
  }

  // Get brew stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // Get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
