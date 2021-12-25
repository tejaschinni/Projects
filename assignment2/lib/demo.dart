import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;

class Assignment extends StatefulWidget {
  const Assignment({Key? key}) : super(key: key);

  @override
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  String url = "https://owlbot.info/api/v4/dictionary/";
  String token = "08a5e3222b8be11a8bdcbaa455cb0f7ab1e7f608";
  TextEditingController textEditingController = TextEditingController();
  stt.SpeechToText? _speechToText;
  bool _isListening = false;
  String _text = "Press to start ";
  List<FileSystemEntity> alldata = [];

  StreamController? streamController;
  Stream? _stream;

  Timer? _debounce;

  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_speech = stt.SpeechToText();
    //initSpeechState();
    _speechToText = stt.SpeechToText();
    streamController = StreamController();
    _stream = streamController!.stream;
  }

  searchText(String text) async {
    streamController!.add("waiting");
    Response response = await http.get(Uri.parse(url + text.trim()),
        // do provide spacing after Token
        headers: {"Authorization": "Token " + token});
    streamController!.add(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PingoLearn_Round1'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onListing();
        },
        child: Icon(Icons.keyboard_voice),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: StreamBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text(_text.toString()),
              );
            }
            if (snapshot.data == "waiting") {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            // output
            return ListView.builder(
              itemCount: snapshot.data["definitions"].length,
              itemBuilder: (BuildContext context, int index) {
                return ListBody(
                  children: [
                    Container(
                      color: Colors.grey[300],
                      child: ListTile(
                        leading: snapshot.data["definitions"][index]
                                    ["image_url"] ==
                                null
                            ? CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/image_not_found.png'))
                            : CircleAvatar(
                                backgroundImage: NetworkImage(snapshot
                                    .data["definitions"][index]["image_url"]),
                              ),
                        title: Text(textEditingController.text.trim() +
                            "(" +
                            snapshot.data["definitions"][index]["type"] +
                            ")"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          snapshot.data["definitions"][index]["definition"]),
                    )
                  ],
                );
              },
            );
          },
          stream: _stream,
        ),
      ),
    );
  }

  void _onListing() async {
    if (!_isListening) {
      bool available = await _speechToText!.initialize(
          onError: (val) => print("==================" + val.toString()),
          onStatus: (val) => print("On Staust-----------" + val));
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speechToText!.listen(
            onResult: (val) => setState(() {
                  _text = val.recognizedWords;
                  searchText(_text);
                }));
      }
    } else {
      setState(() {
        _isListening = false;
        _speechToText!.stop();
      });
    }
  }
}
