// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';

import '../../main.dart';
import '../widgets/animation/open_container_wrapper.dart';
import '../widgets/empty_favorit.dart';

class FavoritsScreen extends StatefulWidget {
  const FavoritsScreen({super.key});

  @override
  State<FavoritsScreen> createState() => _FavoritsScreenState();
}

class _FavoritsScreenState extends State<FavoritsScreen> {
  Widget _gridItemHeader(int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            // visible: isPriceOff(product),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              width: 80,
              height: 30,
              alignment: Alignment.center,
              child: const Text(
                "30% OFF",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.redAccent,
            ),
            onPressed: () {
              productController.isFavorite(
                  productController.favoritProducts[index].productId);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _gridItemBody(int index) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E6E8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.memory(
          base64Decode(productController.favoritProducts[index].imgesBase64[0]),
          fit: BoxFit.contain,
          scale: 3),
      //  Image.asset(product.images[0], scale: 3),
    );
  }

  Widget _gridItemFooter(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: langController.langCode == 'ar' ? 65 : 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: langController.langCode == 'ar'
                  ? Text(
                      productController
                          .favoritProducts[index].productArabicName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    )
                  : Text(
                      productController.favoritProducts[index].productName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
            ),
            // const SizedBox(height: 5),
            Row(
              children: [
                // Text(
                //   product.off != null
                //       ? "\$${product.off}"
                //       : "\$${product.price}",
                //   style: Theme.of(context).textTheme.headlineMedium,
                // ),
                // const SizedBox(width: 3),
                Text(
                  "\$${productController.favoritProducts[index].productPrice}",
                  style: const TextStyle(
                    // decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: productController.isEmptyfavorit
                  ? const EmptyFavorit()
                  : GridView.builder(
                      itemCount: productController.favoritProducts.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 10 / 16,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (_, index) {
                        return OpenContainerWrapper(
                          product: productController.favoritProducts[index],
                          child: GridTile(
                            header: _gridItemHeader(index),
                            footer: _gridItemFooter(index, context),
                            child: _gridItemBody(index),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
