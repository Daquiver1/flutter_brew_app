import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

	final FirebaseAuth _auth = FirebaseAuth.instance;

	// Sign in anon
	Future signInAnon() async {
		try {
			AuthResult result = await _auth.signInAnonymously();
			FirebaseUser user = result.user;
			return user;
		} catch (err) {
			print(e.toString());
			return null;
		}
	}

	// Sign in with email & password

	// Register with email & password

	// Sign out


}