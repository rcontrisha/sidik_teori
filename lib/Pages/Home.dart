import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projek_akhir/Pages/ForecastPage.dart';
import 'package:projek_akhir/Pages/Profile.dart';
import '../base_network.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Model/Forecast_Model.dart';
import 'Konversi.dart';
import 'Saran.dart';

class ForecastApp extends StatefulWidget {
  const ForecastApp({super.key});

  @override
  State<ForecastApp> createState() => _ForecastAppState();
}

class _ForecastAppState extends State<ForecastApp> {
  int _currentIndex = 0;
  String city = 'Loading...';
  ForecastData? forecastData;
  late List<WeatherList>? filteredForecastData = [];

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  Future<void> requestPermission() async {
    final PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      fetchCityAndWeather();
    } else {
      print('Location permission denied');
    }
  }

  Future<void> fetchCityAndWeather({String? cityName}) async {
    try {
      if (cityName == null || cityName.isEmpty) {
        final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        print('Placemarks: $placemarks');

        if (placemarks.isNotEmpty) {
          final Placemark firstPlacemark = placemarks.first;
          cityName = firstPlacemark.subLocality ?? 'Unknown City';
        } else {
          print('City not found');
          return;
        }
      }

      setState(() {
        city = cityName!;
      });

      fetchForecast(city); // Pass the value accordingly
    } catch (e) {
      print('Error fetching city: $e');
    }
  }

  Future<void> fetchForecast(String cityName) async {
    try {
      var data = await WeatherApi.getForecastData(cityName);
      if (data != null) {
        setState(() {
          forecastData = ForecastData.fromJson(data);
        });
      } else {
        print('Error: Forecast data is null');
      }
    } catch (e) {
      print('Error fetching forecast data: $e');
    }
  }

  String getWeatherIconUrl(String iconCode) {
    return 'http://openweathermap.org/img/wn/$iconCode.png';
  }

  String _getFormattedDate(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy').format(dateTime);
  }

  Widget buildWeatherCard(
      WeatherList weatherListItem, String formattedDate, String tanggal) {
    if (formattedDate.isNotEmpty) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ForecastPage(tanggal: '$tanggal', cityName: '$city',)
              )
          );
        },
        child: ListTile(
          contentPadding: EdgeInsets.fromLTRB(8, 3, 8, 3),
          leading: Image.network(
            color: Colors.blueGrey,
            getWeatherIconUrl(
                weatherListItem.weather?[0].icon ?? 'defaultIconCode'),
            height: 65,
            width: 55,
            fit: BoxFit.fill,
          ),
          title: Text(
            formattedDate,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    Set<String> processedDates = Set<String>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          city,
          style:
              TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: (forecastData?.list?.length)! - 1 ?? 0,
        itemBuilder: (BuildContext context, int index) {
          final WeatherList weatherListItem = forecastData?.list?[index + 1] ?? WeatherList();
          final formattedDate = _getFormattedDate(DateTime.parse(weatherListItem.dtTxt!));
          final tanggal = '${DateTime.parse(weatherListItem.dtTxt!).year}-${DateTime.parse(weatherListItem.dtTxt!).month}-${DateTime.parse(weatherListItem.dtTxt!).day.toString().padLeft(2, '0')}';
          bool isFirstForecastForDay = processedDates.add(formattedDate);

          if (isFirstForecastForDay) {
            return buildWeatherCard(weatherListItem, formattedDate, tanggal);
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pinkAccent,
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 1) {
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

  String capitalizeEachWord(String input) {
    List<String> words = input.split(' ');
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }
    return words.join(' ');
  }
}
