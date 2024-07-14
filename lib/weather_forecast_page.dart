import 'package:flutter/material.dart';

class WeatherForecastPage extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;
  final Color color;
  const WeatherForecastPage({
    super.key,
    required this.time,
    required this.temperature,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),
            Icon(
              icon,
              size: 35,
              color: color,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              temperature,
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}

 // Container(
              //   height: 240,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     boxShadow: [
              //       BoxShadow(
              //           blurStyle: BlurStyle.outer,
              //           blurRadius: 5,
              //           spreadRadius: 0,
              //           color: Colors.grey.shade600)
              //     ],
              //     color: Colors.grey.shade800,
              //     borderRadius: BorderRadius.circular(15),
              //   ),
              //   child: const Column(
              //     children: [
              //       SizedBox(
              //         height: 10,
              //       ),
              //       Text(
              //         "300.74°F",
              //         style:
              //             TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(
              //         height: 5,
              //       ),
              //       Icon(
              //         Icons.cloud_sharp,
              //         size: 80,
              //       ),
              //       SizedBox(
              //         height: 15,
              //       ),
              //       Text(
              //         "Rain",
              //         style: TextStyle(
              //           fontSize: 25,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),