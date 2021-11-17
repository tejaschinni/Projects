import 'package:caloriescounter/caloriescounter/dashBoardPage.dart';
import 'package:caloriescounter/caloriescounter/homePage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[],
);

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  String documentPathOwner = '', email = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });

      if (_currentUser != null) {}
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return HomePage(user, _handleSignOut);
    } else {
      return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Expanded(
                flex: 5,
                child: Container(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: PieChart(
                    PieChartData(
                        startDegreeOffset: 3,
                        centerSpaceRadius: 0,
                        sectionsSpace: 0,
                        // borderData: FlBorderData(show: false),
                        sections: data),
                    swapAnimationDuration:
                        Duration(milliseconds: 150), // Optional
                    swapAnimationCurve: Curves.linear, // Optional
                  ),
                ))),
            Container(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Marcos\n',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 50),
                  //style: DefaultTextStyle.of(context).style,
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'EveryOne Can Count',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    _handleSignIn();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.white))),
                      shadowColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 15,
                          child: Image.asset(
                            'assets/googleLogo.png',
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Countinue With Google ',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                  )),
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue))),
                      shadowColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 15,
                          child: Image.asset(
                            'assets/faceBookLogo.jpg',
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Countinue With FaceBook ',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  )),
            ),
            Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Positioned(
                      left: 10,
                      bottom: -10,
                      child: Image.asset(
                        'assets/image3.png',
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.2,
                        //scale: 0.1,
                        fit: BoxFit.fill,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                    Positioned(
                      left: 110,
                      bottom: 0,
                      child: Image.asset(
                        'assets/image2.png',
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.2,
                        //scale: 0.1,
                        fit: BoxFit.fill,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                    Positioned(
                      left: 190,
                      bottom: -20,
                      child: Image.asset(
                        'assets/image1.png',
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.2,
                        //scale: 0.1,
                        fit: BoxFit.fill,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                    Positioned(
                      left: 290,
                      bottom: -10,
                      child: Image.asset(
                        'assets/image4.png',
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.2,
                        //scale: 0.1,
                        fit: BoxFit.fill,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: _buildBody(),
    ));
  }

  List<PieChartSectionData> data = [
    PieChartSectionData(
        title: " ", color: Colors.white54, value: 50, radius: 130),
    PieChartSectionData(
        title: "20,1 ", color: Colors.purple[300], value: 20, radius: 150),
  ];

  List<ChartData> d1 = [
    ChartData('A', 80, Color.fromRGBO(9, 0, 136, 1), "130"),
    ChartData('B', 50, Color.fromRGBO(203, 141, 238, 1), "150")
  ];
}

class ChartData {
  ChartData(this.x, this.y, this.color, this.size);
  final String x;
  final double y;
  final Color color;
  final String size;
}
