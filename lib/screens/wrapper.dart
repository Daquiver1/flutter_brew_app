import 'package:brew_app/screens/home/home.dart';
import 'package:brew_app/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_app/models/MyUser.dart';

class Wrapper extends StatelessWidget {
	@override
	Widget build(BuildContext context) {

		final user = Provider.of<MyUser?>(context);
		print(user);

		// Return either Home or Authenticate widget
		if (user == null) {
			return Authenticate();
		} else {
			return Home();
		}
	}
}
