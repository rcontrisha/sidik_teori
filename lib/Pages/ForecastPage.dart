import 'package:flutter/material.dart';
import '../base_network.dart';
import '../Model/Forecast_Model.dart';
import 'package:intl/intl.dart';

class ForecastPage extends StatefulWidget {
  final String tanggal;
  final String cityName;

  const ForecastPage({Key? key, required this.tanggal, required this.cityName})
      : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  List<WeatherList> listForecast = [];

  String _getFormattedDate(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy').format(dateTime);
  }

  String getWeatherIconUrl(String iconCode) {
    return 'http://openweathermap.org/img/wn/$iconCode.png';
  }

  Future<void> fetchForecast(String cityName) async {
    try {
      var data = await WeatherApi.getForecastData(cityName);
      print('Fetched data: $data'); // Add this line for debugging
      final list = ForecastData.fromJson(data);
      if (list != null) {
        setState(() {
          listForecast = list.list ?? [];
        });
      } else {
        print('Error: Forecast data is null');
      }
    } catch (e) {
      print('Error fetching forecast data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchForecast(widget.cityName);
  }

  @override
  Widget build(BuildContext context) {
    List<WeatherList> filteredData = listForecast.where((data) {
      return data.dtTxt != null && data.dtTxt!.startsWith(widget.tanggal);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(_getFormattedDate(DateTime.parse(widget.tanggal))),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          WeatherList data = filteredData[index];
          return ExpansionTile(
            leading: Image.network(getWeatherIconUrl(data.weather?[0].icon ?? 'defaultIconCode')),
            title: Text('${_getFormattedDate(DateTime.parse(data.dtTxt!))}' ?? ''),
            subtitle: Text('${DateTime.parse(data.dtTxt!).hour.toString().padLeft(2, '0')} : ${DateTime.parse(data.dtTxt!).minute.toString().padLeft(2, '0')}'),
            trailing: Text('${(data.main?.temp)?.toStringAsFixed(0)}°C', style: TextStyle(fontSize: 15)),
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 2.0,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Temperature",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${(data.main?.temp)?.toStringAsFixed(0)}°C',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Wind Speed",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${data.wind?.speed} km/h',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Humidity",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${data.main?.humidity} %',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pressure",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${data.main?.pressure} hPa',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Chance of Rain",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${(data.pop! * 100).toInt()} %',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cloudiness",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${data.clouds?.all} %',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ],
          );
        },
      ),
    );
  }
}
