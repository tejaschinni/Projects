import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  String stringResponse = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apicalll();
  }

  Future apicalll() async {
    http.Response response;
    response = await http.get(Uri.parse('https://hoblist.com/api/movieList'));
    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies List'),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Company Info',
                  style: TextStyle(fontSize: 20),
                ),
                decoration: BoxDecoration(color: Colors.blueAccent),
              ),
              ListTile(
                leading: Text('Company name'),
                title: Text('Geeksynergy Technologies Pvt Ltd'),
              ),
              ListTile(
                leading: Text('Address'),
                title: Text('Sanjayanagar, Bengaluru-56'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('XXXXXXXX09'),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('XXXXXX@gmail.com'),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Row(
          children: [
            Column(
              children: [
                Icon(Icons.arrow_drop_up),
                Text('1'),
                Icon(Icons.arrow_drop_down),
                Row(
                  children: [Text('data')],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
