import 'package:flutter/material.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    const imageUrl = "assets/images/joshuamangi_square_avatar.png";
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
