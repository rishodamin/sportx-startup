import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            'Deal of the day',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Image.network(
          'https://www.blue-gauntlet.com/cdn-cgi/image/quality%3D85/assets/images/silky%20womn%20frnt.jpg',
          height: 235,
          fit: BoxFit.fitHeight,
        ),
        Container(
          padding: const EdgeInsets.only(left: 15),
          alignment: Alignment.topLeft,
          child: const Text(
            '\$999',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text(
            'ALLSTAR ULTRALIGHT ELECTRIC LAME SABER',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                'https://images-cdn.ubuy.com.sa/63b6e4adbef586615456f8f6-radical-fencing-pbt-electric-sabre-foil.jpg',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://images-cdn.ubuy.com.sa/63b6e4adbef586615456f8f6-radical-fencing-pbt-electric-sabre-foil.jpg',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://images-cdn.ubuy.com.sa/63b6e4adbef586615456f8f6-radical-fencing-pbt-electric-sabre-foil.jpg',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://images-cdn.ubuy.com.sa/63b6e4adbef586615456f8f6-radical-fencing-pbt-electric-sabre-foil.jpg',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
          alignment: Alignment.topLeft,
          child: Text('See all deals',
              style: TextStyle(
                color: Colors.cyan[800],
              )),
        )
      ],
    );
  }
}
