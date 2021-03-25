import 'package:get/get.dart';
import 'package:scrum_app/app/data/mock/app_mock.dart';
import 'package:scrum_app/app/data/models/product_model.dart';

class ProductProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<List<ProductModel>> getProducts() async {
    return AppMock.products;
  }

}
