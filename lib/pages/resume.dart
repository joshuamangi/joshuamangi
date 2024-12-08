import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joshuamangi/models/job_stint.dart';

import '../utilities/timeline_detail.dart';

class Resume extends StatelessWidget {
  const Resume({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkHistory();
  }
}

class WorkHistory extends StatelessWidget {
  WorkHistory({super.key});
  final List<TimelineDetail> timelineDetails = [];
  @override
  Widget build(BuildContext context) {
    timelineDetails.add(TimelineDetail(
      timelineYear: "Present",
      jobStint: JobStint(
          jobPosition: "System Engineer",
          company: "Save the Children",
          workFromPeriod: "May 2018",
          workToPeriod: "Present",
          workAchievements: ["Identity and Access Management"]),
    ));
    return ListView.builder(
        itemCount: timelineDetails.length,
        itemBuilder: (context, index) {
          return timelineDetails[index];
        });
  }
}
