import 'package:brew_app/models/MyUser.dart';
import 'package:brew_app/services/database.dart';
import 'package:brew_app/shared/constants.dart';
import 'package:brew_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ["0", "1", "2", "3", "4"];

  // form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    "Update your brew settings.",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData?.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? "Please enter a name" : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),

                  //dropdown
                  DropdownButtonFormField<String>(
                      decoration: textInputDecoration,
                      value: null,
                      //value: _currentSugars ?? userData?.sugars,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          child: Text("$sugar sugars"),
                          value: sugar,
                        );
                      }).toList(),
                      onChanged: (val) =>
                          setState(() => _currentSugars = val.toString())),
                  Slider(
                    value: (_currentStrength ?? userData?.strength)!.toDouble(),
                    activeColor:
                        Colors.brown[_currentStrength ?? userData!.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData!.strength],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugars ?? userData!.sugars,
                            _currentName ?? userData!.name,
                            _currentStrength ?? userData!.strength,
                          );
                          Navigator.pop(context);
                        }
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
