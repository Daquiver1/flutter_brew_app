import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_app/models/MyUser.dart';
import 'package:brew_app/services/database.dart';

class AuthService {

	final FirebaseAuth _auth = FirebaseAuth.instance;

	// Create user obj based on FirebaseUser
	MyUser? _userFromFirebaseUser(User user) {
		return user != null ? MyUser(uid: user.uid) : null;
	}

	// Auth change user steam
	Stream<MyUser?> get user {
		return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user!)); 
		//same as below
		//.map(_userFromFirebaseUser);
	}


	// Sign in anon
	Future signInAnon() async {
		try {
			UserCredential result = await _auth.signInAnonymously();
			User? user = result.user;
			return _userFromFirebaseUser(user!);
		} catch (err) {
			print(err.toString());
			return null;
		}
	}

	// Sign in with email & password
	Future signInWithEmailAndPassword(String email, String password) async {
		try {
			UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
			User? user = result.user;
			return _userFromFirebaseUser(user!);

		}catch(err){
			print(err.toString());
			return null;

		} 
	}

	// Register with email & password
	Future registerWithEmailAndPassword(String email, String password) async {
		try {
			UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
			User? user = result.user;

			// create a new document for user with the uid
			await DatabaseService(uid: user?.uid).updateUserData("0", "New Crew Member", 100);
			return _userFromFirebaseUser(user!);

		}catch(err){
			print(err.toString());
			return null;
		}
	}

	// Sign out
	Future signOut() async {
	try {
		return await _auth.signOut();
		} catch(err){
			print(err.toString());
			return null;
		}
}


}