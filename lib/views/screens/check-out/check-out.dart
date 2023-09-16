// ignore_for_file: depend_on_referenced_packages, file_names, use_build_context_synchronously, unnecessary_cast

import 'dart:convert';
import 'package:albaydar/AppWords.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import '../../../constants/util.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import '../../../main.dart';
import '../../../models/Payment.dart';
import '../../widgets/animation/animated_switcher_wrapper.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController deliverylocationController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  String address = "Not Selected";
  String autocompletePlace = "Not Selected";
  String selectedTerm = "Not Selected";
  bool isTrust = false;
  bool _isLoading = false;

  @override
  void initState() {
    getPaymentsMethod();
    super.initState();
  }

  PaymentTerm paymentValue = PaymentTerm();

  List<PaymentTerm> payments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppWords.checkOut.tr),
      ),
      body: Column(
        children: [
          _isLoading
              ? SpinKitPulsingGrid(
                  itemBuilder: (BuildContext context, int index) {
                    return const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.teal,
                      ),
                    );
                  },
                )
              : Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  AppWords.Location.tr,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal),
                                ),
                              ],
                            ),
                            const Expanded(
                                flex: 9,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Divider(
                                          thickness: 3,
                                          color: Colors.teal,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      PlacesAutocomplete(
                        searchController: deliverylocationController,
                        apiKey: "AIzaSyB_k7NaX_zJsYGSndy9Ty70qeJtsYxagog",
                        mounted: mounted,
                        hideBackButton: true,
                        onGetDetailsByPlaceId: (PlacesDetailsResponse? result) {
                          if (result != null) {
                            setState(() {
                              autocompletePlace =
                                  result.result.formattedAddress ?? "";
                            });
                          }
                        },
                      ),
                      ListTile(
                        title: Text(
                            "${AppWords.AutocompleteAddress.tr}: $autocompletePlace"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  AppWords.PaymentTerm.tr,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal),
                                ),
                              ],
                            ),
                            // Text("Location")
                            const Expanded(
                                flex: 9,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Divider(
                                          thickness: 3,
                                          color: Colors.teal,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      payments.isEmpty
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                height: 55,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.teal),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                padding: const EdgeInsets.all(15),
                                child: DropdownButton(
                                  underline: Container(),
                                  iconSize: 25,
                                  elevation: 3,
                                  value: paymentValue,
                                  isExpanded: true,
                                  icon: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  items: payments.map((payment) {
                                    return DropdownMenuItem(
                                      value: payment,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          payment.PaymentName.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedTerm =
                                          newValue!.PaymentName.toString();
                                      paymentValue = newValue as PaymentTerm;
                                    });
                                  },
                                ),
                              ),
                            ),
                      ListTile(
                        title:
                            Text("${AppWords.SelectedTerm.tr}: $selectedTerm"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  AppWords.OrderNotes.tr,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal),
                                ),
                              ],
                            ),
                            const Expanded(
                                flex: 9,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Divider(
                                          thickness: 3,
                                          color: Colors.teal,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.teal),
                              borderRadius: BorderRadius.circular(10)),
                          height: 120,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: noteController,
                              style: const TextStyle(fontSize: 16),
                              maxLines: 4,
                              minLines: 3,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: (AppWords.LeaveANoteHere.tr)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          bottomBarTitle(),
          bottomBarButton()
        ],
      ),
    );
  }

  Widget bottomBarTitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppWords.Total.tr,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
          Obx(
            () {
              return AnimatedSwitcherWrapper(
                child: Text(
                  "\$${productController.totalPrice.value}",
                  key: ValueKey<double>(productController.totalPrice.value),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFEC6813),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget bottomBarButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
          onPressed: () {
            sendOrder();
          },
          child: Text(AppWords.ApplyOrder.tr),
        ),
      ),
    );
  }

  getPaymentsMethod() async {
    var fullUrl = Uri.parse("${Util.serverBaseUrl}Payment/get-all-payments");
    try {
      http.Response response = await http.get(fullUrl);

      if (response.statusCode == 200) {
        setState(() {
          // _isLoading = false;
        });
        if (mounted) {
          var data = json.decode(response.body);
          if (data != null) {
            for (var element in data) {
              setState(() {
                payments.add(PaymentTerm(
                    PaymentArabicName: element['paymentArabicName'].toString(),
                    PaymentId: int.parse(element['paymentId'].toString()),
                    PaymentName: element['paymentName'].toString(),
                    PaymentStatus: element['paymentStatus']));
              });
            }
            setState(() {
              paymentValue = PaymentTerm(
                  PaymentArabicName: data[0]['paymentArabicName'].toString(),
                  PaymentId: int.parse(data[0]['paymentId'].toString()),
                  PaymentName: data[0]['paymentName'].toString(),
                  PaymentStatus: data[0]['paymentStatus']);
              selectedTerm = paymentValue.PaymentName.toString();
            });
          }
        }
      } else if (response.statusCode == 401) {
        if (mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.WARNING,
            animType: AnimType.SCALE,
            title: 'Unauthorized',
            desc: 'Your session has been expired....',
            btnCancelText: 'ok',
            onDissmissCallback: (type) {
              if (type != DismissType.BTN_OK) {
                Navigator.pop(context);
              }
            },
            btnCancelOnPress: () {
              Navigator.pop(context);
            },
          ).show();
        }
      } else {
        if (mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            title: 'error',
            desc: 'errorappearing',
            btnCancelOnPress: () {},
            btnCancelText: 'cancel',
          ).show();
        }
      }
    } catch (e) {
      if (mounted) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: 'error',
          desc: e.toString(),
          btnCancelOnPress: () {},
          btnCancelText: 'cancel',
        ).show();
      }
    }
  }

  sendOrder() async {
    setState(() {
      _isLoading = true;
    });
    var fullUrl = Uri.parse("${Util.serverBaseUrl}Order/add-new-order");
    String? cartXML = buildXMLItems();
    try {
      var body = jsonEncode({
        "OrderDate": "28-08-2023",
        "OrderValue": double.parse(productController.totalPrice.toString()),
        "CustomerId": 2, //customerController.customerInfo.CustomerId,
        "PaymentId": int.parse(paymentValue.PaymentId.toString()),
        "OrderLocation": deliverylocationController.text.toString(),
        "Item_XML": cartXML
      });
      http.Response response = await http.post(
        fullUrl,
        headers: {'content-type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.SCALE,
            title: 'Done',
            desc: 'Your Order Sended',
            btnOkText: 'ok',
            btnOkOnPress: () {
              Navigator.pop(context);
            },
          ).show();
        }
      } else if (response.statusCode == 401) {
        if (mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.WARNING,
            animType: AnimType.SCALE,
            title: 'Unauthorized',
            desc: 'Your session has been expired....',
            btnCancelText: 'ok',
            onDissmissCallback: (type) {
              if (type != DismissType.BTN_OK) {
                Navigator.pop(context);
              }
            },
            btnCancelOnPress: () {
              Navigator.pop(context);
            },
          ).show();
        }
      } else {
        if (mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            title: 'error',
            desc: 'errorappearing',
            btnCancelOnPress: () {},
            btnCancelText: 'cancel',
          ).show();
        }
      }
    } catch (e) {
      if (mounted) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: 'error',
          desc: e.toString(),
          btnCancelOnPress: () {},
          btnCancelText: 'cancel',
        ).show();
      }
    }
  }

  String buildXMLItems() {
    final builder = XmlBuilder();
    String xmlSTR = '';
    var items = productController.cartProducts;
    if (items.isNotEmpty) {
      builder.element('Items', nest: () {
        for (var item in items) {
          builder.element('Item', nest: () {
            builder.element('OrderId', nest: 0);
            builder.element('ProductId', nest: item.productId);
            builder.element('Qty', nest: item.quantity);
            builder.element('TotalPrice', nest: item.productPrice);
            builder.element('Note', nest: "");
          });
        }
      });
    }
    var documeddnt = builder.buildDocument();

    xmlSTR = documeddnt.toXmlString(pretty: true, indent: '\t');

    return xmlSTR;
  }
}
