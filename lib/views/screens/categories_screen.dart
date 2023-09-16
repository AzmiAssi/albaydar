// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';
import 'package:albaydar/models/Category.dart';
import 'package:albaydar/views/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:image_card/image_card.dart';
import '../../constants/util.dart';
import 'package:flutter_swiper_tv/flutter_swiper.dart';
import '../../main.dart';
import '../../models/Products.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    if (categoryController.allCategories.isEmpty) {
      _isLoading = true;
      setState(() {});
      getCategory();
      getAllProduct();
      _isLoading = true;
      setState(() {});
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? SpinKitPulsingGrid(
            itemBuilder: (BuildContext context, int index) {
              return const DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
              );
            },
          )
        : RefreshIndicator(
            onRefresh: () async {
              _isLoading = true;
              setState(() {});
              getCategory();
              getAllProduct();
              _isLoading = true;
              setState(() {});
            },
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          width: double.infinity,
                          height: 230,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          child: Swiper(
                            duration: 2500,
                            autoplay: true,
                            itemCount: categoryController.allCategories.length,
                            itemBuilder: (BuildContext context, int index) {
                              return TransparentImageCard(
                                borderRadius: 25,
                                contentMarginTop: 0,
                                contentPadding: const EdgeInsets.all(8),
                                width: MediaQuery.of(context).size.width - 20,
                                height: 230,
                                imageProvider: MemoryImage(
                                  base64Decode(categoryController
                                      .allCategories[index].imageBase64),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: categoryController.allCategories.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: InkWell(
                              onTap: () {
                                productController.filterPerCategoryId(
                                    categoryController
                                        .allCategories[index].categoryId);
                                Get.to(ProductsScreen(
                                  category:
                                      categoryController.allCategories[index],
                                ));
                                controller.update();
                              },
                              child: TransparentImageCard(
                                borderRadius: 35,
                                contentMarginTop: 115,
                                width: double.infinity,
                                height: 200,
                                imageProvider: MemoryImage(base64Decode(
                                    categoryController
                                        .allCategories[index].imageBase64)),
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: langController.langCode == 'ar'
                                      ? Text(
                                          categoryController
                                              .allCategories[index]
                                              .categoryArabicName,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        )
                                      : Text(
                                          categoryController
                                              .allCategories[index]
                                              .categoryName,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                ),
                                description: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: langController.langCode == 'en'
                                      ? Text(
                                          categoryController
                                              .allCategories[index]
                                              .categoryArabicName,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        )
                                      : Text(
                                          categoryController
                                              .allCategories[index]
                                              .categoryName,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                ),
                              ),
                            ),
                          )),
                ),
              ],
            ),
          );
  }

  getCategory() async {
    var fullUrl = Uri.parse("${Util.serverBaseUrl}Category/get-all-categoies");
    try {
      http.Response response = await http.get(fullUrl);

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          var data = json.decode(response.body);
          if (data != null) {
            categoryController.allCategories.clear();
            for (var element in data) {
              categoryController.allCategories.add(Category(
                  element["categoryId"],
                  element["categoryName"],
                  element["categoryImage"],
                  element["categoryArabicName"],
                  element["categoryStatus"],
                  element["imageBase64"]));
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
            onDismissCallback: (type) {
              if (type != DismissType.btnOk) {
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

  getAllProduct() async {
    var fullUrl = Uri.parse("${Util.serverBaseUrl}Product/get-all-products");
    try {
      http.Response response = await http.get(fullUrl);
      productController.allProducts.clear();
      if (response.statusCode == 200) {
        setState(() {});
        if (mounted) {
          var data = json.decode(response.body);
          if (data != null) {
            for (var element in data) {
              productController.allProducts.add(Products(
                  categoryId: element["categoryId"],
                  imageExt: element["imageExt"] ?? "",
                  imgesBase64: element["imgesBase64"] as List<dynamic>,
                  isTop: element["isTop"],
                  productArabicDescription: element["productArabicDescription"],
                  productArabicName: element["productArabicName"],
                  productDescription: element["productDescription"],
                  productId: element["productId"],
                  productImage: element["productImage"],
                  productName: element["productName"],
                  productPrice:
                      double.parse(element["productPrice"].toString()),
                  rate: element["rate"] ?? 0,
                  status: element["status"],
                  unitId: element["unitId"],
                  isFavorite: false,
                  quantity: 0));
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
            onDismissCallback: (type) {
              if (type != DismissType.btnOk) {
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

  getTopProduct() async {
    var fullUrl =
        Uri.parse("${Util.serverBaseUrl}Product/get-all-top-products");
    try {
      http.Response response = await http.get(fullUrl);
      productController.allProducts.clear();
      if (response.statusCode == 200) {
        setState(() {});
        if (mounted) {
          var data = json.decode(response.body);
          if (data != null) {
            for (var element in data) {
              productController.topProduct.add(Products(
                  categoryId: element["categoryId"],
                  imageExt: element["imageExt"] ?? "",
                  imgesBase64: element["imgesBase64"] as List<dynamic>,
                  isTop: element["isTop"],
                  productArabicDescription: element["productArabicDescription"],
                  productArabicName: element["productArabicName"],
                  productDescription: element["productDescription"],
                  productId: element["productId"],
                  productImage: element["productImage"],
                  productName: element["productName"],
                  productPrice:
                      double.parse(element["productPrice"].toString()),
                  rate: element["rate"] ?? 0,
                  status: element["status"],
                  unitId: element["unitId"],
                  isFavorite: false,
                  quantity: 0));
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
            onDismissCallback: (type) {
              if (type != DismissType.btnOk) {
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
