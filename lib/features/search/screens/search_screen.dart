import 'package:flutter/material.dart';
import 'package:sportx/common/widgets/loader.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/features/home/widgets/address_box.dart';
import 'package:sportx/features/product_details/screens/product_details_screen.dart';
import 'package:sportx/features/search/services/search_services.dart';
import 'package:sportx/features/search/widget/searched_product.dart';
import 'package:sportx/models/product_models/product.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({
    super.key,
    required this.searchQuery,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  fetchSearchedProduct() async {
    products = await searchServices.fetchSearchedPoducts(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    if (query != '') {
      Navigator.pushNamed(
        context,
        SearchScreen.routeName,
        arguments: query,
      );
    }
  }

  void navigateToProductDetailScreen(Product product) {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: {
        'product': product,
        'searchQuery': widget.searchQuery,
      },
    );
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
                        initialValue: widget.searchQuery,
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
        body: products == null
            ? const Loader()
            : Column(
                children: [
                  const AddressBox(),
                  const SizedBox(height: 10),
                  Expanded(
                      child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          splashColor: GlobalVariables.lightGray,
                          onTap: () =>
                              navigateToProductDetailScreen(products![index]),
                          child: SearchedProduct(product: products![index]));
                    },
                  ))
                ],
              ));
  }
}
