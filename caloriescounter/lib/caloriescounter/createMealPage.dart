import 'dart:ui';

import 'package:caloriescounter/data/food.dart';
import 'package:caloriescounter/data/recipiesData.dart';
import 'package:caloriescounter/demo/selectedOptionTab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CreateMealPage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  DateTime selectedDate;
  List<Food> foodList;
  List<Recipies> userRecipeList;
  Function _readUserRecipeList;
  CreateMealPage(this.foodList, this.gUser, this.selectedDate, this.signOut,
      this.userRecipeList, this._readUserRecipeList);

  @override
  _CreateMealPageState createState() => _CreateMealPageState();
}

class _CreateMealPageState extends State<CreateMealPage> {
  List<Food> ingredent = [];
  List<Food> findFood = [];
  List<Food> temp = [];

  bool validator = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController mealNameController = TextEditingController();
  TextEditingController gramsController = TextEditingController();
  TextEditingController carbonController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController protiensController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

  CollectionReference firestore =
      FirebaseFirestore.instance.collection('caloriecounter');

  int __gram = 0,
      __cal = 0,
      __carb = 0,
      __fat = 0,
      __prot = 0,
      tcab = 0,
      tcal = 0,
      tfat = 0,
      tgram = 0,
      tprot = 0;

  String name = ' ', mealname = '';
  String grams = ' ', carbon = ' ', fats = ' ', protiens = ' ', calories = ' ';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findFood = widget.foodList;
  }

  void validate() {
    if (mealNameController.text.length > 2) {
      print('--------------true');
      addFood();
    } else {
      print('--------------false');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text('Create your Meal'),
      // ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (value) => _runFilter(value),
                      decoration: InputDecoration(
                          labelText: 'Ingrident List',
                          contentPadding: EdgeInsets.all(5),
                          suffixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(29))),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 3,
              child: findFood.length > 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: findFood.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: ListTile(
                            title: Text(findFood[index].name),
                          ),
                          onTap: () {
                            setRecipeValue(
                                findFood[index].name,
                                int.parse(findFood[index].calories),
                                int.parse(findFood[index].gram),
                                int.parse(findFood[index].carbon),
                                int.parse(findFood[index].protein),
                                int.parse(findFood[index].fats));
                            _showMyDialog();
                          },
                        );
                      })
                  : Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                radius:
                                    MediaQuery.of(context).size.width * 0.07,
                                child: Text(
                                  tcal.toString(),
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text('Calories',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black)),
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
                                radius:
                                    MediaQuery.of(context).size.width * 0.07,
                                child: Text(
                                  tcab.toString(),
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text('Carbs',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black)),
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
                                radius:
                                    MediaQuery.of(context).size.width * 0.07,
                                child: Text(
                                  tfat.toString(),
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text('Fat',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black)),
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
                                radius:
                                    MediaQuery.of(context).size.width * 0.07,
                                child: Text(
                                  tprot.toString(),
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text('Protiens',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black)),
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
                                radius:
                                    MediaQuery.of(context).size.width * 0.07,
                                child: Text(
                                  tgram.toString(),
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text('Grams',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 5,
                child: Container(
                  child: ListView.builder(
                      itemCount: temp.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 70,
                                    child: Text(
                                      temp[index].name,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  Text(temp[index].gram + ' g',
                                      style: TextStyle(color: Colors.grey)),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  Text(
                                    temp[index].calories + ' c \t',
                                    style: TextStyle(color: Colors.pink[300]),
                                  ),
                                  Text(temp[index].carbon + ' c \t',
                                      style: TextStyle(
                                          color: Colors.deepPurpleAccent[400])),
                                  Text(temp[index].fats + ' f \t',
                                      style:
                                          TextStyle(color: Colors.orange[400])),
                                  Text(temp[index].protein + ' p \t',
                                      style: TextStyle(
                                          color: Colors.redAccent[200])),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                  ),
                                  InkWell(
                                    child: Icon(
                                        Icons.cancel_presentation_outlined),
                                    onTap: () {
                                      setState(() {
                                        tgram =
                                            tgram - int.parse(temp[index].gram);
                                        tcal = tcal -
                                            int.parse(temp[index].calories);
                                        tcab = tcab -
                                            int.parse(temp[index].carbon);
                                        tfat =
                                            tfat - int.parse(temp[index].fats);
                                        tprot = tprot -
                                            int.parse(temp[index].protein);

                                        temp.removeAt(index);
                                      });
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                        // ListTile(
                        //   title: Text(temp[index].name),
                        //   subtitle: Text(temp[index].gram),
                        //   trailing: InkWell(
                        //     child: Icon(Icons.delete),
                        //     onTap: () {
                        //       setState(() {
                        //         tgram = tgram - int.parse(temp[index].gram);
                        //         tcal = tcal - int.parse(temp[index].calories);
                        //         tcab = tcab - int.parse(temp[index].carbon);
                        //         tfat = tfat - int.parse(temp[index].fats);
                        //         tprot = tprot - int.parse(temp[index].protein);

                        //         temp.removeAt(index);
                        //       });
                        //     },
                        //   ),
                        // );
                      }),
                )),
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: -10,
                      child: Image.asset(
                        'assets/image3.png',
                        height: MediaQuery.of(context).size.height * 0.14,
                        width: MediaQuery.of(context).size.width * 0.14,
                        //scale: 0.1,
                        fit: BoxFit.fill,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                    Positioned(
                      left: 70,
                      bottom: -10,
                      child: Image.asset(
                        'assets/image2.png',
                        height: MediaQuery.of(context).size.height * 0.14,
                        width: MediaQuery.of(context).size.width * 0.14,
                        //scale: 0.1,
                        fit: BoxFit.fill,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                    Positioned(
                      left: 140,
                      bottom: -25,
                      child: Image.asset(
                        'assets/image1.png',
                        height: MediaQuery.of(context).size.height * 0.14,
                        width: MediaQuery.of(context).size.width * 0.14,
                        //scale: 0.1,
                        fit: BoxFit.fill,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                    Positioned(
                      left: 210,
                      bottom: -15,
                      child: Image.asset(
                        'assets/image4.png',
                        height: MediaQuery.of(context).size.height * 0.14,
                        width: MediaQuery.of(context).size.width * 0.14,
                        //scale: 0.1,
                        fit: BoxFit.fill,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                )),
            // Expanded(
            //     child: Container(
            //   padding: EdgeInsets.all(10),
            //   child: ElevatedButton(
            //     child: Text(
            //       'Submit Your Meal',
            //       style: TextStyle(
            //         fontSize: 18,
            //         color: Colors.black,
            //       ),
            //     ),
            //     onPressed: () {
            //       setState(() {
            //         // _addMeal();
            //         showDialog(
            //             context: context,
            //             builder: (BuildContext context) => leadDialog);
            //       });
            //     },
            //   ),
            // ))
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurple[900],
          // shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              // _addMeal();
              showDialog(
                  context: context,
                  builder: (BuildContext context) => leadDialog);
            });
          },
        ),
      ),
    );
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
                  Food f = Food(
                      gram: gramsController.text,
                      calories: caloriesController.text,
                      fats: fatsController.text,
                      protein: protiensController.text,
                      carbon: carbonController.text,
                      name: nameController.text);
                  temp.add(f);

                  tgram = tgram + int.parse(gramsController.text);
                  tcal = tcal + int.parse(caloriesController.text);
                  tcab = tcab + int.parse(carbonController.text);
                  tfat = tfat + int.parse(fatsController.text);
                  tprot = tprot + int.parse(protiensController.text);
                });

                print(' Meal ingrednet-------------------' +
                    temp.length.toString());
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  Dialog leadDialog = Dialog(
    child: Container(
      height: 400.0,
      width: 460.0,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Positioned(
                        left: 0,
                        child: InkWell(
                          child: Icon(Icons.cancel_presentation_rounded),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ],
      ),
    ),
  );

  Future<void> _addMeal() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: TextField(
              controller: mealNameController,
              onChanged: (String val) {
                setState(() {
                  mealname = val;
                });
              },
              decoration: InputDecoration(
                  labelText: 'Enter Meal name ',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            content: Container(
              width: double.minPositive,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: temp.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  temp[index].name.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  temp[index].gram.toString() + 'gram',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  ' ',
                                  style: TextStyle(color: Colors.blue.shade900),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'C  :  ' +
                                          temp[index].calories.toString() +
                                          'g',
                                      style: TextStyle(
                                          color: Colors.blue.shade900,
                                          fontSize: 10),
                                    ),
                                    Text(
                                      'C  :  ' +
                                          temp[index].carbon.toString() +
                                          'g',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'P  :  ' +
                                          temp[index].carbon.toString() +
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
                                          temp[index].fats.toString() +
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
                        Divider()
                      ],
                    ),
                  );
                },
              ),
            ),
            actions: [
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
        });
  }

  Widget _buildRow(String name, double gram) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [],
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
      findFood = results;
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
        carbonController.text = __carb.toString();
        fatsController.text = __fat.toString();
        protiensController.text = __prot.toString();
        gramsController.text = __gram.toString();

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
    DocumentReference ref =
        await firestore.doc(widget.gUser.email).collection('recipes').add({
      'name': mealname,
      'fats': int.parse(fatsController.text),
      'grams': int.parse(gramsController.text),
      'protiens': int.parse(protiensController.text),
      'calories': int.parse(caloriesController.text),
      'carbon': int.parse(carbonController.text)
    });

    setState(() {
      Recipies r = Recipies(
          int.parse(caloriesController.text),
          int.parse(carbonController.text),
          int.parse(fatsController.text),
          int.parse(gramsController.text),
          mealname,
          int.parse(protiensController.text),
          ref);
      widget.userRecipeList.add(r);
    });

    Get.back();
    DefaultTabController.of(context)!.animateTo(0);
  }
}
