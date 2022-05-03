import 'dart:convert';
import 'dart:io';

import 'package:shopingapp/app/modules/inventory/entity/inventory_depo.dart';
import 'package:shopingapp/app/modules/inventory/entity/inventory_depot.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/orders/entity/order.dart';
import 'package:shopingapp/app/modules/overview/core/components/overview_appbar/filter_options_enum.dart';

import '../app_tests_properties.dart';

class MockedDatasource {
  final _MockedDataMassPathFile = MOCKED_DATA_MASS_PATH_FILE;

  // PRODUCTS DATASOURCE
  List<Product> products() {
    final file = File(_MockedDataMassPathFile);
    final json = jsonDecode(file.readAsStringSync())["products"];
    List<Product> result = json.map<Product>((json) => Product.fromJson(json)).toList();
    return result;
  }

  Product product() {
    final file = File(_MockedDataMassPathFile);
    final json = jsonDecode(file.readAsStringSync())["products"];
    List<Product> result = json.map<Product>((json) => Product.fromJson(json)).toList();
    return result.elementAt(0);
  }

  List<Product> favoritesProducts() {
    final file = File(_MockedDataMassPathFile);
    final json = jsonDecode(file.readAsStringSync())["products"];
    List<Product> list = json.map<Product>((json) => Product.fromJson(json)).toList();
    var listReturn = <Product>[];
    for (var item in list) {
      if (item.isFavorite) listReturn.add(item);
    }
    return listReturn;
  }

  Product productById(String id) {
    final file = File(_MockedDataMassPathFile);
    final json = jsonDecode(file.readAsStringSync())["products"];
    List<Product> list = json.map<Product>((json) => Product.fromJson(json)).toList();
    return list.firstWhere((element) => element.id == id);
  }

  List<Product> productsByFilter(FilterOptionsEnum filter) {
    return filter == FilterOptionsEnum.All
        ? MockedDatasource().products()
        : MockedDatasource().favoritesProducts();
  }

  List<Product> productsEmpty() {
    return [];
  }

  // ORDERS DATASOURCE
  List<Order> orders() {
    final file = File(_MockedDataMassPathFile);
    final json = jsonDecode(file.readAsStringSync())["orders"];
    List<Order> result = json.map<Order>((json) => Order.fromJson(json)).toList();
    return result;
  }

  Order order() {
    final file = File(_MockedDataMassPathFile);
    final json = jsonDecode(file.readAsStringSync())["orders"];
    List<Order> result = json.map<Order>((json) => Order.fromJson(json)).toList();
    return result.elementAt(0);
  }

  List<Order> ordersEmpty() {
    return [];
  }

  // DEPOTS DATASOURCE
  List<InventoryDepot> depots() {
    final file = File(_MockedDataMassPathFile);
    final json = jsonDecode(file.readAsStringSync())["depots"];
    List<InventoryDepot> result =
        json.map<InventoryDepot>((json) => InventoryDepot.fromJson(json)).toList();
    return result;
  }
}