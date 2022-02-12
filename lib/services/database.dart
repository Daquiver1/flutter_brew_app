import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

	final String? uid;
	DatabaseService({ this.uid }); // Constructor for databaseservice

	// Collection reference
	final CollectionReference brewCollection = FirebaseFirestore.instance.collection("brews");

	Future updateUserData(String sugars, String name, int strength) async {
		return await brewCollection.doc(uid).set({
			'sugars': sugars,
			'name': name,
			'strength': strength,
			});
	}

	// Get brew stream
	Stream<QuerySnapshot?> get brews {
		return brewCollection.snapshots();
	}

}