import 'package:caloriescounter/caloriescounter/setGoal.dart';
import 'package:caloriescounter/caloriescounter/userRegisterPage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  ProfilePage(this.gUser, this.signOut);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController userNameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weigthController = TextEditingController();

  bool isWorking = true;
  int weigth = 0, age = 0;
  double height = 0.0, vval = 0.5;
  double todaycal = 1700, today = 0.0;
  double _bmi = 0, _bmr = 0;
  double defceintWegiht = 0.0, temp = 0.0, requreBmr = 0.0;

  String bmi = '0';
  double bmr = 0.0;
  double _bmichange = 0.0;
  String name = '', gender = '';
  Timestamp startTimestamp = Timestamp.now();
  late DateTime dob;
  int selectedRadio = 0;
  int selectedRadioTile = 0;
  DateTime startDateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final date2 =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  int _value = 0;
  bool _isEnable_weight = false;
  bool _isEnable_height = false;
  double d = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // heightController.text = height.toString();
    // userNameController.text = name;
    // weigthController.text = weigth.toString();
    setState(() {
      _value = 1;
      selectedRadio = 0;
      selectedRadioTile = 0;
    });
    _readUserdetails();
    _read();
    _readUser();
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      if (val == 1) {
        temp = 7000 * 2;
        print('temp value ' + temp.toString());

        defceintWegiht = temp / 7;

        requreBmr = _bmr - defceintWegiht;
        print('Deficent Weight ' + requreBmr.toString());
      } else if (val == 2) {
        temp = 7000 * 2;
        print('temp value ' + temp.toString());

        defceintWegiht = temp / 15;

        requreBmr = _bmr - defceintWegiht;
        print('Deficent Weight ' + requreBmr.toString());
      } else {
        print('----------------');
      }
    });
  }

  void _readUser() {
    FirebaseFirestore.instance
        .collection("caloriecounter")
        .doc(widget.gUser.email.toString())
        .get()
        .then((value) {
      if (value.data() == null) {
        setState(() {
          isWorking = false;
        });
        Get.off(UserRegisterPage(widget.gUser, widget.signOut));
      }
    });
  }

  Map<String, double> dataMap = {
    "SetBMR": 3,
    "Total calories": 3,
  };
  List<Color> colorList = [
    Colors.red,
    Colors.green,
  ];

  void calculate() async {
    setState(() {
      bmi = (weigth / height).toString();
      var heigthcm = (height * 30.48);
      print(heigthcm);
      //  print(bmi.toString().substring(0, 5));
      if (bmi.contains('.')) {
        bmi = bmi.toString();

        // bmr = bmr.toString();
      }
      var difference =
          (date2.difference(startDateTime).inDays / 365).floor().toString();

      print(difference);

      if (gender == "Male") {
        bmr = (66.47 +
            (13.75 * weigth) +
            (5.003 * heigthcm) -
            (6.755 * int.parse(difference)));
        //  bmr = _bmr.toString();
        print('________bmr_____MAle___' + bmr.toString());
      } else if (gender == "Female") {
        bmr = (655.1 +
            (9.563 * weigth) +
            (1.85 * heigthcm) -
            (4.676 * int.parse(difference)));
        //  bmr = _bmr.toString();
        print('________bmr_____Female___' + bmr.toString());
      }
      //BMR for Women = 655.1 + (9.563 * weight [kg]) + (1.85 * size [cm]) − (4.676 * age [years])
    });
  }

  void _readUserdetails() async {
    setState(() {
      FirebaseFirestore.instance
          .collection("caloriecounter")
          .doc(widget.gUser.email.toString())
          .get()
          .then((DocumentSnapshot value) {
        setState(() {
          name = value["name"].toString();
          weigth = value["weigth"];
          height = value["height"];
          gender = value["gender"];
          _bmi = double.parse(value["bmi"].toString());
          _bmr = double.parse(value["bmr"].toString());
          Timestamp t = value["DOB"];
          startDateTime =
              DateTime.fromMicrosecondsSinceEpoch(t.microsecondsSinceEpoch);

          userNameController.text = name;
          heightController.text = height.toString();
          weigthController.text = weigth.toString();
          bmi = _bmi.toString();
          bmr = _bmr;
        });
        // calculate();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       print('-------' + name);
      //       print('weight---------' + weigth.toString());
      //       print('height---------' + height.toString());
      //       print('______bmr-' + _bmi.toString());
      //     });
      //   },
      // ),
      body: SafeArea(
        child: DelayedDisplay(
          delay: Duration(seconds: 1),
          child: Container(
            child: Column(
              children: [
                Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: InkWell(
                                      child: Icon(Icons.arrow_back),
                                      onTap: () {
                                        setState(() {
                                          Get.back();
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  Container(
                                    child: Text(
                                      'User Profile ',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.46,
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: FaIcon(FontAwesomeIcons.home),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                leading: Icon(
                                  Icons.person_outline,
                                  color: Colors.black,
                                ),
                                title: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(name),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                leading: Icon(Icons.height_outlined),
                                title: Container(
                                  child: TextField(
                                    enabled: _isEnable_height,
                                    controller: heightController,
                                    onChanged: (String val) {
                                      setState(() {
                                        height = double.parse(val);
                                        print(val);
                                      });
                                      calculate();
                                    },
                                    decoration: InputDecoration(
                                        hintText: 'Heignt',
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(29))),
                                  ),
                                ),
                                trailing: Container(
                                  child: InkWell(
                                    child: Icon(_isEnable_height
                                        ? Icons.edit
                                        : Icons.edit_off),
                                    onTap: () {
                                      setState(() {
                                        _isEnable_height = !_isEnable_height;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                leading: Icon(
                                  Icons.monitor_weight_outlined,
                                  color: Colors.black,
                                ),
                                title: Container(
                                  child: TextField(
                                    enabled: _isEnable_weight,
                                    controller: weigthController,
                                    onChanged: (String val) {
                                      setState(() {
                                        weigth = int.parse(val);
                                      });
                                      calculate();
                                    },
                                    decoration: InputDecoration(
                                        hintText: 'Weight',
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(29))),
                                  ),
                                ),
                                trailing: Container(
                                  child: InkWell(
                                    child: Icon(_isEnable_weight
                                        ? Icons.edit
                                        : Icons.edit_off),
                                    onTap: () {
                                      setState(() {
                                        _isEnable_weight = !_isEnable_weight;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                leading: Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.black,
                                ),
                                title: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(startDateTime.day.toString() +
                                      '-' +
                                      startDateTime.month.toString() +
                                      '-' +
                                      startDateTime.year.toString()),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                leading: Icon(
                                  Icons.person_outline,
                                  color: Colors.black,
                                ),
                                title: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(gender),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                leading: Text('BMR'),
                                title: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(bmr.floor().toString()),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                leading: Text('BMI'),
                                title: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(bmi.toString()),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: LinearProgressIndicator(
                                backgroundColor: Colors.red,
                                value: d,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    getIndigatorColor(d)),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    child: Container(
                  child: Stack(
                    children: [
                      Positioned(child: Container()),
                      Positioned(
                        bottom: -10,
                        left: 10,
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: Image.asset(
                            'assets/image3.png',
                            height: MediaQuery.of(context).size.height * 0.12,
                            width: MediaQuery.of(context).size.width * 0.12,
                            //scale: 0.1,
                            fit: BoxFit.fill,
                            alignment: Alignment.bottomLeft,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        left: 70,
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: Image.asset(
                            'assets/image2.png',
                            height: MediaQuery.of(context).size.height * 0.12,
                            width: MediaQuery.of(context).size.width * 0.12,
                            //scale: 0.1,
                            fit: BoxFit.fill,
                            alignment: Alignment.bottomLeft,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        left: 120,
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: Image.asset(
                            'assets/image1.png',
                            height: MediaQuery.of(context).size.height * 0.12,
                            width: MediaQuery.of(context).size.width * 0.12,
                            //scale: 0.1,
                            fit: BoxFit.fill,
                            alignment: Alignment.bottomLeft,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        left: 170,
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: Image.asset(
                            'assets/image4.png',
                            height: MediaQuery.of(context).size.height * 0.12,
                            width: MediaQuery.of(context).size.width * 0.12,
                            //scale: 0.1,
                            fit: BoxFit.fill,
                            alignment: Alignment.bottomLeft,
                          ),
                        ),
                      ),
                      SizedBox(),
                      Positioned(
                        bottom: 20,
                        left: 230,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              // calculate();
                              print(
                                  '===============================================');
                              // updateuserData();
                            });
                          },
                          child: Text('Update'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.indigo.shade700,
                            //onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 320,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              Get.to(
                                  () => SetGoal(widget.gUser, widget.signOut));
                            });
                          },
                          child: Text('SetGoal'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.indigo.shade700,
                            //minimumSize: Size(70, 50),
                            //onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore
          .collection('caloriecounter')
          .doc(widget.gUser.email)
          .get();
      setState(() {
        startTimestamp = (documentSnapshot.data() as dynamic)['DOB'];
        startDateTime = DateTime.fromMicrosecondsSinceEpoch(
            startTimestamp.microsecondsSinceEpoch);
      });
    } catch (e) {
      print(e);
    }
  }

  Color getIndigatorColor(double d) {
    if (d > .1 && d < .5) {
      return Colors.red;
    } else if (d > 0.5 && d < 0.7) {
      return Colors.yellow;
    } else if (d > 0.7 && d < 1) {
      return Colors.green;
    }
    return Colors.grey;
  }

  double getBMRratio() {
    return d = todaycal / bmr;
  }

  void updateuserData() {
    FirebaseFirestore.instance
        .collection('caloriecounter')
        .doc(widget.gUser.email)
        .update({
      'bmi': double.parse(bmi.toString()).floor(),
      'bmr': double.parse(bmr.toString()).floor(),
    });
  }
}
