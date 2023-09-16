// ignore_for_file: unrelated_type_equality_checks, must_be_immutable

import 'package:albaydar/AppWords.dart';
import 'package:albaydar/main.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../models/Products.dart';
import '../widgets/carousel_slider.dart';
import '../widgets/page_wrapper.dart';

class ProductDetailScreen extends StatelessWidget {
  final Products product;

  ProductDetailScreen(this.product, {Key? key}) : super(key: key);

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.black),
      ),
    );
  }

  Widget productPageView(double width, double height) {
    return Container(
      height: height * 0.35,
      width: width,
      decoration: const BoxDecoration(
        color: Color(0xFFE5E6E8),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(150),
          bottomLeft: Radius.circular(150),
        ),
      ),
      child: CarouselSlider(items: product.imgesBase64),
    );
  }

  Widget _ratingBar(BuildContext context) {
    return Wrap(
      spacing: 30,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        RatingBar.builder(
          initialRating: product.rate,
          direction: Axis.horizontal,
          itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (_) {},
        ),
      ],
    );
  }

  // Widget productSizesListView() {
  //   return ListView.builder(
  //     scrollDirection: Axis.horizontal,
  //     itemCount: controller.sizeType(product).length,
  //     itemBuilder: (_, index) {
  //       return InkWell(
  //         onTap: () => controller.switchBetweenProductSizes(product, index),
  //         child: AnimatedContainer(
  //           margin: const EdgeInsets.only(right: 5, left: 5),
  //           alignment: Alignment.center,
  //           width: controller.isNominal(product) ? 40 : 70,
  //           decoration: BoxDecoration(
  //             color: controller.sizeType(product)[index].isSelected == false
  //                 ? Colors.white
  //                 : AppColor.lightOrange,
  //             borderRadius: BorderRadius.circular(10),
  //             border: Border.all(color: Colors.grey, width: 0.4),
  //           ),
  //           duration: const Duration(milliseconds: 300),
  //           child: FittedBox(
  //             child: Text(
  //               controller.sizeType(product)[index].numerical,
  //               style: const TextStyle(
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: 15,
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _appBar(context),
        body: SingleChildScrollView(
          child: PageWrapper(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productPageView(width, height),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      langController.langCode == 'ar'
                          ? Text(
                              product.productArabicName,
                              style: Theme.of(context).textTheme.headlineMedium,
                            )
                          : Text(
                              product.productName,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                      const SizedBox(height: 10),
                      _ratingBar(context),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "\$${product.productPrice}",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(width: 3),
                          // Visibility(
                          //   // visible: product.off != null ? true : false,
                          //   child: Text(
                          //     "\$${product.productPrice}",
                          //     style: const TextStyle(
                          //       decoration: TextDecoration.lineThrough,
                          //       color: Colors.grey,
                          //       fontWeight: FontWeight.w500,
                          //     ),
                          //   ),
                          // ),
                          const Spacer(),
                          Text(
                            AppWords.Available.tr,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(
                        AppWords.About.tr,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 10),
                      langController.langCode == 'ar'
                          ? Text(product.productArabicDescription)
                          : Text(product.productDescription),
                      const SizedBox(height: 60),
                      // SizedBox(
                      //   height: 40,
                      //   child: GetBuilder<ProductController>(
                      //     builder: (_) => productSizesListView(),
                      //   ),
                      // ),
                      Container(
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
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            productController.addToCart(product);
                            productController.calculateTotalPrice();
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.SUCCES,
                              animType: AnimType.SCALE,
                              title: 'Added Successfully',
                              desc: 'Your Product Added To Cart',
                              btnOkText: 'ok',
                              onDissmissCallback: (type) {
                                if (type != DismissType.BTN_OK) {
                                  Navigator.pop(context);
                                }
                              },
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              },
                            ).show();
                          },
                          child: Text(AppWords.AddToCart.tr),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
