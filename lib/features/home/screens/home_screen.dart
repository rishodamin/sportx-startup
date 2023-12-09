import 'package:flutter/material.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/features/home/widgets/address_box.dart';
import 'package:sportx/features/home/widgets/carousel_image.dart';
import 'package:sportx/features/home/widgets/deal_of_the_day.dart';
import 'package:sportx/features/home/widgets/top_categories.dart';
import 'package:sportx/features/search/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query) {
    if (query != '') {
      Navigator.pushNamed(
        context,
        SearchScreen.routeName,
        arguments: query,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(59),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      // borderRadius: BorderRadius.circular(7),
                      color: Colors.white,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        style: const TextStyle(fontSize: 17),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 4),
                          border: InputBorder.none,
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                size: 23,
                              ),
                            ),
                          ),
                          hintText: 'Search Amazon.in',
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Icon(
                      Icons.mic,
                      size: 25,
                    )),
              ],
            ),
          ),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              AddressBox(),
              SizedBox(height: 10),
              TopCategories(),
              SizedBox(height: 10),
              CarouselImage(),
              DealOfTheDay(),
            ],
          ),
        ));
  }
}
