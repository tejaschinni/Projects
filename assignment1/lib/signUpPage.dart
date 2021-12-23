import 'package:assignment1/data/userData.dart';
import 'package:assignment1/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  String profession = 'Lawyer';
  var item = [
    'Lawyer',
    'Teacher',
    'Software Developer',
    'Actor',
  ];

  var box;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initHive();
  }

  initHive() async {
    box = await Hive.openBox('myBox');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign Up '),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(29))),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(29))),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(29))),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: 'Phone Number ',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(29))),
                ),
              ),
              Container(
                child: DropdownButton(
                  value: profession,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: item.map((String profession) {
                    return DropdownMenuItem(
                        value: profession, child: Text(profession));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      profession = value.toString();
                    });
                  },
                ),
              ),
              Container(
                child: ElevatedButton(
                    onPressed: () {
                      addUserData();
                    },
                    child: Text('SignUP')),
              ),
              Divider(),
              Container(
                child: Text('Already have Signup then Login'),
              ),
              Container(
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      });
                    },
                    child: Text('Login')),
              ),
            ],
          )),
        ),
      ),
    );
  }

  addUserData() async {
    if (numberController.text.length == 10 && nameController.text.length > 2) {
      setState(() {
        UserData g = new UserData(
            name: nameController.text,
            password: passController.text,
            email: emailController.text,
            profession: profession,
            number: int.parse(numberController.text));
        box.add(g);
      });
      setState(() {
        nameController.text = ' ';
        passController.text = ' ';
        emailController.text = ' ';
        numberController.text = '';
      });
      print('Added done');

      // Get.snackbar('success', 'UserData added Successfully');
    } else {
      print('object');
    }
  }

  void aleartbox() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Alert Dialog Box"),
        content: Text("You have raised a Alert Dialog Box"),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("okay"),
          ),
        ],
      ),
    );
  }
}
