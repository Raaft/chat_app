import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:animate_do/animate_do.dart';

import '../main.dart';

class SplashScreeen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FadeIn(
          duration: Duration(seconds: 3),
          child: Center(
              child: SplashScreen(
            navigateAfterSeconds: MyApp(),
            seconds: 3,
            title: Text('Chat Me',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: Colors.pink)),
            loadingText: Text('By:Raafat Husseny',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple)),
            loaderColor: Colors.black12,
            backgroundColor: Colors.white10,
          )),
        ),
      ),
    );
  }
}
