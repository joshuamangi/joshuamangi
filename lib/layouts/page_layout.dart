import 'dart:core';

import 'package:flutter/material.dart';

class PageLayout extends StatefulWidget {
  const PageLayout({super.key});

  @override
  State<PageLayout> createState() => _PageLayoutState();
}

// Page Layout State
class _PageLayoutState extends State<PageLayout> {
  // Map of all pages
  final Map<String, Map<String, dynamic>> pages = {
    'portfolio': {'position': 1, 'navigation': Portfolio()},
    'about me': {'position': 2, 'navigation': About_Me()},
    'resume': {'position': 3, 'navigation': Resume()},
    'activity': {'position': 4, 'navigation': Activity()},
    'contact': {'position': 5, 'navigation': Contact()},
  };
  Map<String, Map<String, dynamic>> initialShownPages = {};
  _PageLayoutState() {
    initialShownPages = _initializeShownPages();
  }

  Map<String, Map<String, dynamic>> _initializeShownPages() {
    return Map.fromEntries(pages.entries.take(3));
  }

  Map<String, Map<String, dynamic>> _getDisplayPages(
    bool sideClicked,
    Map<String, Map<String, dynamic>> reArrangeShownPages,
  ) {
    int pageLength = pages.length;

    List<MapEntry<String, Map<String, dynamic>>> _updateEntries(
      List<MapEntry<String, Map<String, dynamic>>> entries,
      int removeIndex,
      int insertIndex,
      int pageIndex,
    ) {
      entries.removeAt(removeIndex);
      MapEntry<String, Map<String, dynamic>> newEntry = MapEntry(
        pages.keys.elementAt(pageIndex),
        pages.values.elementAt(pageIndex),
      );
      entries.insert(insertIndex, newEntry);
      return entries;
    }

    if (sideClicked) {
      List<MapEntry<String, Map<String, dynamic>>> pageEntries =
          reArrangeShownPages.entries.toList();
      if (reArrangeShownPages.values.first['position'] == 1) {
        int workingIndex = pageLength - 1;
        pageEntries = _updateEntries(pageEntries, 2, 0, workingIndex);
      } else {
        int firstPage = reArrangeShownPages.values.first['position'];
        int pageToAdd = firstPage - 2;
        pageEntries = _updateEntries(pageEntries, 2, 0, pageToAdd);
      }
      reArrangeShownPages = Map.fromEntries(pageEntries);
    } else {
      List<MapEntry<String, Map<String, dynamic>>> pageEntries =
          reArrangeShownPages.entries.toList();
      if (reArrangeShownPages.values.elementAt(2)['position'] == pageLength) {
        pageEntries = _updateEntries(pageEntries, 0, 2, 0);
      } else {
        int lastPage = reArrangeShownPages.values.last['position'];
        pageEntries = _updateEntries(pageEntries, 0, 2, lastPage);
      }
      reArrangeShownPages = Map.fromEntries(pageEntries);
    }

    return reArrangeShownPages;
  }

  void triggerPageReload(
      bool sideClicked, Map<String, Map<String, dynamic>> shownPages) {
    setState(() {
      initialShownPages = _getDisplayPages(sideClicked, shownPages);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> initialShownPagesKeys = initialShownPages.keys.toList();
    return Scaffold(
      body: Column(
        // Header
        children: [
          Container(
            height: 385,
            padding: const EdgeInsets.symmetric(vertical: 30),
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.black12,
                  foregroundColor: Colors.black12,
                  backgroundImage:
                      AssetImage('assets/images/joshuamangi_square_avatar.png'),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const Text(
                  'Joshua Mangi Masumbuo',
                  style: TextStyle(
                    color: Colors.white,
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
                                fontSize: 25.0,
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
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white60,
                              ),
                            )),
                          );

                          if (index == 1) {
                            // Middle cell, not clickable
                            return TableCell(child: cellContent);
                          }
                          if (index == 2) {
                            return TableCell(
                              child: InkWell(
                                onTap: () {
                                  triggerPageReload(false, initialShownPages);
                                },
                                child: sideCellContent,
                              ),
                            );
                          } else {
                            // Clickable cells
                            return TableCell(
                              child: InkWell(
                                onTap: () {
                                  triggerPageReload(true, initialShownPages);
                                },
                                child: sideCellContent,
                              ),
                            );
                          }
                        }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Contact {}

class Activity {}

class Resume {}

class About_Me {}

class Portfolio {}
