import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/properties/app_urls.dart';
import '../../inventory/entities/product.dart';
import 'i_overview_repo.dart';

class OverviewRepoHttp implements IOverviewRepo {
  @override
  Future<List<Product>> getProducts() {
    // @formatter:off
    return http
        .get(PRODUCTS_URL_HTTP, headers: {"Accept": "application/json"})
        .then((stringResponse) {
            var _products = <Product>[];
            final json = jsonDecode(stringResponse.body);
            json == null ? _products = [] :
            _products = json.map<Product>((data) => Product.fromJson(data)).toList();
            return _products;})
        .catchError((onError){
            print(">>> Erro: $onError");
            throw onError;});
    // @formatter:on
  }

  @override
  Future<int> updateProduct(Product product, [String id]) {
    return http
        .patch("$URL_FIREBASE/$COLLECTION_PRODUCTS/${product.id}$EXTENSION",
            body: product.toJson())
        .then((response) => response.statusCode);
  }
}
//
//
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import '../../../core/properties/app_urls.dart';
// import '../../inventory/entities/product.dart';
// import 'i_overview_repo.dart';
//
// class OverviewRepoHttp implements IOverviewRepo {
//   @override
//   Future<List<Product>> getProducts() {
//     // @formatter:off
//     return http
//         .get(PRODUCTS_URL_HTTP)
//         .then((jsonResponse) {
//       var _products = <Product>[];
//       final MapProductsDecodedFromJsonResponse =
//       json.decode(jsonResponse.body) as Map<String, dynamic>;
//
//       // todo: erro authentication to be done
//       // MapOrdersDecodedFromJsonResponse != null ||
//       //     jsonResponse.statusCode >= 400 ?
//       MapProductsDecodedFromJsonResponse != null ?
//       MapProductsDecodedFromJsonResponse
//           .forEach((idMap, dataMap) {
//         var productCreatedFromDataMap = Product.fromJson(dataMap);
//         productCreatedFromDataMap.id = idMap;
//         _products.add(productCreatedFromDataMap);
//       })
//           :_products = [];
//       return _products;})
//         .catchError((onError){
//       print(">>>>>>>Erro no Firebase: Autenticacao ou "
//           "JsonFormat, etc...>>>>>>: "
//           "$onError");
//       throw onError;
//     });
//     // @formatter:on
//   }
//
//   @override
//   Future<int> updateProduct(Product product, [String id]) {
//     return http
//         .patch("$URL_FIREBASE/$COLLECTION_PRODUCTS/${product.id}$EXTENSION",
//         body: product.toJson())
//         .then((response) => response.statusCode);
//   }
// }
