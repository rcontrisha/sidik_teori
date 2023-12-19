import '../Model/feedback_model.dart';
import '../Pages/Konversi.dart';
import '../Pages/Profile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Pages/home.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  late int _currentIndex = 2;
  final List<Widget> _screens = [
    ForecastApp(),
    Convert(),
    FeedbackForm(),
    ProfilePage(),
  ];

  late Box<FeedbackModel> feedbackBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Saran dan Kesan',
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[600],
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<FeedbackModel>('feedbackBox').listenable(),
          builder: (BuildContext context, Box<FeedbackModel> box, _) {
            if (box.values.isEmpty) {
              return Center(
                child: Text('Feedback is empty.'),
              );
            }
            return ListView.builder(
                itemCount: box.values.length,
                itemBuilder: (context, index) {
                  FeedbackModel? kesan = box.getAt(index);
                  return ListTile(
                    leading: Icon(
                        Icons.chat_outlined
                    ),
                    title: Text(
                      'Kesan: ${kesan?.kesan}'
                    ),
                    subtitle: Text(
                      'Saran: ${kesan?.saran}'
                    ),
                  );
                }
            );
          },
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal[700],
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ForecastApp()),
            );
          } if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Convert()),
            );
          } if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Beranda',
              backgroundColor: Colors.grey[700]
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.autorenew_rounded),
              label: 'Konversi',
              backgroundColor: Colors.grey[700]
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.feed_outlined),
              label: 'Feedback',
              backgroundColor: Colors.grey[700]
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Profile',
              backgroundColor: Colors.grey[700]
          ),
        ],
      ),
    );
  }
}
