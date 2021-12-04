// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(MaterialApp(
      home: ScreenSaver(),
      locale: Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "Product Sans"),
    ));

class ScreenSaver extends StatefulWidget {
  @override
  State<ScreenSaver> createState() => _ScreenSaverState();
}

List<String> bgImages = [
  "assets/pics/archpic.jpg",
  "assets/pics/beachpic.jpg",
  "assets/pics/cabinpic.jpg",
  "assets/pics/lakepic.jpg",
  "assets/pics/lakesidepic.jpg",
  "assets/pics/mountainpic.jpg",
  "assets/pics/waterfallpic.jpg",
  "assets/pics/frozenlakepic.jpg",
  "assets/pics/citypic.jpg",
  "assets/pics/walkingpathpic.jpg",
];

List<String> photographersNames = [
  "Mark Watson",
  "Brittney Anderson",
  "Mary Diaz",
  "Donald Baker",
  "Colin Holmes",
  "Heather Williams",
  "Vanessa Villa",
  "Ryan Chavez",
  "Steven Nguyen",
  "Pam Lara",
  "Irvine Mcthune",
  "Avantika Partida",
  "Katherine Lee",
  "Pinsky Yelonugda",
  "Neechi Miaaj",
];

class _ScreenSaverState extends State<ScreenSaver> with TickerProviderStateMixin {
  int _currentImage = 0;
  int _currentName = 0;
  late Animation<double> _animation;
  late AnimationController _controller;
  // ignore: unused_field
  late Timer _timer;
  TimeOfDay _currentTime = TimeOfDay.now();
  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 8), (Timer t) {
      setState(() {
        _currentImage = (_currentImage + 2) % bgImages.length;
        _currentName = (_currentName + 2) % photographersNames.length;
        _currentTime = TimeOfDay.now();
      });
      _controller = AnimationController(
          duration: const Duration(
            seconds: 4,
          ),
          vsync: this,
          value: 0,
          lowerBound: 0,
          upperBound: 1);
      _animation = CurvedAnimation(parent: _controller, curve: Curves.ease);
      _controller.forward();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          // Background
          FadeTransition(
            opacity: _animation,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.asset(
                    bgImages[_currentImage],
                    gaplessPlayback: false,
                  ).image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: FadeTransition(
                      opacity: _animation,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.cast,
                                            color: Colors.white.withOpacity(0.8), size: 20),
                                        SizedBox(width: 10),
                                        Text("Just for fun...",
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(0.8),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300,
                                            )),
                                      ]),
                                  Text("Learn more at www.flutter.dev",
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                      )),
                                ]),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(_currentTime.format(context).toLowerCase(),
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 60,
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    photographersNames[_currentName],
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 20,
                                      letterSpacing: 1.2,
                                    ),
                                  )
                                ]),
                          ]),
                    ),
                  )))
        ]));
  }
}
