import 'package:brew_app/screens/home/home.dart';
import 'package:brew_app/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		// Return either Home or Authenticate widget
		return Authenticate();
	}
}
