import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_app/models/MyUser.dart';

class AuthService {

	final FirebaseAuth _auth = FirebaseAuth.instance;

	// Create user obj based on FirebaseUser
	MyUser? _userFromFirebaseUser(User user) {
		return user != null ? MyUser(uid: user.uid) : null;
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

	// Register with email & password

	// Sign out


}