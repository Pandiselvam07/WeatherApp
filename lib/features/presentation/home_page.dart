import 'dart:convert';
import 'dart:ui';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:country_explorer/core/utilities/widgets/additionl_info_item.dart';
import 'package:country_explorer/core/utilities/widgets/custom_search_bar.dart';
import 'package:country_explorer/core/utilities/widgets/custom_text.dart';
import 'package:country_explorer/core/utilities/widgets/hourly_forecast_items.dart';
import 'package:http/http.dart' as http;

import '../../core/utilities/widgets/secrets.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;
  const HomePage(
      {super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> weather = Future.value({});
  static TextEditingController searchController = TextEditingController();

  Future<void> fetchWeather() async {
    try {
      final cityName = searchController.text.trim();
      if (cityName.isEmpty) return;

      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey',
        ),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'City not found';
      }

      setState(() {
        weather = Future.value(data);
      });
    } catch (e) {
      setState(() {
        weather = Future.error(e.toString());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    searchController.text = "London"; // Default city
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            top: screenHeight * 0.05,
            left: screenWidth * 0.025,
            right: screenWidth * 0.02),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'Explore',
                  size: screenWidth * 0.08,
                ),
                IconButton(
                    onPressed: widget.toggleTheme,
                    icon:
                        Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode)),
              ],
            ),
            SizedBox(height: screenHeight * 0.004),
            Row(
              children: [
                SizedBox(width: screenWidth * 0.06),
                CustomText(
                  'Weather',
                  size: screenWidth * 0.07,
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: CustomSearchBar(
                    width: screenWidth * 0.08,
                    hintText: 'Search',
                    controller: searchController,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: fetchWeather,
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.045),
            FutureBuilder(
                future: weather,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data!['list'] == null) {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  final data = snapshot.data!;
                  final currentWeatherData = data['list'][0];

                  final currentTemp =
                      (currentWeatherData['main']['temp'] - 273.15)
                          .toStringAsFixed(1);
                  final currentSky = currentWeatherData['weather'][0]['main'];
                  final currentPressure =
                      currentWeatherData['main']['pressure'];
                  final currentWindSpeed = currentWeatherData['wind']['speed'];
                  final currentHumidity =
                      currentWeatherData['main']['humidity'];
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.2,
                            width: double.infinity,
                            child: Card(
                              elevation: screenWidth * 0.008,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      screenWidth * 0.08)),
                              child: ClipRect(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomText(
                                        '$currentTemp °C',
                                        size: screenWidth * 0.08,
                                      ),
                                      Icon(
                                        currentSky == 'Clouds' ||
                                                currentSky == 'Rain'
                                            ? Icons.cloud
                                            : Icons.sunny,
                                        size: screenWidth * 0.1,
                                      ),
                                      CustomText(
                                        currentSky,
                                        size: screenWidth * 0.06,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.025),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                'Weather Forecast',
                                size: screenWidth * 0.06,
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              SizedBox(
                                height: screenHeight * 0.13,
                                child: ListView.builder(
                                  itemCount: 12,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final hourlyForecast =
                                        data['list'][index + 1];
                                    final hourlySky = data['list'][index + 1]
                                        ['weather'][0]['main'];
                                    final hourlyTemp = (hourlyForecast['main']
                                                ['temp'] -
                                            273.15)
                                        .toStringAsFixed(1);

                                    final time = DateTime.parse(
                                        hourlyForecast['dt_txt']);
                                    return HourlyForecastItem(
                                      time: DateFormat.j().format(time),
                                      temperature: hourlyTemp + ' °C',
                                      icon: hourlySky == 'Clouds' ||
                                              hourlySky == 'Rain'
                                          ? Icons.cloud
                                          : Icons.sunny,
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.025),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                'Additional Info',
                                size: screenWidth * 0.06,
                              ),
                              SizedBox(height: screenHeight * 0.03),
                              SizedBox(
                                height: screenHeight * 0.13,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      AdditionalInfoItem(
                                        icon: Icons.water_drop,
                                        label: 'Humidity',
                                        value: currentHumidity.toString(),
                                      ),
                                      AdditionalInfoItem(
                                        icon: Icons.air,
                                        label: 'Wind Speed',
                                        value: currentWindSpeed.toString(),
                                      ),
                                      AdditionalInfoItem(
                                        icon: Icons.beach_access,
                                        label: 'Pressure',
                                        value: currentPressure.toString(),
                                      ),
                                    ]),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
