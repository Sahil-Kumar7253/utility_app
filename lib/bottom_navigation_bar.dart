import 'package:flutter/material.dart';
import 'package:utility_app/features/CurrencyConverter/Converter_page.dart';
import 'package:utility_app/features/weather/weather_page.dart';

class BottomNavBarExample extends StatefulWidget {
  @override
  _BottomNavBarExampleState createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBarExample> {
  int _currentIndex = 0;

  // List of screens for the navigation
  final List<Widget> _screen = [
    const WeatherPage(),
    const ConverterPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed, // Ensures text and icons are shown
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_cloudy_rounded),
            label: 'Weather',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'News',
          ),
        ],
      ),
    );
  }
}