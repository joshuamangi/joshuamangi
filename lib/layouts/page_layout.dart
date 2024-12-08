import 'dart:core';

import 'package:flutter/material.dart';

import '../pages/about_me.dart';
import '../pages/activity.dart';
import '../pages/contact.dart';
import '../pages/portfolio.dart';
import '../pages/resume.dart';

class PageLayout extends StatefulWidget {
  const PageLayout({super.key});

  @override
  State<PageLayout> createState() => _PageLayoutState();
}

// Page Layout State
class _PageLayoutState extends State<PageLayout> {
  // Map of all pages with Widget type for navigation
  final Map<String, Map<String, Object>> pages = {
    'portfolio': {'position': 1, 'navigation': const Portfolio()},
    'about me': {'position': 2, 'navigation': const AboutMe()},
    'resume': {'position': 3, 'navigation': const Resume()},
    'activity': {'position': 4, 'navigation': const Activity()},
    'contact': {'position': 5, 'navigation': const Contact()},
  };

  Map<String, Map<String, Object>> initialShownPages = {};
  Widget leftSidePage;
  Widget mainContentPage;
  Widget rightSidePage;

  _PageLayoutState()
      : leftSidePage = const SizedBox.shrink(),
        mainContentPage = const SizedBox.shrink(),
        rightSidePage = const SizedBox.shrink() {
    initialShownPages = _initializeShownPages();
    leftSidePage =
        initialShownPages.values.elementAt(0)['navigation'] as Widget;
    mainContentPage =
        initialShownPages.values.elementAt(1)['navigation'] as Widget;
    rightSidePage =
        initialShownPages.values.elementAt(2)['navigation'] as Widget;
  }

  Map<String, Map<String, Object>> _initializeShownPages() {
    return Map.fromEntries(pages.entries.take(3));
  }

  Map<String, Map<String, Object>> _getDisplayPages(
    bool sideClicked,
    Map<String, Map<String, Object>> reArrangeShownPages,
  ) {
    int pageLength = pages.length;

    List<MapEntry<String, Map<String, Object>>> updateEntries(
      List<MapEntry<String, Map<String, Object>>> entries,
      int removeIndex,
      int insertIndex,
      int pageIndex,
    ) {
      entries.removeAt(removeIndex);
      MapEntry<String, Map<String, Object>> newEntry = MapEntry(
        pages.keys.elementAt(pageIndex),
        pages.values.elementAt(pageIndex),
      );
      entries.insert(insertIndex, newEntry);
      return entries;
    }

    if (sideClicked) {
      List<MapEntry<String, Map<String, Object>>> pageEntries =
          reArrangeShownPages.entries.toList();
      if (reArrangeShownPages.values.first['position'] == 1) {
        int workingIndex = pageLength - 1;
        pageEntries = updateEntries(pageEntries, 2, 0, workingIndex);
      } else {
        int firstPage = reArrangeShownPages.values.first['position'] as int;
        int pageToAdd = firstPage - 2;
        pageEntries = updateEntries(pageEntries, 2, 0, pageToAdd);
      }
      reArrangeShownPages = Map.fromEntries(pageEntries);
    } else {
      List<MapEntry<String, Map<String, Object>>> pageEntries =
          reArrangeShownPages.entries.toList();
      if (reArrangeShownPages.values.elementAt(2)['position'] == pageLength) {
        pageEntries = updateEntries(pageEntries, 0, 2, 0);
      } else {
        int lastPage = reArrangeShownPages.values.last['position'] as int;
        pageEntries = updateEntries(pageEntries, 0, 2, lastPage);
      }
      reArrangeShownPages = Map.fromEntries(pageEntries);
    }

    return reArrangeShownPages;
  }

  void triggerPageLayoutReload(
      bool sideClicked, Map<String, Map<String, Object>> shownPages) {
    setState(() {
      initialShownPages = _getDisplayPages(sideClicked, shownPages);
      leftSidePage =
          initialShownPages.values.elementAt(0)['navigation'] as Widget;
      mainContentPage =
          initialShownPages.values.elementAt(1)['navigation'] as Widget;
      rightSidePage =
          initialShownPages.values.elementAt(2)['navigation'] as Widget;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<String> initialShownPagesKeys = initialShownPages.keys.toList();
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            height: 385,
            padding: const EdgeInsets.symmetric(vertical: 30),
            width: double.infinity,
            color: const Color(0xFF4DB6AC),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.black12,
                  foregroundColor: Colors.black12,
                  backgroundImage:
                      AssetImage('assets/images/joshuamangi_square_avatar.png'),
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'Joshua Mangi Masumbuo',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w100,
                    fontSize: 20.0,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: const Text(
                    'Software Engineer',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                Center(
                  child: Table(
                    children: [
                      TableRow(
                        children: List.generate(initialShownPagesKeys.length,
                            (index) {
                          String key = initialShownPagesKeys[index];
                          Widget cellContent = Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                                child: Text(
                              key,
                              style: const TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )),
                          );
                          Widget sideCellContent = Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                                child: Text(
                              key,
                              style: const TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white60,
                              ),
                            )),
                          );

                          if (index == 1) {
                            return TableCell(child: cellContent);
                          }
                          return TableCell(
                            child: InkWell(
                              onTap: () {
                                triggerPageLayoutReload(
                                    index == 2 ? false : true,
                                    initialShownPages);
                              },
                              child: sideCellContent,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Body
          // _displayContentBuilder(context),
          FractionalPeakPageView(
            leftSidePage: leftSidePage,
            mainContentPage: mainContentPage,
            rightSidePage: rightSidePage,
          ),
          // _buildWithLayoutBuilder(context),
        ],
      ),
    );
  }
}

class FractionalPeakPageView extends StatelessWidget {
  final Widget leftSidePage;
  final Widget mainContentPage;
  final Widget rightSidePage;

  const FractionalPeakPageView(
      {super.key,
      required this.leftSidePage,
      required this.mainContentPage,
      required this.rightSidePage});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: SizedBox(
        height: 400,
        child: PageView.builder(
            controller: PageController(
              viewportFraction: 0.8,
              initialPage: 1,
            ),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              if (index == 0) {
                return buildSideContainer(
                    leftSidePage, Colors.blue, screenWidth);
              } else if (index == 1) {
                return buildMainContainer(
                    mainContentPage, const Color(0xFFFFFFFF), screenWidth);
              } else {
                return buildSideContainer(
                    rightSidePage, Colors.red, screenWidth);
              }
            }),
      ),
    );
  }

  Widget buildSideContainer(
      Widget sideContainer, Color color, double screenWidth) {
    return Container(
      width: screenWidth * 0.8,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: sideContainer,
    );
  }

  Widget buildMainContainer(
      Widget mainContainer, Color color, double screenWidth) {
    return Container(
      width: screenWidth * 0.9,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: mainContainer,
    );
  }
}

/*class CenteredItem extends StatelessWidget {
  final Widget leftSidePage;
  final Widget mainContentPage;
  final Widget rightSidePage;

  CenteredItem({
    required this.leftSidePage,
    required this.mainContentPage,
    required this.rightSidePage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3040, // Fixed width of 900 pixels for each item
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Column(),
          Column(),
          Column(),
        ],
      ),
      /*child: Center(
        child: Row(
          children: [
            // Left section with fixed width (10% of 900 = 90 pixels)
            SizedBox(
              width: 1000,
              child: leftSidePage,
            ),
            // Middle section with fixed width (80% of 900 = 720 pixels)
            SizedBox(
              width: 1000,
              child: mainContentPage,
            ),
            // Right section with fixed width (10% of 900 = 90 pixels)
            SizedBox(
              width: 1000,
              child: rightSidePage, // Right-side content that may overflow
            ),
          ],
        ),
      ),*/
    );
  }
}*/
