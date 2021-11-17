import 'package:caloriescounter/caloriescounter/setGoal.dart';
import 'package:caloriescounter/caloriescounter/userRegisterPage.dart';
import 'package:caloriescounter/demo/dropDownDemo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    heightController.text = height.toString();
    // userNameController.text = name;
    weigthController.text = weigth.toString();
    setState(() {
      _value = 1;
      selectedRadio = 0;
      selectedRadioTile = 0;
    });
    _readUserdetails();
    _read();
    // _readUser();
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

  // void _readUser() {
  //   FirebaseFirestore.instance
  //       .collection("caloriecounter")
  //       .doc(widget.gUser.email.toString())
  //       .get()
  //       .then((value) {
  //     if (value.data() == null) {
  //       setState(() {
  //         isWorking = false;
  //       });
  //       Get.off(() => UserRegisterPage(widget.gUser, widget.signOut));
  //     }
  //   });
  // }

  void chartData() {
    double tcol = _bmr;
    Map<String, double> dataMap = {
      "SetBMR": tcol,
      "Total calories": 3,
    };
    List<Color> colorList = [
      Colors.red,
      Colors.green,
    ];
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
        });
        // calculate();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            print('-------' + name);
            print('weight---------' + weigth.toString());
            print('height---------' + height.toString());
            print('______bmr-' + _bmi.toString());
          });
        },
      ),
      body: SafeArea(
        child: DelayedDisplay(
          delay: Duration(seconds: 1),
          child: Container(
            child: Column(
              children: [
                ListTile(
                  title: Text('User Name '),
                  trailing: Text(name),
                ),
                ListTile(
                  title: Text('Height '),
                  trailing: Text(height.toString()),
                ),
                ListTile(
                  title: Text('weight '),
                  trailing: Text(weigth.toString()),
                ),
                // ListTile(
                //   title: Text('Weight '),
                //   trailing: Container(
                //     width: 60,
                //     child: Row(
                //       children: [
                //         Expanded(
                //           child: TextField(
                //             controller: weigthController,
                //             onChanged: (String val) {
                //               setState(() {
                //                 val = weigth.toString();
                //               });
                //             },
                //             keyboardType: TextInputType.number,
                //             decoration: InputDecoration(
                //               border: OutlineInputBorder(),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                ListTile(
                  title: Text('BMI'),
                  trailing: Text(_bmi.floor().toString()),
                ),
                ListTile(
                  title: Text('BMR'),
                  trailing: Text(_bmr.floor().toString()),
                ),
                ListTile(
                  title: Text('DOB'),
                  trailing: Text(startDateTime.day.toString() +
                      '-' +
                      startDateTime.month.toString() +
                      '-' +
                      startDateTime.year.toString()),
                ),
                ListTile(
                  title: Text('Goal'),
                  trailing: Icon(Icons.forward),
                  onTap: () {
                    Get.to(() => SetGoal(widget.gUser, widget.signOut));
                  },
                ),
                Text(requreBmr.floor().toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _read() async {
    //print(' My email  = ' + widget.gUser.email.toString());
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
    return todaycal / bmr;
  }

  void selectGoal(int val) {
    setState(() {
      if (_value == 1) {
        print('Loss weight in 7 days');
      } else if (_value == 2) {
        print('Loss weight in 7 days');
      } else if (_value == 3) {
        print('Loss weight in 7 days');
      } else {
        print('not select');
      }
    });
  }

  void weightLossIn7Days() {
    temp = 7000 * 2;
    defceintWegiht = temp / 7;
    requreBmr = _bmr - defceintWegiht;
  }

  void weightLossIn15Days() {
    temp = 7000 * 2;
    defceintWegiht = temp / 15;
    requreBmr = _bmr - defceintWegiht;
  }

  void weightLossIn30Days() {
    temp = 7000 * 4;
    defceintWegiht = temp / 30;
    requreBmr = _bmr - defceintWegiht;
  }

  void weightGainIn7Days() {
    temp = 7000 * 2;
    defceintWegiht = temp / 7;
    requreBmr = _bmr + defceintWegiht;
  }

  void weightGainIn15Days() {
    temp = 7000 * 2;
    defceintWegiht = temp / 15;
    requreBmr = _bmr + defceintWegiht;
  }

  void weightGainIn30Days() {
    temp = 7000 * 4;
    defceintWegiht = temp / 30;
    requreBmr = _bmr + defceintWegiht;
  }
}
