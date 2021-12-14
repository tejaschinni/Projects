import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Edit extends StatefulWidget {
  XFile image;
  Edit(this.image);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Photo'),
      ),
    );
  }
}
