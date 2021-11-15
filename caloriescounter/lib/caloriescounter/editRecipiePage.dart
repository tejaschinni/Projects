import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class EditRecipiePage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  var refrenceID;
  var recipes;
  DateTime selectedDate;
  EditRecipiePage(this.gUser, this.recipes, this.refrenceID, this.selectedDate,
      this.signOut);

  @override
  _EditRecipiePageState createState() => _EditRecipiePageState();
}

class _EditRecipiePageState extends State<EditRecipiePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
