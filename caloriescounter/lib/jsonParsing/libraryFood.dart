import 'dart:convert';

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
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    labelText: 'Search',
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                flex: 4,
                child: ListView.builder(
                    itemCount: foundfood.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: InkWell(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    foundfood[index].name.toString(),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        foundfood[index].gram.toString() +
                                            'gram',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ' ',
                                        style: TextStyle(
                                            color: Colors.blue.shade900),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'C  :  ' +
                                                foundfood[index]
                                                    .calories
                                                    .toString() +
                                                'g',
                                            style: TextStyle(
                                                color: Colors.blue.shade900,
                                                fontSize: 10),
                                          ),
                                          Text(
                                            'C  :  ' +
                                                foundfood[index]
                                                    .carbon
                                                    .toString() +
                                                'g',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            'P  :  ' +
                                                foundfood[index]
                                                    .carbon
                                                    .toString() +
                                                'g',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.blueAccent),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            'F : ' +
                                                foundfood[index]
                                                    .fats
                                                    .toString() +
                                                'g',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.orangeAccent),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Divider(),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              setRecipeValue(
                                  foundfood[index].name,
                                  int.parse(foundfood[index].calories),
                                  int.parse(foundfood[index].gram),
                                  int.parse(foundfood[index].carbon),
                                  int.parse(foundfood[index].protein),
                                  int.parse(foundfood[index].fats));
                            });
                          },
                        ),
                      );
                    }),
              ),
              Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text('Recipe Name : '),
                                ),
                                Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          nameController.text,
                                          style: TextStyle(fontSize: 18),
                                        ))),
                                SizedBox(
                                  height: 40,
                                  width: 60,
                                  child: SizedBox(
                                    height: 40,
                                    width: 20,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: gramsController,
                                      keyboardType: TextInputType.number,
                                      onChanged: (String val) {
                                        setState(() {
                                          __gram = int.parse(val);
                                        });
                                        validate();
                                        onGramchange();
                                      },
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Grams',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                          backgroundColor: Colors.redAccent,
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08,
                                          child: Text(
                                            caloriesController.text,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        child: Text('Calories',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    children: [
                                      CircleAvatar(
                                          backgroundColor: Colors.redAccent,
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08,
                                          child: Text(
                                            carbonController.text,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        child: Text('Carbs',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    children: [
                                      CircleAvatar(
                                          backgroundColor: Colors.yellowAccent,
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08,
                                          child: Text(
                                            fatsController.text,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        child: Text('Fat',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    children: [
                                      CircleAvatar(
                                          backgroundColor:
                                              Colors.redAccent[700],
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08,
                                          child: Text(
                                            protiensController.text,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        child: Text('Protiens',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            addFood();
            Get.back();
          });
        },
      ),
    );
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

  void validate() {
    if (nameController.text.length > 2 &&
        gramsController.text.length > 0 &&
        protiensController.text.length > 0 &&
        carbonController.text.length > 0 &&
        caloriesController.text.length > 0 &&
        fatsController.text.length > 0) {
      setState(() {
        validator = true;

        print(' ---------------------------- Validation True ');
      });
    } else {
      setState(() {
        validator = false;
        print(' ---------------------------- Validation false ');
      });
    }
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
}
