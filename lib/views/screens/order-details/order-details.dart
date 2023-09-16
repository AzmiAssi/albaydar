// ignore_for_file: file_names, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
import 'package:albaydar/constants/app_size.dart';
import 'package:flutter/material.dart';
import 'widget.dart';

class OrederDetails extends StatefulWidget {
  const OrederDetails({Key? key}) : super(key: key);
  @override
  State<OrederDetails> createState() => _OrederDetailsState();
}

class _OrederDetailsState extends State<OrederDetails> {
  List orderData = [
    {
      "name": "Pullover",
      "color": "Gray",
      "size": "L",
      "units": "1",
      "price": "51"
    },
    {
      "name": "Pullover",
      "color": "Gray",
      "size": "L",
      "units": "1",
      "price": "51"
    },
    {
      "name": "Pullover",
      "color": "Gray",
      "size": "L",
      "units": "1",
      "price": "51"
    },
  ];
  DateTime orderDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Order No 468452313',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    orderDate.day.toString() +
                        '-' +
                        orderDate.month.toString() +
                        '-' +
                        orderDate.year.toString(),
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
              const Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'trackingNumber' + ':',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'IW456448623',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  Text('delivered',
                      textAlign: TextAlign.end,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        orderData.length.toString() + ' ' + "items",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        for (int i = 0; i < orderData.length; i++) orderProduct(orderData[i]),
        const SizedBox(height: 10),
        orderDetails(
            text: "3 Newbridge Court ,hino Hills, CA 91709,united State",
            title: ("shippingAddress")),
        const SizedBox(height: 10),
        orderDetails(text: "**** **** **** 3947", title: ("paymentMethod")),
        const SizedBox(height: 10),
        orderDetails(text: "FedEX,3 Day ,15\$", title: ("deliveryMethod")),
        const SizedBox(height: 10),
        orderDetails(text: "10% ,personal promo code", title: ("discount")),
        const SizedBox(height: 10),
        orderDetails(text: "133\$", title: ("totalAmount"), isBold: true),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: AppSize(context).width / 2.6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: MaterialButton(
                  onPressed: () {},
                  child: const Text(
                    ('share'),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: AppSize(context).width / 2.6,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: const BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: MaterialButton(
                  onPressed: () {},
                  child: const Text(
                    ('reorder'),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
