import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import 'package:provider/provider.dart';
import 'package:sportx/common/widgets/custom_button.dart';
import 'package:sportx/common/widgets/custom_textfield.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/constants/utils.dart';
import 'package:sportx/features/address/services/address_services.dart';
import 'package:sportx/features/cart/widgets/cart_subtotal.dart';
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
  final TextEditingController _phoneNumberController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToUsed = 'Select an address';
  List<String> address = [
    'Select an address',
  ];
  bool isAddingAddress = false;
  bool isLoading = false;
  final AddressServices _addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    address += Provider.of<UserProvider>(context, listen: false).user.address;
  }

  @override
  void dispose() {
    super.dispose();
    _areaController.dispose();
    _cityController.dispose();
    _flatBuildingController.dispose();
    _pincodeController.dispose();
    _phoneNumberController.dispose();
  }

  Future<void> delete() async {
    address.remove(addressToUsed);
    await _addressServices.saveUserAddress(
        context: context, address: address.sublist(1));
    addressToUsed = 'Select an address';
  }

  Future<void> save() async {
    if (_addressFormKey.currentState!.validate()) {
      addressToUsed =
          '${_flatBuildingController.text}, ${_areaController.text},\n${_cityController.text} - ${_pincodeController.text},\nPhone no: ${_phoneNumberController.text}.';
    } else {
      throw Exception('Please enter all the values!');
    }
    address.insert(1, addressToUsed);
    await _addressServices.saveUserAddress(
        context: context, address: address.sublist(1));
    _areaController.text = '';
    _cityController.text = '';
    _flatBuildingController.text = '';
    _pincodeController.text = '';
    _phoneNumberController.text = '';
  }

  Future<bool> placeOrder() async {
    if (addressToUsed == 'Select an address') {
      showSnackBar(context, addressToUsed);
      return false;
    }
    await _addressServices.placeOrder(
      context: context,
      address: addressToUsed,
      totalSum: double.parse(widget.amount),
    );
    return true;
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
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CartSubtotal(),
              const SizedBox(height: 15),
              Container(
                color: Colors.black12.withOpacity(0.08),
                height: 1,
              ),
              const Text(
                'Deliver to',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 30),
              if (addressToUsed != "Select an address")
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 250,
                              child: Text(
                                addressToUsed,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  await delete();
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              if (address.length > 1)
                SizedBox(
                  //   padding: const EdgeInsets.only(left: 7),
                  width: double.infinity,
                  child: DropdownButton(
                    underline: const SizedBox(),
                    // isDense: true,
                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        addressToUsed = value!;
                      });
                    },
                    value: addressToUsed,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: address.map((i) {
                      return DropdownMenuItem(
                          value: i,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 0.2),
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromRGBO(0, 0, 0, 0.2),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              i,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ));
                    }).toList(),
                  ),
                ),
              (!isAddingAddress)
                  ? Column(
                      children: [
                        const SizedBox(height: 30),
                        if (address.length > 1)
                          const Text(
                            'OR',
                            style: TextStyle(fontSize: 18),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: CustomButton(
                            color: GlobalVariables.selectedNavBarColor
                                .withOpacity(0.7),
                            text: 'Add a new address',
                            onTap: () => setState(() {
                              isAddingAddress = true;
                            }),
                          ),
                        ),
                      ],
                    )
                  : Form(
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
                            type: TextInputType.number,
                          ),
                          const SizedBox(height: 10),
                          CustomText(
                            controller: _cityController,
                            hintText: 'Town/City',
                          ),
                          const SizedBox(height: 10),
                          CustomText(
                            controller: _phoneNumberController,
                            hintText: 'Phone no',
                            type: TextInputType.number,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 100,
                                child: CustomButton(
                                  color: Colors.white,
                                  text: 'Cancel',
                                  onTap: () => setState(() {
                                    isAddingAddress = false;
                                  }),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: isLoading
                                    ? CustomButton(
                                        text: 'Saving..', onTap: () {})
                                    : CustomButton(
                                        text: 'Save',
                                        onTap: () async {
                                          isLoading = true;
                                          setState(() {});
                                          await save();
                                          isAddingAddress = false;
                                          isLoading = false;
                                          setState(() {});
                                        },
                                      ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: isAddingAddress
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomButton(
                color: Colors.yellow[600],
                text: 'Proceed to Pay',
                onTap: () async {
                  bool result = await placeOrder();
                  if (result) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
