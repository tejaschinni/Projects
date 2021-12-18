import 'dart:convert';

import 'package:caloriescounter/caloriescounter/dashBoardPage.dart';
import 'package:caloriescounter/data/food.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class LibraryFodd extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  DateTime selectedDate;
  List<Food> foodList;
  LibraryFodd(this.foodList, this.gUser, this.selectedDate, this.signOut);

  @override
  _LibraryFoddState createState() => _LibraryFoddState();
}

class _LibraryFoddState extends State<LibraryFodd> {
  List<Food> food = [];
  List<Food> foundfood = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController gramsController = TextEditingController();
  TextEditingController carbonController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController protiensController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

  CollectionReference firestore =
      FirebaseFirestore.instance.collection('caloriecounter');

  bool validator = true;

  int __gram = 0, __cal = 0, __carb = 0, __fat = 0, __prot = 0;

  String name = ' ';
  String grams = ' ',
      carbon = ' ',
      fats = ' ',
      protiens = ' ',
      calories = ' ',
      tcab = ' ',
      tcal = ' ',
      tfat = ' ',
      tgram = ' ',
      tprot = ' ';

  getfoood() {
    for (int i = 0; i < food.length; i++) {
      setState(() {
        Food f = Food(
            gram: food[i].gram,
            calories: food[i].calories,
            fats: food[i].fats,
            protein: food[i].protein,
            carbon: food[i].carbon,
            name: food[i].name);
        foundfood.add(f);
      });
    }
  }

  void validate() {
    if (gramsController.text.length > 0) {
      setState(() {
        validator = true;
        addFood();
        _read();
        nameController.text = "";
        protiensController.text = "";
        caloriesController.text = "";
        gramsController.text = "";
        fatsController.text = "";
        carbonController.text = "";
        name = "";
        fats = '';
        grams = '';
        protiens = '';
        calories = "";
        carbon = "";
        Get.offAll(() => DashBoardPage(widget.gUser, widget.signOut));
        print(' ---------------------------- Validation True ');
      });
    } else {
      setState(() {
        validator = false;
        print(' ---------------------------- Validation false ');
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    foundfood = widget.foodList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      children: [
        Container(
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Column(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    child: Stack(
                      children: [
                        Image.asset('assets/calories.png'),
                        Positioned(
                          left: 50,
                          bottom: 30,
                          child: Text(
                            caloriesController.text,
                            style: TextStyle(fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Calores', style: TextStyle(fontSize: 10))
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
                    child: Image.asset('assets/carbs.png'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Carbs', style: TextStyle(fontSize: 10))
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
                    child: Image.asset(
                      'assets/fat.png',
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Fat', style: TextStyle(fontSize: 10))
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
                    child: Image.asset('assets/protien.png'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Protien', style: TextStyle(fontSize: 10))
                ],
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: TextField(
            onChanged: (value) => _runFilter(value),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
            child: ListView.builder(
                itemCount: foundfood.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(14),
                    child: InkWell(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 70,
                                child: Text(
                                  foundfood[index].name,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              Text(foundfood[index].gram + ' g',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              Text(
                                foundfood[index].calories + ' c \t\t',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.pink[300]),
                              ),
                              Text(foundfood[index].carbon + ' c \t\t',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.deepPurpleAccent[400])),
                              Text(foundfood[index].fats + ' f \t\t',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.orange[400])),
                              Text(foundfood[index].protein + ' p \t',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.redAccent[200])),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        setRecipeValue(
                            foundfood[index].name,
                            int.parse(foundfood[index].calories),
                            int.parse(foundfood[index].gram),
                            int.parse(foundfood[index].carbon),
                            int.parse(foundfood[index].protein),
                            int.parse(foundfood[index].fats));
                        _showMyDialog();
                      },
                    ),
                  );
                }))
      ],
    )));
  }

  void _runFilter(String enteredKeyword) {
    List<Food> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = widget.foodList;
    } else {
      results = widget.foodList
          .where((user) =>
              user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      foundfood = results;
    });
  }

  void setRecipeValue(
      String name, int cal, int grm, int carb, int prot, int fat) {
    setState(() {
      this.grams = grm.toString();
      this.calories = cal.toString();
      this.carbon = carb.toString();
      this.protiens = prot.toString();
      this.fats = fat.toString();
      this.name = name;

      __cal = int.parse(cal.toString());
      __gram = int.parse(grm.toString());
      __carb = int.parse(carb.toString());
      __fat = int.parse(fat.toString());
      __prot = int.parse(prot.toString());

      nameController.text = name;
      gramsController.text = __gram.toString();
      caloriesController.text = __cal.toString();
      carbonController.text = __carb.toString();
      fatsController.text = __fat.toString();
      protiensController.text = __prot.toString();
    });
  }

  void onGramchange() {
    double val;

    setState(() {
      if (__gram >= 5) {
        val = __gram / int.parse(this.grams);

        __cal = (int.parse(this.calories) * val).toInt();
        __fat = (int.parse(this.fats) * val).toInt();
        __carb = (int.parse(this.carbon) * val).toInt();
        __prot = (int.parse(this.protiens) * val).toInt();

        caloriesController.text = __cal.toString();
        gramsController.text = __gram.toString();
        carbonController.text = __carb.toString();
        fatsController.text = __fat.toString();
        protiensController.text = __prot.toString();

        print(' ----------__cal-----' + __cal.toString());
        print(' ----------__fat-----' + __fat.toString());
        print(' ----------__carb-----' + __carb.toString());
        print(' ----------__carb-----' + __prot.toString());
      } else {
        print('Enter Greater than 50');
      }
    });
  }

  Future<void> addFood() async {
    firestore
        .doc(widget.gUser.email)
        .collection('food')
        .doc(widget.selectedDate.toString())
        .collection('meals')
        .doc()
        .set({
      'name': name,
      'fats': int.parse(fatsController.text),
      'grams': int.parse(gramsController.text),
      'protiens': int.parse(protiensController.text),
      'calories': int.parse(caloriesController.text),
      'carbon': int.parse(carbonController.text)
    });
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
        querySnapshot.docs.forEach((doc) {
          tcab = '0';
          tcal = '0';
          tfat = '0';
          tgram = '0';
          tprot = '0';
          for (var item in querySnapshot.docs) {
            tcab = tcab + item['carbon'];
            tcal = tcal + item['calories'].toString();
            tfat = tfat + item['fats'].toString();
            tprot = tprot + item['protiens'].toString();
            tgram = tgram + item['grams'].toString();
          }
        });
        firestore
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
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          nameController.text,
                          style: TextStyle(fontSize: 18),
                        ))),
                SizedBox(
                  height: 40,
                  width: 80,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: gramsController,
                    keyboardType: TextInputType.number,
                    onChanged: (String val) {
                      setState(() {
                        __gram = int.parse(val);
                      });

                      onGramchange();
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                setState(() {
                  validate();
                });
              },
            ),
          ],
        );
      },
    );
  }
}
