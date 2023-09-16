// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, unrelated_type_equality_checks
import 'dart:convert';

import 'package:albaydar/models/Category.dart';
import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';

import '../../main.dart';
import '../widgets/animation/open_container_wrapper.dart';

class ProductsScreen extends StatefulWidget {
  Category category;
  ProductsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
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
            icon: Icon(
              Icons.favorite,
              color: productController.filterProducts[index].isFavorite
                  ? Colors.redAccent
                  : const Color(0xFFA6A3A0),
            ),
            onPressed: () {
              productController.isFavorite(
                  productController.filterProducts[index].productId);
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
          base64Decode(productController.filterProducts[index].imgesBase64[0]),
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
                      productController.filterProducts[index].productArabicName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    )
                  : Text(
                      productController.filterProducts[index].productName,
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
                  "\$${productController.filterProducts[index].productPrice}",
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.categoryName.toString()),
      ),
      body: Column(
        children: [
          TransparentImageCard(
            borderRadius: 0,
            contentMarginTop: 100,
            width: double.infinity,
            height: 200,
            imageProvider:
                MemoryImage(base64Decode(widget.category.imageBase64)),
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.category.categoryName,
                style: const TextStyle(color: Colors.white, fontSize: 26),
              ),
            ),
            description: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.category.categoryArabicName,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: GridView.builder(
                itemCount: productController.filterProducts.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 10 / 16,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (_, index) {
                  return OpenContainerWrapper(
                    product: productController.filterProducts[index],
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
