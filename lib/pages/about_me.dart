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
    "Software Engineer",
    "Devops Engineer",
    "Body weight exercise lover"
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
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ContentDescription(
            displayedIcon: FontAwesomeIcons.user,
            sectionTitle: "A LITTLE ABOUT ME",
            sectionContent:
                Center(child: Text("Hello I am  a " + whoAmI[currentIndex])),
          ),
        ),
        Expanded(
          flex: 1,
          child: ContentDescription(
            displayedIcon: FontAwesomeIcons.twitter,
            sectionTitle: "CONNECT",
            sectionContent: Center(child: Text("Hello, this is me")),
          ),
        ),
      ],
    );
  }
}
