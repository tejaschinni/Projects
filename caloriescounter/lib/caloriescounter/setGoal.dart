import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:numberpicker/numberpicker.dart';

class SetGoal extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  SetGoal(this.gUser, this.signOut);

  @override
  _SetGoalState createState() => _SetGoalState();
}

class _SetGoalState extends State<SetGoal> {
  int _currentValue = 3;
  int _weightValue = 1;
  int _daysValue = 1;
  bool isWorking = true;
  int weigth = 0, age = 0;
  double height = 0.0, vval = 0.5;
  double todaycal = 1700, today = 0.0;
  double _bmi = 0, _bmr = 0;
  double defceintWegiht = 0.0, temp = 0.0, requreBmr = 0.0;
  DateTime startDateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final date2 =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String bmi = '0';
  double bmr = 0.0;
  String name = '', gender = '';
  String goal = " ", exercise = " ";

  String goalvalue = 'Loss Weight';

  var goaloption = [
    'Loss Weight',
    'Gain weight',
  ];

  String exercisevalue = 'No Exercise';

  var exerciseoption = [
    'No Exercise',
    '2-3 Days Exercies',
    'Daily Exercies',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readUserdetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Goal'),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Goal'),
              trailing: DropdownButton(
                value: goalvalue,
                icon: Icon(Icons.keyboard_arrow_down),
                items: goaloption.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    goalvalue = value.toString();
                    goal = goalvalue;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text('Exercise'),
              trailing: DropdownButton(
                value: exercisevalue,
                icon: Icon(Icons.keyboard_arrow_down),
                items: exerciseoption.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    exercisevalue = value.toString();
                    exercise = exercisevalue;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Weight'),
            Container(
              child: NumberPicker(
                value: _weightValue,
                minValue: 1,
                maxValue: 100,
                onChanged: (value) => setState(() => _weightValue = value),
              ),
            ),
            Text('Current value: $_weightValue'),
            SizedBox(
              height: 20,
            ),
            Text('Days'),
            Container(
              child: NumberPicker(
                value: _daysValue,
                minValue: 1,
                maxValue: 100,
                onChanged: (value) => setState(() => _daysValue = value),
              ),
            ),
            Text('Current value: ' + _daysValue.toString()),
            SizedBox(
              height: 10,
            ),
            Text('Set Goal: ' + requreBmr.floor().toString()),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //setgoal();
          setgoal1();
          userUpdate();
          Get.back();
        },
      ),
    );
  }

  void setgoal1() {
    setState(() {
      if (goalvalue == 'Loss Weight') {
        if (exercisevalue == 'No Exercise') {
          temp = 7000 * _weightValue.toDouble();
          defceintWegiht = temp / _daysValue;
          requreBmr = _bmr - defceintWegiht;
        } else if (exercisevalue == '2-3 Days Exercies') {
          temp = 3500 * _weightValue.toDouble();
          defceintWegiht = temp / _daysValue;
          requreBmr = _bmr - defceintWegiht;
        } else if (exercisevalue == 'Daily Exercies') {
          temp = 2100 * _weightValue.toDouble();
          defceintWegiht = temp / _daysValue;
          requreBmr = _bmr - defceintWegiht;
        } else {
          print("not Selected");
        }
      } else if (goalvalue == 'Gain weight') {
        if (exercisevalue == 'No Exercise') {
          temp = 7000 * _weightValue.toDouble();
          defceintWegiht = temp / _daysValue;
          requreBmr = _bmr + defceintWegiht;
        } else if (exercisevalue == '2-3 Days Exercies') {
          temp = 3500 * _weightValue.toDouble();
          defceintWegiht = temp / _daysValue;
          requreBmr = _bmr + defceintWegiht;
        } else if (exercisevalue == 'Daily Exercies') {
          temp = 2100 * _weightValue.toDouble();
          defceintWegiht = temp / _daysValue;
          requreBmr = _bmr + defceintWegiht;
        } else {
          print("not Selected");
        }
      }
    });
  }

  void setgoal() {
    setState(() {
      if (goal == 'Loss Weight') {
        if (exercise == 'No activity') {
          temp = 7000 * _weightValue.toDouble();
          defceintWegiht = temp / _daysValue;
          requreBmr = _bmr - defceintWegiht;
        } else if (exercise == '2-3 days exercise') {
          temp = 3500 * _weightValue.toDouble();
          defceintWegiht = temp / _daysValue;
          requreBmr = _bmr - defceintWegiht;
        } else if (exercise == 'Daily exercise') {
          temp = 2100 * _weightValue.toDouble();
          defceintWegiht = temp / _daysValue;
          requreBmr = _bmr - defceintWegiht;
        } else {
          print('not selected');
        }
      } else if (goal == 'Gain Weight') {
        if (exercise == 'No activity') {
          temp = 7000 * _weightValue.toDouble();
          defceintWegiht = temp / _daysValue;
          requreBmr = _bmr + defceintWegiht;
        } else if (exercise == '2-3 days exercise') {
          temp = 3500 * _weightValue.toDouble();
          defceintWegiht = temp / _daysValue;
          requreBmr = _bmr + defceintWegiht;
        } else if (exercise == 'Daily exercise') {
          temp = 2100 * _weightValue.toDouble();
          defceintWegiht = temp / _daysValue;
          requreBmr = _bmr + defceintWegiht;
        } else {
          print('not selected');
        }
      } else {
        print('not selected');
      }
    });
  }

  void dayselect(context) {
    BuildContext dialogContext;
    showDialog(
      context: context, // <<----
      barrierDismissible: false,
      builder: (BuildContext context) {
        dialogContext = context;
        return Dialog(
          child: Container(
            child: NumberPicker(
              value: _weightValue,
              minValue: 1,
              maxValue: 100,
              onChanged: (value) => setweight(value),
            ),
          ),
        );
      },
    );
  }

  void setweight(value) {
    setState(() {
      _weightValue = value;
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

  CollectionReference collection =
      FirebaseFirestore.instance.collection('caloriecounter');

  Future<void> userUpdate() async {
    collection.doc(widget.gUser.email).update({
      'setgoal': requreBmr,
    });
  }
}
