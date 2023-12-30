import 'package:flutter/material.dart';

String uri = "https://remise.up.railway.app";
//String uri = 'http://192.168.209.41:3000'; //mine-209//mom-210//rido-211

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromRGBO(240, 240, 240, 1),
      Colors.white,
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(97, 97, 97, 1);
  static const backgroundColor = Colors.white;
  static const lightGray = Color.fromRGBO(0, 0, 0, 0.03);
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static const selectedNavBarColor = Color.fromRGBO(97, 97, 97, 1);
  static const unselectedNavBarColor = Colors.black87;
  static const lightBlueColor = Color.fromRGBO(216, 240, 253, 1);
  static const lightPinkColor = Color.fromRGBO(255, 182, 193, 0.5);
  static const halfWhiteColor = Color.fromRGBO(254, 240, 227, 1);
  static const remiseBlueColor = Color.fromRGBO(56, 213, 231, 1);

  // STATIC IMAGES
  // static const List<String> carouselImages = [
  //   'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
  //   'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
  //   'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
  //   'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
  //   'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  // ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobiles.jpeg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/essentials.jpeg',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliances.jpeg',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books.jpeg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion.jpeg',
    },
  ];

  static const String googleLogo =
      'https://www.google.com/images/hpp/ic_wahlberg_product_core_48.png8.png';
}
