import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/inventory/repo/i_inventory_repo.dart';
import 'package:test/test.dart';

import '../../../../test_utils/mocked_datasource/products_mocked_datasource.dart';
import '../../../../test_utils/test_utils.dart';
import 'managed_products_repo_mocks.dart';

class ManagedProductsRepoTest {
  static void unit() {
    IInventoryRepo _mockRepo, _injectMockRepo;
    var _product0 = ProductsMockedDatasource().products().elementAt(0);
    var _product1 = ProductsMockedDatasource().products().elementAt(1);

    setUp(() {
      _mockRepo = ManagedProductsMockRepo();
      _injectMockRepo = ManagedProductsInjectMockRepo();
    });

    tearDown(TestMethods.globalTearDown);

    test('Checking Test Instances', () {
      expect(_mockRepo, isA<ManagedProductsMockRepo>());
      expect(_injectMockRepo, isA<ManagedProductsInjectMockRepo>());
      expect(_product0, isA<Product>());
      expect(_product1, isA<Product>());
    });

    test('Getting Products', () {
      _mockRepo.getProducts().then((response) {
        expect(response, isA<List<Product>>());
        expect(response[0].id, _product0.id);
        expect(response[0].title, _product0.title);
        expect(response[1].id, _product1.id);
        expect(response[1].title, _product1.title);
      });
    });

    //todo: erro authentication to be done
    test('Getting products - Error authentication', () {
      _mockRepo.getProducts().catchError((onError) {
        if (onError.toString().isNotEmpty) {
          fail("Error: Aut");
        }
      });
    });

    test('Adding a Product', () {
      _mockRepo.addProduct(_product0).then((addedProduct) {
        // In addProduct, never the 'product to be added' has 'id'
        // expect(addedProduct.id, _product0.id);
        expect(addedProduct.title, _product0.title);
        expect(addedProduct.price, _product0.price);
        expect(addedProduct.description, _product0.description);
        expect(addedProduct.imageUrl, _product0.imageUrl);
        expect(addedProduct.isFavorite, _product0.isFavorite);
      });
    });

    test('Adding a Product(Inject)  - Empty Response', () {
      when(_injectMockRepo.getProducts()).thenAnswer((_) async => []);
      _injectMockRepo.getProducts().then((value) {
        expect(value, isEmpty);
      });
    });

    test('Adding a Product(Inject)  - Null Response', () {
      when(_injectMockRepo.getProducts()).thenAnswer((_) async => null);
      _injectMockRepo.getProducts().then((value) {
        expect(value, isNull);
      });
    });

    test('Updating a Product - status 200', () {
      _mockRepo.updateProduct(_product0).then((value) {
        expect(value, 200);
      });
    });

    test('Updating a Product(Inject) - status 400', () {
      when(_injectMockRepo.updateProduct(_product0))
          .thenAnswer((_) async => 400);

      _injectMockRepo
          .updateProduct(_product0)
          .then((value) => {expect(value, 400)});
    });

    test('Updating a Product(Inject) - status 404', () {
      when(_injectMockRepo.updateProduct(_product0))
          .thenAnswer((_) async => 404);

      _injectMockRepo
          .updateProduct(_product0)
          .then((value) => {expect(value, 404)});
    });

    test('Deleting a Product - status 200', () {
      _mockRepo.getProducts().then((response) {
        expect(response, isA<List<Product>>());
        expect(response[0].id, _product0.id);
        expect(response[0].title, _product0.title);

        _mockRepo.deleteProduct(_product0.id).then((value) {
          expect(value, 200);
          expect(response[0].id, isNot(isIn(response)));
        });
      });
    });

    test('Deleting a Product(Inject) - status 404', () {
      when(_injectMockRepo.deleteProduct(_product0.id))
          .thenAnswer((_) async => 404);

      _injectMockRepo
          .deleteProduct(_product0.id)
          .then((value) => {expect(value, 404)});
    });
  }
}