import 'package:assignment1/data/userData.dart';
import 'package:assignment1/viewPage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var box;
  List<UserData> user = [];
  String email = '', pass = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initHive();
  }

  initHive() async {
    box = await Hive.openBox('myBox');
    getEnquery();
  }

  getEnquery() async {
    user.clear();
    for (int i = 0; i < box.length; i++) {
      setState(() {
        user.add(box.getAt(i));
      });
    }
  }

  void aleartbox() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Alert"),
        content: Text("Invalid Credentials"),
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

  void uservalidation() {
    for (int i = 0; i < user.length; i++) {
      if (email == user[i].email && pass == user[i].password) {
        print("User Is valid");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ViewPage()));
      } else {
        aleartbox();
        print('Invalid Credentinal');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login Page'),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: emailController,
                  onChanged: (String val) {
                    setState(() {
                      email = val;
                    });
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(29))),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: passController,
                  obscureText: true,
                  onChanged: (String val) {
                    setState(() {
                      pass = val;
                    });
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(29))),
                ),
              ),
              Container(
                child: ElevatedButton(
                    onPressed: () {
                      uservalidation();
                    },
                    child: Text('Login')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
