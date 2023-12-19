import 'package:projek_akhir/Pages/Profile.dart';

import 'Konversi.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Saran.dart';
import 'home.dart';

class TimeConverter extends StatefulWidget {
  @override
  _TimeConverterState createState() => _TimeConverterState();
}

class _TimeConverterState extends State<TimeConverter> {
  int _currentIndex = 1;
  final List<Widget> _screens = [
    ForecastApp(),
    Convert(),
    FeedbackForm(),
    ProfilePage(),
  ];

  DateTime _currentTime = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  String _formatTime(DateTime time, String timeZone) {
    return DateFormat('HH:mm:ss', 'en_US')
        .add_jm()
        .format(time.toUtc())
        .toString() +
        ' $timeZone';
  }

  // @override
  // void initState(){
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Converter'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[600],
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 400,
          width: 380,
          child: Card(
            color: Colors.grey[400],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Waktu sekarang (UTC):',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  _formatTime(_currentTime, 'UTC'),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedTime =
                              _currentTime.toUtc().add(Duration(hours: 7));
                        });
                      },
                      child: Text(
                          'WIB',
                          style: TextStyle(
                              color: Colors.white
                          ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedTime =
                              _currentTime.toUtc().add(Duration(hours: 8));
                        });
                      },
                      child: Text(
                          'WITA',
                          style: TextStyle(
                              color: Colors.white
                          ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey)
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedTime =
                              _currentTime.toUtc().add(Duration(hours: 9));
                        });
                      },
                      child: Text(
                          'WIT',
                          style: TextStyle(
                              color: Colors.white
                          ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey)
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedTime = _currentTime;
                        });
                      },
                      child: Text(
                        'London',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey)
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentTime = DateTime.now();
                    });
                  },
                  child: Text(
                      'Refresh\nTime',
                      style: TextStyle(
                          color: Colors.white
                      ),
                      textAlign: TextAlign.center
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey)
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  'Waktu Konversi:',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  _formatTime(_selectedTime, 'GMT'),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[700],
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
