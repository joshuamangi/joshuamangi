import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:joshuamangi/layouts/content_description.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({super.key});

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  List<String> whoAmI = [
    "Joshua Mangi",
    "a Software Engineer",
    "a Devops Engineer",
    "a Body weight exercise lover",
  ];
  int currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    //   Start timer that changes every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      setState(() {
        //   Update the indexx to the next item in the array
        currentIndex = (currentIndex + 1) % whoAmI.length;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity, // Provides finite width
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ContentDescription(
              displayedIcon: FontAwesomeIcons.user,
              sectionTitle: "A LITTLE ABOUT ME",
              sectionContent: Center(
                child: Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "Hi, I am ${whoAmI[currentIndex]}.\nI am a Kenyan software engineer and automation engineer",
                          ),
                          const TextSpan(
                            text: "\n(currently @ Save the Children)",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                            ),
                          ),
                          const TextSpan(
                              text:
                                  "\nI have a passion for programming across various platforms and writing code that solves problems."),
                        ],
                      ),
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w100,
                          letterSpacing: 0.1),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: ContentDescription(
              displayedIcon: FontAwesomeIcons.twitter,
              sectionTitle: "CONNECT",
              sectionContent: Center(child: Text("Hello, this is me")),
            ),
          ),
        ],
      ),
    );
  }
}
