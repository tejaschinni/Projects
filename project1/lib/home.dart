import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/edit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _HomeState extends State<Home> {
  List<XFile>? _imageFileList;
  late AppState state;
  File? imageFile;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    state = AppState.free;
  }

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
            Expanded(flex: 1, child: Container()),
            _imageFileList == null
                ? Expanded(
                    child: Container(
                    child: Text('Select image '),
                  ))
                : Expanded(
                    flex: 6,
                    child: Container(
                        child: Image.file(File(_imageFileList![0].path))),
                  ),
            Container(
              child: InkWell(
                child: Text('Edit photo'),
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Edit(_imageFileList![0])));
                  });
                },
              ),
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

  void imageCrop() async {
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: _imageFileList![0].path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
    );
  }

  Future<void> _cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: _imageFileList![0].path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      _imageFileList = croppedFile as List<XFile>?;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

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
