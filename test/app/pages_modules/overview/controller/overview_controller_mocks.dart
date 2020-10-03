import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/i_overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';

import '../utils/mocked_data_source.dart';

class PredefinedMockController implements IOverviewController {


  @override
  void onInit() {
    // TODO: implement onInit
  }

  @override
  void toggleFavoriteStatus(String id) {
    // TODO: implement toggleFavoriteStatus
  }

  @override
  void getProductsByFilter(EnumFilter filter) {
    // estado
  }

  @override
  int getFavoritesQtde() {
    return MockedDataSource().favoritesProducts().length;
  }

  @override
  Product getProductById(String id) {
    return MockedDataSource().productById(id);
  }

  @override
  Future<List<Product>> getProducts() {
    return Future.value(MockedDataSource().products());
  }

  @override
  int getProductsQtde() {
    return MockedDataSource().products().length;
  }
}


class CustomMockController extends Mock implements IOverviewController {}
