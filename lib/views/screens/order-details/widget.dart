// ignore_for_file: prefer_interpolation_to_compose_strings, sized_box_for_whitespace
import 'package:flutter/material.dart';

Widget orderProduct(orderdata) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
    child: Card(
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(35))),
        height: 115,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                  child: Image(
                    fit: BoxFit.fill,
                    height: 115,
                    width: 140,
                    image: NetworkImage(
                      "https://loremflickr.com/120/130",
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderdata["name"],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              const Text(
                                ("color") + ":",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              Text(orderdata["color"]),
                              const SizedBox(width: 10),
                            ],
                          ),
                          const SizedBox(width: 15),
                          Row(
                            children: [
                              const Text(
                                ("size") + ":",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              Text(orderdata["size"]),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(('quantity'),
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                                const SizedBox(width: 10),
                                Text(orderdata["units"],
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black)),
                              ],
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(orderdata["price"] + "\$",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget orderDetails({title, text, bool isBold = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9.5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          (title) + " : ",
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Container(
          width: 200,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.w900 : FontWeight.w300),
          ),
        ),
      ],
    ),
  );
}
