import 'package:caloriescounter/caloriescounter/addFood.dart';
import 'package:caloriescounter/caloriescounter/createMealPage.dart';
import 'package:caloriescounter/caloriescounter/recipiesListSearchPage.dart';
import 'package:caloriescounter/data/food.dart';
import 'package:caloriescounter/data/recipiesData.dart';
import 'package:caloriescounter/jsonParsing/libraryFood.dart';
import 'package:caloriescounter/jsonParsing/parse.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SelectOptionTab extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  DateTime selectedDate;
  List<Food> food;
  List<Recipies> userRecipeList;
  Function _readUserRecipeList;
  SelectOptionTab(this.gUser, this.selectedDate, this.signOut,
      this.userRecipeList, this.food, this._readUserRecipeList);

  @override
  _SelectOptionTabState createState() => _SelectOptionTabState();
}

class _SelectOptionTabState extends State<SelectOptionTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Add Food', style: TextStyle(color: Colors.black)),
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: InkWell(
                child: Icon(Icons.home),
                onTap: () {
                  widget.signOut();
                },
              ),
            )
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            automaticIndicatorColorAdjustment: true,
            labelColor: Colors.redAccent,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'My Recipe',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Librarie', style: TextStyle(color: Colors.grey)),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child:
                      Text('Create Meal', style: TextStyle(color: Colors.grey)),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          child: TabBarView(children: [
            AddFood(widget.gUser, widget.selectedDate, widget.signOut,
                widget.userRecipeList),
            LibraryFodd(
                widget.food, widget.gUser, widget.selectedDate, widget.signOut),
            CreateMealPage(
                widget.food,
                widget.gUser,
                widget.selectedDate,
                widget.signOut,
                widget.userRecipeList,
                widget._readUserRecipeList)
          ]),
        ),
      ),
    );
  }
}
