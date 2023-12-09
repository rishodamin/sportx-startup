import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import 'package:provider/provider.dart';
import 'package:sportx/common/widgets/custom_textfield.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/constants/utils.dart';
import 'package:sportx/features/address/services/address_services.dart';
import 'package:sportx/providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String amount;
  const AddressScreen({super.key, required this.amount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController _flatBuildingController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToUsed = '';
  List<PaymentItem> paymentItems = [];
  final AddressServices _addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.amount,
        label: 'Total amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _areaController.dispose();
    _cityController.dispose();
    _flatBuildingController.dispose();
    _pincodeController.dispose();
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      _addressServices.saveUserAddress(
          context: context, address: addressToUsed);
    }
    _addressServices.placeOrder(
      context: context,
      address: addressToUsed,
      totalSum: double.parse(widget.amount),
    );
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      _addressServices.saveUserAddress(
          context: context, address: addressToUsed);
    }
    _addressServices.placeOrder(
      context: context,
      address: addressToUsed,
      totalSum: double.parse(widget.amount),
    );
  }

  void payPressed(String addressFromProvider) {
    addressToUsed = '';

    bool isForm = _flatBuildingController.text.isNotEmpty ||
        _areaController.text.isNotEmpty ||
        _cityController.text.isNotEmpty ||
        _pincodeController.text.isNotEmpty ||
        Provider.of<UserProvider>(context, listen: false).user.address.isEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToUsed =
            '${_flatBuildingController.text}, ${_areaController.text}, ${_cityController.text} - ${_pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
    print(addressToUsed);
    ///////////  Testing
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      _addressServices.saveUserAddress(
          context: context, address: addressToUsed);
    }
    _addressServices.placeOrder(
      context: context,
      address: addressToUsed,
      totalSum: double.parse(widget.amount),
    );
    /////////////////////////
  }

  @override
  Widget build(BuildContext context) {
    var address = Provider.of<UserProvider>(context).user.address;
    //  address = '101 - fakestreet';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(59),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomText(
                      controller: _flatBuildingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      controller: _areaController,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      controller: _pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      controller: _cityController,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ApplePayButton(
                onPressed: () => payPressed(address),
                width: double.infinity,
                style: ApplePayButtonStyle.whiteOutline,
                type: ApplePayButtonType.buy,
                onPaymentResult: onApplePayResult,
                paymentConfigurationAsset: 'applepay.json',
                paymentItems: paymentItems,
                height: 50,
                margin: const EdgeInsets.only(top: 15),
              ),
              const SizedBox(height: 10),
              GooglePayButton(
                onPressed: () => payPressed(address),
                width: double.infinity,
                margin: const EdgeInsets.only(top: 15),
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
                paymentConfigurationAsset: 'gpay.json',
                height: 50,
                type: GooglePayButtonType.buy,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
