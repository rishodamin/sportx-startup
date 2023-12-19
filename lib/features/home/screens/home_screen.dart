import 'package:flutter/material.dart';
import 'package:sportx/common/widgets/random_products.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/features/home/widgets/address_box.dart';
import 'package:sportx/features/home/widgets/carousel_image.dart';
import 'package:sportx/features/home/widgets/deal_of_the_day.dart';
import 'package:sportx/features/home/widgets/top_categories.dart';
import 'package:sportx/features/search/screens/search_screen.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  final TextEditingController _searchController = TextEditingController();

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
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    _searchController.text = "listening...";
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _searchController.text = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _speechToText.stop();
    _searchController.dispose();
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
                        controller: _searchController,
                        onFieldSubmitted: navigateToSearchScreen,
                        style: const TextStyle(fontSize: 17),
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 4),
                          border: InputBorder.none,
                          prefixIcon: InkWell(
                            child: Padding(
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
                  child: IconButton(
                      onPressed:
                          // If not yet listening for speech start, otherwise stop
                          _speechToText.isNotListening
                              ? _startListening
                              : _stopListening,
                      icon: const Icon(
                        Icons.mic,
                        size: 25,
                      )),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AddressBox(),
              const SizedBox(height: 10),
              const TopCategories(),
              const SizedBox(height: 10),
              const CarouselImage(),
              const DealOfTheDay(),
              // display random products
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  "Deals for you :)",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Builder(
                builder: (BuildContext context) => const RandomProducts(),
              ),
              //////////////////////////
            ],
          ),
        ));
  }
}
