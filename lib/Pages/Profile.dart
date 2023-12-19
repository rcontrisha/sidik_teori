import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Model/feedback_model.dart';
import 'Konversi.dart';
import 'Saran.dart';
import 'home.dart';
import 'LoginPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late int _currentIndex = 3;
  final List<Widget> _screens = [
    ForecastApp(),
    Convert(),
    FeedbackForm(),
    ProfilePage(),
  ];

  final TextEditingController _saranController = TextEditingController();
  final TextEditingController _kesanController = TextEditingController();

  Future<void> _logout() async {
    // Clear the username from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('login');

    // Navigate to the login page and remove the previous routes from the stack
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Profile Page',
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
        ),
        backgroundColor: Colors.white60,
        foregroundColor: Colors.grey[600],
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 450,
                  width: 380,
                  child: Card(
                    color: Colors.blueGrey[200],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            child: ClipOval(
                              child: Image.network(
                                'https://instagram.fjog3-1.fna.fbcdn.net/v/t51.2885-19/383721097_221519784266449_7169079857955191238_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fjog3-1.fna.fbcdn.net&_nc_cat=101&_nc_ohc=g_4cJBgmljAAX-9uTP7&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfAYo-9AdMGd107UUqeCVxj1u8sKc12719xZ-U7hfBAycw&oe=65697FFD&_nc_sid=8b3546',
                                width: 200,
                                height: 200,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                launcher('https://www.instagram.com/siddiqial_/');
                              },
                              icon: Image.network(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Instagram_logo_2022.svg/2048px-Instagram_logo_2022.svg.png',
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            'Siddiqi Albiruny',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Text(
                          '124210003',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          'Tasikmalaya, 25 Oktober 2003',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Saran:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]
                      ),
                    ),
                    TextField(
                      controller: _saranController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Masukkan saran Anda...',
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                            color: Colors.grey[600]
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[600]!)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[600]!)
                        ),
                      ),
                      cursorColor: Colors.grey[600],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Kesan:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]
                      ),
                    ),
                    TextField(
                      controller: _kesanController,
                      maxLines: 3,
                      decoration: InputDecoration(
                          hintText: 'Masukkan kesan Anda...',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[600]!)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[600]!)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[600]!)
                          ),
                          hintStyle: TextStyle(
                              color: Colors.grey[600]
                          )
                      ),
                      cursorColor: Colors.grey[600],
                    ),
                    SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () {
                        submitFeedback();
                      },
                      child: Text(
                        'Kirim',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[400]!)
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

  Future<void> launcher(String url) async {
    final Uri _url = Uri.parse(url.startsWith('http') ? url : 'https://$url');
    if (!await launchUrl(_url)) {
      throw Exception("Failed to launch URL: $_url");
    }
  }

  void submitFeedback() async {
    try {
      // Buka Hive box untuk feedback
      var feedbackBox = await Hive.openBox<FeedbackModel>('feedbackBox');

      // Buat objek FeedbackModel dari data yang dimasukkan
      FeedbackModel feedback = FeedbackModel(
        saran: _saranController.text,
        kesan: _kesanController.text,
      );

      // Simpan objek FeedbackModel ke dalam Hive box
      await feedbackBox.add(feedback);

      // Tampilkan pesan sukses atau lakukan sesuatu yang lain
      print('Feedback berhasil disimpan ke dalam Hive box.');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pesan berhasil disubmit.'),
            backgroundColor: Colors.green,
          )
      );
    } catch (e) {
      // Handle error jika ada
      print('Error: $e');
    }
  }
}
