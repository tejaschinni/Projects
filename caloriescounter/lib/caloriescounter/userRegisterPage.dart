import 'package:caloriescounter/signInPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRegisterPage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  //DateTime selectedDate;

  UserRegisterPage(this.gUser, this.signOut);
  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weigthController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String name = '';
  int weigth = 0;
  int age = 0;
  double height = 0.0;
  double todaycal = 1700;
  String bmi = '0';
  var bmr = '';
  String gender = 'Male';

  var item = [
    'Male',
    'Female',
  ];

  Timestamp startTimestamp = Timestamp.now();
  DateTime startDateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final date2 =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  bool validator = true;
  DateTime dateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  // DateTime selectedDate = DateTime.now();

  CollectionReference collection =
      FirebaseFirestore.instance.collection('caloriecounter');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // userNameController.text = widget.userData.name.toString();
      // weigthController.text = widget.userData.weigth.toString();
      // mobileController.text = widget.userData.mobile.toString();
      _read();
    });

    print(widget.gUser.email.toString());
  }

  void validate() {
    if (userNameController.text.length > 2) {
      print('----------------true');
    } else {
      print('----------------false');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple[900],
        onPressed: () {
          setState(() {
            calculate();
          });
          userDetail();

          print("------------date " +
              dateTime.toString() +
              '-------------' +
              gender);
        },
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
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
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Container(
                                child: Text(
                                  'User Register ',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.44,
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
                            title: TextField(
                              controller: userNameController,
                              onChanged: (String val) {
                                setState(() {
                                  name = val;
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: 'UserName',
                                  // prefixIcon: Icon(
                                  //   Icons.person_outline,
                                  //   color: Colors.black,
                                  // ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(29))),
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
                            title: Text(gender),
                            trailing: DropdownButton(
                              value: gender,
                              icon: Icon(Icons.keyboard_arrow_down),
                              items: item.map((String gender) {
                                return DropdownMenuItem(
                                    value: gender, child: Text(gender));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                });
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: ListTile(
                            leading: Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.black,
                            ),
                            title: Text(
                              dateTime.day.toString() +
                                  '/' +
                                  dateTime.month.toString() +
                                  '/' +
                                  dateTime.year.toString(),
                            ),
                            trailing: Container(
                              child: InkWell(
                                child: Icon(Icons.calendar_view_month),
                                onTap: () {
                                  dateBOD();
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
                            title: TextField(
                              controller: weigthController,
                              onChanged: (String val) {
                                setState(() {
                                  weigth = int.parse(val);
                                });
                              },
                              decoration: InputDecoration(
                                  suffixIcon: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.orangeAccent,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text("KG"),
                                  ),
                                  hintText: 'Your Wieght',
                                  // prefixIcon: Icon(
                                  //   Icons.person_outline,
                                  //   color: Colors.black,
                                  // ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(29))),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: ListTile(
                            leading: Icon(
                              Icons.height_outlined,
                              color: Colors.black,
                            ),
                            title: TextField(
                              controller: heightController,
                              onChanged: (String val) {
                                setState(() {
                                  height = double.parse(val);
                                });
                              },
                              decoration: InputDecoration(
                                  suffixIcon: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.orangeAccent,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text("CM"),
                                  ),
                                  hintText: 'Your Height',
                                  // prefixIcon: Icon(
                                  //   Icons.person_outline,
                                  //   color: Colors.black,
                                  // ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(29))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  child: Container(
                child: Stack(
                  children: [
                    Positioned(child: Container()),
                    Positioned(
                      bottom: -10,
                      left: 20,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Image.asset(
                          'assets/image3.png',
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.15,
                          //scale: 0.1,
                          fit: BoxFit.fill,
                          alignment: Alignment.bottomLeft,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 90,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Image.asset(
                          'assets/image2.png',
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.15,
                          //scale: 0.1,
                          fit: BoxFit.fill,
                          alignment: Alignment.bottomLeft,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 150,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Image.asset(
                          'assets/image1.png',
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.15,
                          //scale: 0.1,
                          fit: BoxFit.fill,
                          alignment: Alignment.bottomLeft,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 220,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Image.asset(
                          'assets/image4.png',
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.15,
                          //scale: 0.1,
                          fit: BoxFit.fill,
                          alignment: Alignment.bottomLeft,
                        ),
                      ),
                    ),
                    SizedBox(),
                    // Positioned(
                    //   bottom: 20,
                    //   left: 230,
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       setState(() {
                    //         Get.back();
                    //       });
                    //     },
                    //     child: Text('Update'),
                    //     style: ElevatedButton.styleFrom(
                    //       primary: Colors.indigo.shade700,
                    //       //onPrimary: Colors.white,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(32.0),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   bottom: 20,
                    //   left: 320,
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       setState(() {
                    //         // Get.to(
                    //         //     () => SetGoal(widget.gUser, widget.signOut));
                    //       });
                    //     },
                    //     child: Text('SetGoal'),
                    //     style: ElevatedButton.styleFrom(
                    //       primary: Colors.indigo.shade700,
                    //       //minimumSize: Size(70, 50),
                    //       //onPrimary: Colors.white,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(32.0),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  void calculate() async {
    setState(() {
      bmi = (weigth / height).toString();
      var heigthcm = (height * 30.48);
      print(heigthcm);
      //  print(bmi.toString().substring(0, 5));
      if (bmi.contains('.')) {
        bmi = bmi.toString();
        bmr = bmr.toString();
      }
      var difference =
          (date2.difference(startDateTime).inDays / 365).floor().toString();

      print(difference);

      if (gender == "Male") {
        var _bmr = (66.47 +
            (13.75 * weigth) +
            (5.003 * heigthcm) -
            (6.755 * int.parse(difference)));
        bmr = _bmr.toString();
        print('________bmr________' + bmr.toString());
      } else if (gender == "Female") {
        var _bmr = (655.1 +
            (9.563 * weigth) +
            (1.85 * heigthcm) -
            (4.676 * int.parse(difference)));
        bmr = _bmr.toString();
        print('________bmr________' + bmr.toString());
      }
      //BMR for Women = 655.1 + (9.563 * weight [kg]) + (1.85 * size [cm]) − (4.676 * age [years])
    });
  }

  void dateBOD() async {
    final DateTime? _date = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1, 1, 1900),
        lastDate: DateTime.now());
    if (_date != null && _date != dateTime)
      setState(() {
        dateTime = _date;
      });
    print('-=================' + dateTime.toString());
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

  void dateselect(context) {
    BuildContext dialogContext;
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1, 1, 1900),
        lastDate: DateTime(1, 1, 2030));
  }

  Future<void> userDetail() async {
    collection.doc(widget.gUser.email).set({
      'name': name,
      'height': height,
      'weigth': weigth,
      'joindate': DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      'DOB': dateTime,
      'bmr': double.parse(bmr).floor(),
      'setgoal': double.parse(bmr).floor(),
      'bmi': double.parse(bmi).floor(),
      'gender': gender
    });
  }
}
