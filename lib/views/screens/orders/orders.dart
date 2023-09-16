// ignore_for_file: prefer_interpolation_to_compose_strings
import 'dart:convert';
import 'package:albaydar/AppWords.dart';
import 'package:albaydar/main.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../constants/util.dart';
import '../../../models/Order.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);
  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  bool _isLoading = false;
  List<CustomerOrders> orders = [];
  @override
  void initState() {
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      (AppWords.myOrders.tr),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                ]),
          ),
          Expanded(
            child: _isLoading
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitPulsingGrid(
                        itemBuilder: (BuildContext context, int index) {
                          return const DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.teal,
                            ),
                          );
                        },
                      ),
                    ],
                  ))
                : ListView.builder(
                    itemCount: orders.length,
                    //shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          child: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Card(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppWords.OrderNo.tr +
                                                  orders[index].orderRef,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              orders[index].orderDate,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      (AppWords.Total.tr) + ':',
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.grey),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      orders[index]
                                                          .orderValue
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(50))),
                                              child: MaterialButton(
                                                onPressed: () {
                                                  //navigateTo(context, const OrederDetails());
                                                },
                                                child: Text(
                                                  (AppWords.details.tr),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                                onPressed: () {},
                                                child: const Text(('delivered'),
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold)))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        )),
          )
        ],
      ),
    );
  }

  getOrders() async {
    var fullUrl = Uri.parse(
        "${Util.serverBaseUrl}Order/get-all-orders?UserId=${customerController.customerInfo.CustomerId}");
    setState(() {
      _isLoading = true;
    });
    try {
      http.Response response = await http.get(fullUrl);

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          var data = json.decode(response.body);
          if (data != null) {
            //categoryController.allCategories.clear();
            for (var element in data) {
              orders.add(CustomerOrders(
                  customerEmail: element["customerEmail"].toString(),
                  customerName: element["customerName"].toString(),
                  customerPhone: element["customerPhone"].toString(),
                  orderDate: element["orderDate"].toString(),
                  orderId: int.parse(element["orderId"].toString()),
                  orderLoaction: element["orderLoaction"].toString(),
                  orderRef: element["orderRef"].toString(),
                  orderValue: element["orderValue"].toString(),
                  orderStatus: int.parse(element["orderStatus"].toString())));
            }
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
}
