import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "YOUR_API_KEY", // all from project sittings
      authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
      databaseURL: "https://YOUR_PROJECT_ID.firebaseio.com",
      projectId: "YOUR_PROJECT_ID",
      storageBucket: "YOUR_PROJECT_ID.appspot.com",
      appId: "YOUR_APP_ID",
      messagingSenderId:
          'ID messaging sender', //this one u 'll find it in the project settings
      //the name of the app and u find it in "nameAPP.web"
    ),
  );
  runApp(SwitchRobot());
}

class SwitchRobot extends StatefulWidget {
  @override
  _SwitchRobotState createState() => _SwitchRobotState();
}

class _SwitchRobotState extends State<SwitchRobot> {
  bool isSwitchOn = false;
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref('switch_status').child("a");

  void toggleSwitch(bool value) {
    setState(() {
      isSwitchOn = value;
    });

    // Send data to Firebase Realtime Database
    sendDataToDatabase(value ? '1' : '0');
  }

  void sendDataToDatabase(String data) {
    databaseReference.set(data);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Switch Robot Control'),
        ),
        body: Center(
          child: Container(
            height: 750,
            width: 355,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 4, 1, 0.112),
                  blurRadius: 15,
                  offset: Offset(0, 10),
                ),
              ],
              border: Border.all(
                width: 2,
                color: const Color.fromARGB(255, 132, 184, 140),
              ),
            ),
            child: Column(
              children: [
                // Image layout
                Image.asset(
                  'assets/images/controllRobot.png',
                  width: 300,
                  alignment: Alignment.topCenter,
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text.rich(TextSpan(children: [
                      TextSpan(
                        text:
                            "Activate me to detect plant diseases, and I'm geared up to fight and identify them.",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "control",
                            fontSize: 18),
                      ),
                      TextSpan(
                        text: " Let's do this!",
                        style: TextStyle(
                            color: Color.fromARGB(255, 22, 121, 32),
                            fontFamily: "control",
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
                    ])),
                  ),
                ),
                const SizedBox(
                  height: 200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Off',
                      style: TextStyle(
                        color: isSwitchOn
                            ? Colors.grey
                            : const Color.fromARGB(255, 163, 34, 52),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Transform.scale(
                      scale:
                          1.75, // Increase the scale value to increase the size
                      child: Switch(
                        value: isSwitchOn,
                        onChanged: toggleSwitch,
                        activeColor: const Color.fromARGB(
                            255, 13, 126, 47), // Customize active color
                      ),
                    ),
                    Text(
                      'On',
                      style: TextStyle(
                        color: isSwitchOn
                            ? const Color.fromARGB(255, 13, 126, 47)
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
