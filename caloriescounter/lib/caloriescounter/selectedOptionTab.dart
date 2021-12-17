import 'package:caloriescounter/caloriescounter/addFood.dart';
import 'package:caloriescounter/caloriescounter/createMealPage.dart';
import 'package:caloriescounter/caloriescounter/profilePage.dart';
import 'package:caloriescounter/caloriescounter/recipiesListSearchPage.dart';
import 'package:caloriescounter/data/food.dart';
import 'package:caloriescounter/data/recipiesData.dart';
import 'package:caloriescounter/jsonParsing/libraryFood.dart';
import 'package:caloriescounter/jsonParsing/parse.dart';
import 'package:caloriescounter/signInPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class _SelectOptionTabState extends State<SelectOptionTab>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Add Food'),
    Tab(text: 'Libary'),
    Tab(text: 'Create Meal'),
  ];
  late TabController _tabController;
  static final _myTabbedPageKey = new GlobalKey<_SelectOptionTabState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: Container(
              color: Colors.white,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 15,
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
                              'ADD FOOD',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55,
                          ),
                          Container(
                            width: 20,
                            padding: EdgeInsets.zero,
                            // alignment: Alignment.centerRight,
                            // child: FaIcon(FontAwesomeIcons.home),

                            child: PopupMenuButton<String>(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.settings),
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'Profile',
                                  child: ListTile(
                                    leading: Icon(Icons.visibility),
                                    title: Text('Proflie'),
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'SignOut',
                                  child: ListTile(
                                    leading: Icon(Icons.person_add),
                                    title: Text('SignOut'),
                                  ),
                                ),
                              ],
                              onSelected: (String s) {
                                print(s);
                                if (s == 'SignOut') {
                                  widget.signOut();
                                  Get.offAll(() => SignInPage());
                                }
                                if (s == 'Profile') {
                                  setState(() {
                                    Get.to(() => ProfilePage(
                                        widget.gUser, widget.signOut));
                                  });
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: TabBar(
                        indicatorColor: Colors.white,
                        automaticIndicatorColorAdjustment: true,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            //borderRadius: BorderRadius.circular(15),
                            color: Colors.blue.shade100),
                        tabs: [
                          Text("My Recipes"),
                          Text("Libraries"),
                          Text('Create Meal')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              AddFood(widget.gUser, widget.selectedDate, widget.signOut,
                  widget.userRecipeList),
              LibraryFodd(widget.food, widget.gUser, widget.selectedDate,
                  widget.signOut),
              CreateMealPage(
                  widget.food,
                  widget.gUser,
                  widget.selectedDate,
                  widget.signOut,
                  widget.userRecipeList,
                  widget._readUserRecipeList),
            ],
          ),
        ));
  }
}
