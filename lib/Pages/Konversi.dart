import 'package:flutter/material.dart';
import '../Pages/Uang.dart';
import '../Pages/Waktu.dart';
import '../Pages/home.dart';
import '../Pages/Saran.dart';
import '../Pages/Profile.dart';

class Convert extends StatefulWidget {
  const Convert({super.key});

  @override
  State<Convert> createState() => _ConvertState();
}

class _ConvertState extends State<Convert> {
  int _currentIndex = 1;
  final List<Widget> _screens = [
    ForecastApp(),
    Convert(),
    FeedbackForm(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Konversi',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[600],
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CurrencyConverter()));
              },
              child: Container(
                height: 190,
                width: 190,
                child: Card(
                  color: Colors.grey[400],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.currency_exchange,
                          color: Colors.white,
                          size: 80,
                        ),
                        SizedBox(height: 20),
                        Text(
                            'Konversi Mata\nUang',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),
                            textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 5),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TimeConverter()));
              },
              child: Container(
                height: 190,
                width: 190,
                child: Card(
                  color: Colors.grey[400],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.white,
                        size: 80,
                      ),
                      SizedBox(height: 20),
                      Text(
                          'Konversi\nWaktu',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                          textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
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
          } if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FeedbackForm()),
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
