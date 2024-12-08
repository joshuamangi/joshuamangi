import "package:flutter/material.dart";
import "package:joshuamangi/common/detail_box.dart";
import "package:joshuamangi/models/job_stint.dart";

class TimelineDetail extends StatelessWidget {
  final String timelineYear;

  final JobStint jobStint;

  const TimelineDetail(
      {super.key, required this.timelineYear, required this.jobStint});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Center(
        child: Row(
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Text(timelineYear),
                ),
              ],
            ),
            SizedBox(
              width: 30,
            ),
            Column(
              children: [
                DetailBox(content: jobStint),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
