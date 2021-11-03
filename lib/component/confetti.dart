import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late ConfettiController controller;

  @override
  void initState() {
    controller =
        ConfettiController(duration: const Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: controller,
                shouldLoop: true,
                blastDirection: pi,
                gravity: 0.0,
                numberOfParticles: 900,
                emissionFrequency: 0.1,
                displayTarget: false,
                blastDirectionality: BlastDirectionality.explosive,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
