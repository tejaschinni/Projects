import 'package:caloriescounter/signInPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          Center(
            child: InkWell(
              child: Icon(Icons.person),
              onTap: () {
                widget.signOut();
                Get.off(() => SignInPage());
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Container(
              //   child: ListTile(
              //     leading: const Icon(Icons.person),
              //     title: new TextField(
              //       decoration: InputDecoration(
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10)),
              //         hintText: "Name",
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                //padding: EdgeInsets.all(20),
                child: TextField(
                  controller: userNameController,
                  onChanged: (String val) {
                    setState(() {
                      name = val;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'UserName',
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(29))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //padding: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Full Name',
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(29))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //padding: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(29))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //padding: EdgeInsets.all(20),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.black,
                      ),
                      suffixIcon: Icon(Icons.visibility_off_rounded),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(29))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //padding: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Chose Gender',
                      suffixIcon: DropdownButton(
                        value: gender,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: item.map((String items) {
                          return DropdownMenuItem(
                              value: items, child: Text(items));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                      prefixIcon: Icon(
                        Icons.person_add_alt_outlined,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(29))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //padding: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: dateTime.day.toString() +
                          '/' +
                          dateTime.month.toString() +
                          '/' +
                          dateTime.year.toString(),
                      prefixIcon: Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.black,
                      ),
                      suffixIcon: InkWell(
                        child: Icon(Icons.calendar_view_month),
                        onTap: () {
                          dateBOD();
                        },
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(29))),
                ),
              ),
              Container(
                //padding: EdgeInsets.all(20),
                child: TextField(
                  controller: weigthController,
                  keyboardType: TextInputType.number,
                  onChanged: (String val) {
                    setState(() {
                      weigth = int.parse(val);
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'weight',
                      prefixIcon: Icon(
                        Icons.monitor_weight_sharp,
                        color: Colors.black,
                      ),
                      suffixIcon: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text("KG"),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(29))),
                ),
              ),
              Container(
                //padding: EdgeInsets.all(20),
                child: TextField(
                  controller: heightController,
                  onChanged: (String val) {
                    setState(() {
                      height = double.parse(val);
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Height',
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.black,
                      ),
                      suffixIcon: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text("CM"),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(29))),
                ),
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         padding: EdgeInsets.all(10),
              //         child: Text('User Name'),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         height: 50,
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         padding: EdgeInsets.only(top: 6, right: 6),
              //         child: TextField(
              //           controller: userNameController,
              //           onChanged: (String val) {
              //             setState(() {
              //               name = val;
              //             });
              //           },
              //           decoration: InputDecoration(
              //               border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(10))),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   //padding: EdgeInsets.all(20),
              //   child: TextField(
              //     decoration: InputDecoration(
              //         hintText: 'Full Name',
              //         prefixIcon: Icon(
              //           Icons.person_outline,
              //           color: Colors.black,
              //         ),
              //         border: OutlineInputBorder(
              //             borderSide: BorderSide.none,
              //             borderRadius: BorderRadius.circular(29))),
              //   ),
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         padding: EdgeInsets.all(10),
              //         child: Text('Gender'),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         height: 50,
              //       ),
              //     ),
              //     Expanded(
              //       child: DropdownButton(
              //         value: gender,
              //         icon: Icon(Icons.keyboard_arrow_down),
              //         items: item.map((String items) {
              //           return DropdownMenuItem(
              //               value: items, child: Text(items));
              //         }).toList(),
              //         onChanged: (value) {
              //           setState(() {
              //             gender = value.toString();
              //           });
              //         },
              //       ),
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         padding: EdgeInsets.all(10),
              //         child: Text('DOB'),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         height: 50,
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         padding: EdgeInsets.only(top: 8, right: 10),
              //         child: DateTimePicker(
              //           initialValue: '',
              //           firstDate: DateTime(2000),
              //           lastDate: DateTime(2100),
              //           dateLabelText: 'Date',
              //           onChanged: (val) {
              //             dateTime = DateTime.parse(val);
              //           },
              //           validator: (val) {
              //             print(val);
              //             return null;
              //           },
              //           onSaved: (val) => print(val),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         padding: EdgeInsets.all(10),
              //         child: Text('Height'),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         height: 50,
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         padding: EdgeInsets.only(top: 8, right: 10),
              //         child: TextField(
              //           controller: heightController,
              //           onChanged: (String val) {
              //             setState(() {
              //               height = double.parse(val);
              //             });
              //           },
              //           decoration: InputDecoration(
              //               border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(10))),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         padding: EdgeInsets.all(10),
              //         child: Text('weight'),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         height: 50,
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         padding: EdgeInsets.only(top: 8, right: 10),
              //         child: TextField(
              //           controller: weigthController,
              //           keyboardType: TextInputType.number,
              //           onChanged: (String val) {
              //             setState(() {
              //               weigth = int.parse(val);
              //             });
              //           },
              //           decoration: InputDecoration(
              //               border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(10))),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         padding: EdgeInsets.all(10),
              //         child: Text('Height'),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         height: 50,
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(),
              //     ),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         padding: EdgeInsets.all(10),
              //         child: Text('Goal'),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         height: 50,
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(),
              //     ),
              //   ],
              // ),
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
