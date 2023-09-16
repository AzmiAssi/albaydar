// ignore_for_file: unused_element

import 'dart:convert';
import 'package:albaydar/AppWords.dart';
import 'package:albaydar/constants/navigation.dart';
import 'package:albaydar/main.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controllers/product_controller.dart';
import '../widgets/animation/animated_switcher_wrapper.dart';
import '../widgets/empty_cart.dart';
import 'check-out/check-out.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        AppWords.Cart.tr,
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  @override
  void initState() {
    productController.getCartItems();
    productController.calculateTotalPrice();
    productController.update();
    setState(() {});
    super.initState();
  }

  Widget cartList() {
    return ListView.builder(
      itemCount: productController.cartProducts.length,
      itemBuilder: (context, index) => Container(
        width: double.infinity,
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[200]?.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 120,
                  width: 150,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //color: Colors.teal,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.memory(base64Decode(productController
                              .cartProducts[index].imgesBase64[0]))),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productController.cartProducts[index].productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "\$${productController.cartProducts[index].productPrice}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              splashRadius: 10.0,
                              onPressed: () {
                                productController.decreaseItemQuantity(
                                    productController.cartProducts[index]);
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.remove,
                                color: Color(0xFFEC6813),
                              ),
                            ),
                            GetBuilder<ProductController>(
                              builder: (productController) {
                                return AnimatedSwitcherWrapper(
                                  child: Text(
                                    '${productController.cartProducts[index].quantity}',
                                    key: ValueKey<int>(
                                      productController
                                          .cartProducts[index].quantity,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              splashRadius: 10.0,
                              onPressed: () =>
                                  productController.increaseItemQuantity(
                                      productController.cartProducts[index]),
                              icon: const Icon(Icons.add,
                                  color: Color(0xFFEC6813)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
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
          onPressed: productController.isEmptyCart
              ? null
              : () {
                  navigateTo(context, const CheckOut());
                },
          child: Text(AppWords.BuyNow.tr),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child:
                productController.isEmptyCart ? const EmptyCart() : cartList(),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppWords.Total.tr,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w400),
                ),
                Obx(
                  () {
                    return AnimatedSwitcherWrapper(
                      child: Text(
                        "\$${productController.totalPrice.value}",
                        key: ValueKey<double>(
                            productController.totalPrice.value),
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
          ),
          bottomBarButton()
        ],
      ),
    );
  }
}
