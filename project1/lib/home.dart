import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                  height: 200,
                  width: 200,
                  child: Image.file(File(_imageFileList![0].path))),
            ),
            Expanded(
                child: Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _onImageButtonPressed(ImageSource.camera);
                        });
                      },
                      child: Text("Take Selfie"),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _onImageButtonPressed(ImageSource.gallery);
                            });
                          },
                          child: Text("Gallery")))
                ],
              ),
            ))
          ],
        ),
      ),
    ));
  }

  // void _getFromGallery() async {
  //   final pickedFile = await _picker.pickImage(
  //     source: source,
  //     maxWidth: maxWidth,
  //     maxHeight: maxHeight,
  //     imageQuality: quality,
  //   );
  //   setState(() {
  //     _imageFile = pickedFile;
  //   });
  // }

  void _onImageButtonPressed(
    ImageSource source,
  ) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }
}
