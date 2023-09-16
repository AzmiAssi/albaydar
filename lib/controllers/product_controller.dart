import 'package:albaydar/models/Products.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxList<Products> allProducts = RxList<Products>();
  RxList<Products> filterProducts = RxList<Products>();
  RxList<Products> topProduct = RxList<Products>();
  RxList<Products> cartProducts = RxList<Products>();
  RxList<Products> favoritProducts = RxList<Products>();

  RxDouble totalPrice = 0.0.obs;

  void filterPerCategoryId(int categoryId) {
    filterProducts.clear();
    filterProducts.assignAll(allProducts.where((item) {
      return item.categoryId == categoryId;
    }).toList());
    update();
  }

  void isFavorite(int id) {
    for (var element in allProducts) {
      if (element.productId == id) {
        element.isFavorite = !element.isFavorite;
        if (element.isFavorite == true) {
          favoritProducts.add(element);
          update();
        } else {
          favoritProducts.remove(element);
          update();
        }
      }
    }
    // allProducts[index].isFavorite = !filterProducts[index].isFavorite;
    // favoritProducts.clear();
    // favoritProducts.addAll(allProducts.where(
    //   (p0) => p0.isFavorite == true,
    // ));
    update();
  }

  void addToCart(Products product) {
    product.quantity = 1;
    cartProducts.add(product);
    cartProducts.assignAll(cartProducts);

    calculateTotalPrice();
    update();
  }

  void increaseItemQuantity(Products product) {
    product.quantity++;
    calculateTotalPrice();
    update();
  }

  void decreaseItemQuantity(Products product) {
    product.quantity--;
    if (product.quantity <= 0) {
      cartProducts.remove(product);
    }
    if (cartProducts.isEmpty) {
      update();
    }
    calculateTotalPrice();
    update();
  }

  // bool isPriceOff(Product product) => product.off != null;

  bool get isEmptyCart => cartProducts.isEmpty;

  bool get isEmptyfavorit => favoritProducts.isEmpty;

  // bool isNominal(Product product) => product.sizes?.numerical != null;

  void calculateTotalPrice() {
    totalPrice.value = 0;
    for (var element in cartProducts) {
      totalPrice.value += element.quantity * element.productPrice;
    }
  }

  getFavoriteItems() {
    filterProducts.assignAll(
      allProducts.where((item) => item.isFavorite),
    );
  }

  getCartItems() {
    cartProducts.assignAll(
      allProducts.where((item) => item.quantity > 0),
    );
  }
}
