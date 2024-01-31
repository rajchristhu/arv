import 'dart:developer';
import 'package:arv/shared/availability_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:arv/models/request/order.dart';
import 'package:arv/models/response_models/addresses.dart';
import 'package:arv/models/response_models/cart_list.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:arv/shared/navigation_service.dart';
import 'package:arv/shared/utils.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/custom_progress_bar.dart';
import 'package:arv/utils/secure_storage.dart';
import 'package:arv/views/order_page/input_box.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class CartValue extends StatefulWidget {
  const CartValue({
    super.key,
  });

  @override
  State<CartValue> createState() => _CartValueState();
}

class _CartValueState extends State<CartValue> {
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController addressLine1 = TextEditingController();
  final TextEditingController addressLine2 = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController pinCode = TextEditingController();
  final TextEditingController stateOrRegion = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController landmark = TextEditingController();
  final TextEditingController paymentMode =
      TextEditingController(text: "Cash On Delivery ( COD )");
  MainScreenController mainScreenController = Get.find<MainScreenController>();

  String defaultPaymentMode = "COD";
  double? deliveryCharge = 0.0;

  String? addressId;

  @override
  void initState() {
    super.initState();
    Get.find<CartService>().updateList();
    getAddress();
    getDeliveryCharge();
  }

  getDeliveryCharge() async {
    deliveryCharge = await arvApi.getDeliveryCharge();
    deliveryCharge =
        (deliveryCharge ?? 0) + mainScreenController.getExcessDeliveryCharge();
    safeUpdate();
  }

  getAddress() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Addresses addresses = await arvApi.getAddresses();
      Address? address;
      try {
        address = addresses.addresses.first;
        log("Address there");
      } catch (e) {
        log("No Address there");
      }
      if (address != null) {
        addressId = address.id;
        name.text = address.name;
        phone.text = address.phone;
        addressLine1.text = address.addressLine1;
        addressLine2.text = address.addressLine2;
        city.text = address.area;
        pinCode.text = address.pinCode;
        stateOrRegion.text = address.state;
        country.text = address.nation;
        landmark.text = address.landMark;
      }
      safeUpdate();
    });
  }

  void safeUpdate() {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartService>(
      init: Get.find<CartService>(),
      builder: (controller) {
        double totalAmount = controller.cartTotal.orderValue;
        if (totalAmount == 0) return Container();
        return Container(
          height: 200,
          color: white,
          child: Column(
            children: [
              Container(
                height: 1.6,
                color: gray50,
                padding: const EdgeInsets.only(
                  right: 6,
                  left: 6,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Order Amount : ",
                      style: TextStyle(
                        color: black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "₹ $totalAmount",
                      style: GoogleFonts.montserrat(
                        color: black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Delivery charge : ",
                      style: TextStyle(
                        color: black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "₹ ${deliveryCharge ?? 0.0}",
                      style: GoogleFonts.montserrat(
                        color: black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total Billing Amount : ",
                      style: TextStyle(
                        color: black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "₹ ${totalAmount == 0 ? 0.0 : totalAmount + (deliveryCharge == null ? 0.0 : deliveryCharge!.toDouble())}",
                      style: GoogleFonts.montserrat(
                        color: black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 30, top: 10),
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (deliveryCharge == null || deliveryCharge == 0) {
                          utils.notify("Service not available in this area");
                        } else {
                          await getAddress();
                          // ignore: use_build_context_synchronously
                          _showBottomSheet(context, controller);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.purple,
                      ),
                      child: const Text(
                        "Place Order",
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context, CartService controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: true,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.62,
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivery Address",
                      style: TextStyle(
                        color: gray,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.home_filled,
                      color: gray,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    InputBox(
                      hintText: "Name",
                      isUsername: false,
                      labelText: "Enter Name",
                      textController: name,
                      isEnabled: true,
                    ),
                    InputBox(
                      hintText: "Contact Number",
                      isUsername: true,
                      labelText: "Contact Number (+91)",
                      textController: phone,
                      isEnabled: true,
                    ),
                    InputBox(
                      hintText: "Address Line 1",
                      isUsername: false,
                      labelText: "Address Line 1",
                      textController: addressLine1,
                      isEnabled: true,
                    ),
                    InputBox(
                      hintText: "Address Line 2",
                      isUsername: false,
                      labelText: "Address Line 2",
                      textController: addressLine2,
                      isEnabled: true,
                    ),
                    InputBox(
                      hintText: "City",
                      isUsername: false,
                      labelText: "City",
                      textController: city,
                      isEnabled: true,
                    ),
                    InputBox(
                      hintText: "Pincode",
                      isUsername: true,
                      labelText: "Pincode",
                      textController: pinCode,
                      isEnabled: true,
                    ),
                    InputBox(
                      hintText: "State",
                      isUsername: false,
                      labelText: "State",
                      textController: stateOrRegion,
                      isEnabled: true,
                    ),
                    InputBox(
                      hintText: "Country",
                      isUsername: false,
                      labelText: "Country",
                      textController: country,
                      isEnabled: true,
                    ),
                    InputBox(
                      hintText: "Landmark",
                      isUsername: false,
                      labelText: "Landmark (optional)",
                      textController: landmark,
                      isEnabled: true,
                    ),
                    InputBox(
                      hintText: "Payment Mode",
                      isUsername: false,
                      labelText: "Payment Mode",
                      textController: paymentMode,
                      isEnabled: false,
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    if (name.text != "" &&
                        phone.text != "" &&
                        addressLine1.text != "") {
                      ArvProgressDialog.instance.showProgressDialog(context);
                      Address address = Address(
                        id: addressId,
                        name: name.text,
                        phone: phone.text,
                        addressLine1: addressLine1.text,
                        addressLine2: addressLine2.text,
                        area: city.text,
                        pinCode: pinCode.text,
                        state: stateOrRegion.text,
                        nation: country.text,
                        landMark: landmark.text,
                        isDeliveryAddress: true,
                      );
                      print(
                          "$addressId, ${name.text}, ${phone.text}, ${addressLine1.text}");
                      await arvApi.addAddresses(address);
                      await Future.delayed(const Duration(seconds: 2));
                      await getAddress();
                      await Future.delayed(const Duration(seconds: 2));
                      CartList cartList = await arvApi.getCartItems(0);
                      List<OrderItem> orderItems = cartList.list
                          .map(
                            (e) => OrderItem(
                              productId: e.id!,
                              variant: e.orderProductVariation!,
                              qty: e.orderQty!,
                              itemTotalPrice: e.orderPrice ?? 0.0,
                              itemName: e.productName,
                              itemPrice: e.orderPrice,
                            ),
                          )
                          .toList();
                      Order order = Order(
                        orderItems: orderItems,
                        paymentMode: defaultPaymentMode,
                        addressId: addressId ?? "",
                        deliveryBoyTip: 0,
                        deliveryCharge: deliveryCharge!,
                        couponCode: "",
                        accessToken: await secureStorage.get("access-token"),
                      );

                      await arvApi.placeOrder(order);
                      await controller.updateList();
                      navigationService.setNavigation = 2;
                      controller.update();

                      try {
                        // ignore: use_build_context_synchronously
                        ArvProgressDialog.instance.dismissDialog(context);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      } catch (e) {
                        //
                      }
                    } else {
                      Fluttertoast.showToast(
                        msg: "Please enter the details",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey.shade700,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.purple,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: const Center(
                      child: Text(
                        "Save & Continue",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }
}
