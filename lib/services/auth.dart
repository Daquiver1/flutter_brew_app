import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

	final FirebaseAuth _auth = FirebaseAuth.instance;

	// Sign in anon
	Future signInAnon() async {
		try {
			UserCredential user = await _auth.signInAnonymously();
			return user;
		} catch (err) {
			print(err.toString());
			return null;
		}
	}

	// Sign in with email & password

	// Register with email & password

	// Sign out


}