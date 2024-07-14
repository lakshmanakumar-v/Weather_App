import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'additional_information.dart';
import 'weather_forecast_page.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(),
      debugShowCheckedModeBanner: false,
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // double temp = 0;
  // bool isloader = false;
  late Future<Map<String, dynamic>> Weather;
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      // setState(() {
      //   isloader = true;
      // });
      String cityName = "england";
      final res = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=31d9347fabc7e0cd2dbfe2db3aae2927"),
      );
      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw data['message'];
      }
      return data;
      // data['list'][0]['main']['temp'];
      // isloader = false;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    Weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  Weather = getCurrentWeather();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
        centerTitle: true,
        title: const Text(
          "Weather App",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: Weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          final data = snapshot.data!;
          final currentTemp = data['list'][0]['main']['temp'];
          final currentWeather = data['list'][0]['weather'][0]['main'];
          final currentPressure = data['list'][0]['main']['pressure'];
          final currentWindSpeed = data['list'][0]['wind']['speed'];
          final currentHumdity = data['list'][0]['main']['humidity'];

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      // elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '$currentTemp K',
                                style: const TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Icon(
                                  currentWeather == 'Clouds' ||
                                          currentWeather == 'Rain'
                                      ? Icons.cloud_sharp
                                      : Icons.sunny,
                                  size: 80,
                                  color: currentWeather == 'Clouds' ||
                                          currentWeather == 'Rain'
                                      ? Colors.blue.shade200
                                      : Colors.yellow),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                currentWeather,
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Weather Forecast",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       for (int i = 0; i < 5; i++)
                  //         WeatherForecastPage(
                  //           color: currentWeather == 'Clouds' ||
                  //                   currentWeather == 'Rain'
                  //               ? Colors.yellow
                  //               : Colors.blue.shade200,
                  //           time: data['list'][i + 1]['dt_txt'].toString(),
                  //           icon: data['list'][i + 1]['weather'][0]['main'] ==
                  //                       'Clouds' ||
                  //                   data['list'][i + 1]['weather'][0]['main'] ==
                  //                       'Rain'
                  //               ? Icons.cloud_sharp
                  //               : Icons.sunny,
                  //           temperature:
                  //               data['list'][i + 1]['main']['temp'].toString(),
                  //         ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                        itemCount: 7,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final forecast = data['list'][index + 1];
                          final sky =
                              data['list'][index + 1]['weather'][0]['main'];
                          final temp = forecast['main']['temp'].toString();
                          final time = DateTime.parse(forecast['dt_txt']);
                          return WeatherForecastPage(
                              time: DateFormat.j().format(time),
                              temperature: temp,
                              icon: sky == 'Clouds' || sky == 'Rain'
                                  ? Icons.cloud_sharp
                                  : Icons.sunny,
                              color: sky == 'Clouds' || sky == 'Rain'
                                  ? Colors.blue.shade200
                                  : Colors.yellow);
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AdditionalInformation(
                          icon: Icons.water_drop,
                          text: "Humidity",
                          color: Colors.blue,
                          number: currentHumdity.toString(),
                        ),
                        AdditionalInformation(
                          icon: Icons.air,
                          text: "Wind Speed",
                          number: currentWindSpeed.toString(),
                          color: const Color.fromARGB(255, 165, 222, 10),
                        ),
                        AdditionalInformation(
                          icon: Icons.beach_access,
                          text: "Pressure",
                          number: currentPressure.toString(),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
