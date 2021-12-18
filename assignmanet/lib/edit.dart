import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Edit extends StatefulWidget {
  XFile image;
  Edit(this.image);

  @override
  _EditState createState() => _EditState();
}

enum AppState {
  free,
  picked,
  cropped,
}
enum AppState1 {
  rotate,
}

class _EditState extends State<Edit> {
  late File _image;
  XFile? _image1;
  late AppState state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    state = AppState.free;
    _image = File(widget.image.path);
    // widget.image = _image as XFile;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Edit Photo'),
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    child: Image.file(File(_image.path)),
                  ),
                ),
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _cropImage();
                        });
                      },
                      child: Text('Crop')),
                ),
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _cropImage();
                        });
                      },
                      child: Text('Rotate')),
                ),
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          saveImg();
                        });
                      },
                      child: Text('Save')),
                ),
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          unadoImg();
                        });
                      },
                      child: Text('Undo')),
                ),
              ],
            ),
          )),
    );
  }

  Future<Null> _cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.original,
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
      _image = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  void unadoImg() {
    setState(() {
      _image = File(widget.image.path);
    });
  }

  void saveImg() async {
    File recordedImage = _image;
    GallerySaver.saveImage(recordedImage.path);
  }
}
