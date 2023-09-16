// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:albaydar/constants/app_size.dart';
import 'package:albaydar/constants/navigation.dart';
import 'package:flutter/material.dart';
import '../order-details/order-details.dart';

Widget orders(ordersdata, context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order No' + ordersdata["orderno"],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  ordersdata["date"],
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  ('trackingNumber') + ':',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(width: 10),
                Text(
                  (ordersdata["tracking"]),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          ('quantity') + ':',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          ordersdata["quantity"],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          ('totalAmount') + ':',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          ordersdata["amount"] + '\$',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: AppSize(context).width * 0.3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                  child: MaterialButton(
                    onPressed: () {
                      navigateTo(context, const OrederDetails());
                    },
                    child: const Text(
                      ('details'),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(('delivered'),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)))
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget orderStatus(orderstatus, setState) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: InkWell(
      onTap: () {
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:
              // (orderStatusSelected != orderstatus["id"].toString())
              //     ?
              Colors.grey[300],
          // : primary,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Text(
          (orderstatus["name"]),
          style: const TextStyle(
              color:
                  // orderStatusSelected != orderstatus["id"].toString()
                  //     ? Colors.black
                  //     :
                  Colors.white,
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
