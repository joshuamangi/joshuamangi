import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContentDescription extends StatelessWidget {
  final IconData displayedIcon;
  final String sectionTitle;
  final Widget sectionContent;
  final String? textAlign;

  ContentDescription({
    super.key,
    required this.displayedIcon,
    required this.sectionTitle,
    required this.sectionContent,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              children: [
                // Icon passed to appear here
                Container(
                    padding: const EdgeInsets.all(7.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFB7C6C9),
                          width: 3,
                        )),
                    child: FaIcon(
                      displayedIcon,
                      size: 22,
                      color: const Color(0xFFB7C6C9),
                    )),
                const SizedBox(
                  width: 10,
                ), //   Section Title passed to be added here
                Text(sectionTitle),
                const SizedBox(
                  width: 10,
                ),
                //   Line divider
                const Expanded(
                    child: Divider(
                  color: Color(0xFFB7C6C9),
                  thickness: 4,
                  height: 5,
                ))
              ],
            ),
          ),
          sectionContent,
        ],
      ),
    );
  }
}
