import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NutritionPerDay extends StatefulWidget {
  GoogleSignInAccount gUser;
  DateTime selectedDate;

  NutritionPerDay(this.gUser, this.selectedDate);

  @override
  _NutritionPerDayState createState() => _NutritionPerDayState();
}

class _NutritionPerDayState extends State<NutritionPerDay> {
  bool flag = false;
  int tcab = 0,
      tcal = 0,
      tfat = 0,
      tgram = 0,
      tprot = 0,
      tcalories = 0,
      tempcal = 0;

  double _bmi = 0, _bmr = 0, _setgoal = 0.0;
  int weigth = 0, age = 0;
  double height = 0.0, vval = 0.0;
  String name = '', gender = '';

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime currentdate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  CollectionReference collection =
      FirebaseFirestore.instance.collection('caloriecounter');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _read();
      totalCalData();
    });

    _readUserdetails();
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
          _setgoal = double.parse(value["setgoal"].toString());
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('caloriecounter')
            .doc(widget.gUser.email)
            .collection('food')
            .doc(widget.selectedDate.toString())
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var food;

          try {
            food = snapshot.data!.data();

            setState(() {
              flag = false;
            });
          } catch (e) {
            print("NO DATA");
          }
          tempcal = food['tcalories'];

          List<PieChartSectionData> data = [
            PieChartSectionData(
                title: " ", color: Colors.greenAccent, value: 0, radius: 35),
            PieChartSectionData(
                title: "20,1 ",
                color: Colors.purple[200],
                value: _setgoal,
                radius: 40),
          ];
          List<PieChartSectionData> data1 = [
            PieChartSectionData(
                title: " ",
                color: Colors.greenAccent,
                value: tempcal.floor().toDouble(),
                radius: 35),
            PieChartSectionData(
                title: "20,1 ",
                color: Colors.purple[300],
                value: _setgoal,
                radius: 40),
          ];
          // final List<ChartData> chartData = [
          //   ChartData('Total Calories', food['tcalories']),
          //   ChartData('BMR', _setgoal),
          // ];
          // final List<ChartData> chartData1 = [
          //   ChartData('Total Calories', 0),
          //   ChartData('BMR', _setgoal),
          // ];
          // final List<ChartData> chartData2 = [
          //   ChartData('Total Calories', 0),
          //   ChartData('BMR', _setgoal),
          // ];
          _read1();
          return flag
              ? Container()
              : Center(
                  child: Container(
                      child: food['tcalories'] == 0
                          ? Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 80,
                                            child: Stack(
                                              children: [
                                                Image.asset(
                                                    'assets/calories.png'),
                                                Positioned(
                                                  left: 46,
                                                  bottom: 35,
                                                  child: Text(
                                                    '0',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ),
                                                // Positioned(
                                                //   left: 8,
                                                //   bottom: 35,
                                                //   child: Text(
                                                //     _setgoal.floor().toString(),
                                                //     style:
                                                //         TextStyle(fontSize: 10),
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('Calores',
                                              style: TextStyle(fontSize: 10))
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              height: 80,
                                              width: 80,
                                              child: Stack(
                                                children: [
                                                  Image.asset(
                                                      'assets/carbs.png'),
                                                  Positioned(
                                                    left: 48,
                                                    bottom: 30,
                                                    child: Text(
                                                      '0',
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('Carbs',
                                              style: TextStyle(fontSize: 10))
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              height: 80,
                                              width: 80,
                                              child: Stack(
                                                children: [
                                                  Image.asset('assets/fat.png'),
                                                  Positioned(
                                                    left: 45,
                                                    bottom: 30,
                                                    child: Text(
                                                      '0',
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('Fat',
                                              style: TextStyle(fontSize: 10))
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              height: 80,
                                              width: 80,
                                              child: Stack(
                                                children: [
                                                  Image.asset(
                                                      'assets/protien.png'),
                                                  Positioned(
                                                    left: 55,
                                                    bottom: 30,
                                                    child: Text(
                                                      '0',
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('Protien',
                                              style: TextStyle(fontSize: 10))
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                  // Container(
                                  //   child: LinearProgressIndicator(
                                  //     value: 10,
                                  //   ),
                                  // ),
                                ],
                              ),
                            )
                          : Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            height: 80,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: Stack(
                                              children: [
                                                Image.asset(
                                                    'assets/calories.png'),
                                                Positioned(
                                                  left: 46,
                                                  bottom: 35,
                                                  child: Text(
                                                    '0',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ),
                                                // Positioned(
                                                //   left: 8,
                                                //   bottom: 35,
                                                //   child: Text(
                                                //     _setgoal.floor().toString(),
                                                //     style:
                                                //         TextStyle(fontSize: 10),
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('Calores',
                                              style: TextStyle(fontSize: 10))
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              height: 80,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              child: Stack(
                                                children: [
                                                  Image.asset(
                                                      'assets/carbs.png'),
                                                ],
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('Carbs',
                                              style: TextStyle(fontSize: 10))
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              height: 80,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              child: Stack(
                                                children: [
                                                  Image.asset('assets/fat.png'),
                                                ],
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('Fat',
                                              style: TextStyle(fontSize: 10))
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              height: 80,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              child: Stack(
                                                children: [
                                                  Image.asset(
                                                      'assets/protien.png'),
                                                ],
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('Protien',
                                              style: TextStyle(fontSize: 10))
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                );
        },
      ),
    ));
  }

  void _read1() async {
    try {
      FirebaseFirestore.instance
          .collection('caloriecounter')
          .doc(widget.gUser.email)
          .collection('food')
          .doc(widget.selectedDate.toString())
          .collection('meals')
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isEmpty) {
          collection
              .doc(widget.gUser.email)
              .collection('food')
              .doc(widget.selectedDate.toString())
              .set({
            'tcalories': 0,
            'tcrabs': 0,
            'tfat': 0,
            'tprotiens': 0,
            'tgram': 0
          });
        } else {}
      });
    } catch (e) {
      print(e);
    }
  }

  void _read() async {
    try {
      FirebaseFirestore.instance
          .collection('caloriecounter')
          .doc(widget.gUser.email)
          .collection('food')
          .doc(widget.selectedDate.toString())
          .collection('meals')
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isEmpty) {
          collection
              .doc(widget.gUser.email)
              .collection('food')
              .doc(widget.selectedDate.toString())
              .set({
            'tcalories': 0,
            'tcrabs': 0,
            'tfat': 0,
            'tprotiens': 0,
            'tgram': 0
          });
        } else {
          querySnapshot.docs.forEach((doc) {
            tcab = 0;
            tcal = 0;
            tfat = 0;
            tgram = 0;
            tprot = 0;
            for (var item in querySnapshot.docs) {
              tcab = tcab + int.parse(item['carbon'].toString());
              tcal = tcal + int.parse(item['calories'].toString());
              tfat = tfat + int.parse(item['fats'].toString());
              tprot = tprot + int.parse(item['protiens'].toString());
              tgram = tgram + int.parse(item['grams'].toString());
            }
          });
          collection
              .doc(widget.gUser.email)
              .collection('food')
              .doc(widget.selectedDate.toString())
              .set({
            'tcalories': tcal,
            'tcrabs': tcab,
            'tfat': tfat,
            'tprotiens': tprot,
            'tgram': tgram
          });
        }

        print('Carbon Total  ' + tcab.toString());
        print('calories Total  ' + tcal.toString());
        print('fats Total  ' + tfat.toString());
        print('protiens Total  ' + tprot.toString());
      });
    } catch (e) {
      print(e);
    }
  }

  void totalCalData() {
    if (widget.selectedDate == currentdate) {
      print("Dont do change ");
    } else if (widget.selectedDate != currentdate) {
      print("Change");
      if (tcab != 0) {
        collection
            .doc(widget.gUser.email)
            .collection('food')
            .doc(widget.selectedDate.toString())
            .set({
          'tcalories': 0,
          'tcrabs': 0,
          'tfat': 0,
          'tprotiens': 0,
          'tgram': 0,
        });
      } else {
        print("dont tc chnage ");
      }
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
}

// class ChartData {
//   ChartData(
//     this.x,
//     this.y,
//   );
//   final String x;
//   final num y;
// }

class ChartData {
  ChartData(this.x, this.y, this.color, this.size);
  final String x;
  final double y;
  final Color color;
  final String size;
}
