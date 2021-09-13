import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';

import '../../../../config/bindings/inventory_test_bindings.dart';
import '../../../../config/tests_properties.dart';
import '../../../../config/titles/inventory_tests_titles.dart';
import '../../../../tests_datasource/mocked_datasource.dart';
import '../../../../utils/dbtest_utils.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/tests_global_utils.dart';
import '../../../../utils/tests_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'inventory_tests.dart';

class InventoryViewTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _bindings = Get.put(InventoryTestBindings());
  final _titles = Get.put(InventoryTestsTitles());
  final _globalMethods = Get.put(TestsGlobalUtils());
  final _testUtils = Get.put(TestsUtils());

  InventoryViewTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    var _products = <dynamic>[];

    final _tests = Get.put(InventoryTests(
        finder: _finder,
        dbTestUtils: _dbUtils,
        uiTestUtils: _uiUtils,
        isWidgetTest: _isWidgetTest,
        testUtils: _testUtils));

    setUpAll(() async {
      _globalMethods
          .globalSetUpAll('${_tests.runtimeType.toString()} $SHARED_STATE_TITLE');
      _products = _isWidgetTest
          ? await Future.value(MockedDatasource().products())
          : await _dbUtils.getCollection(url: PRODUCTS_URL);
      // _products = await _testUtils.post_DatabuilderProductList_InDb(
      //   isWidgetTest: _isWidgetTest,
      //   numberOfProducts: TOTAL_SAMPLEDATA_ITEMS_LOADED_IN_TESTDB,
      // );
      // _products = await _dbUtils.getCollection(url: PRODUCTS_URL).cast<Product>();
    });

    tearDownAll(() => _globalMethods.globalTearDownAll(
          _tests.runtimeType.toString(),
          isWidgetTest: _isWidgetTest,
        ));

    setUp(() {
      _globalMethods.globalSetUp();
      _bindings.bindingsBuilderMockedRepo(isUnitTest: _isWidgetTest);
    });

    tearDown(_globalMethods.globalTearDown);

    testWidgets(_titles.check_products, (tester) async {
      await _tests.check_qtde_products(tester, _products.length);
    });

    testWidgets(_titles.update_product, (tester) async {
      await _tests.update_product(
        tester,
        inputValidText: "XXXXXX",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        productToUpdate: _products[0],
      );
    });

    testWidgets(_titles.delete_product, (tester) async {
      await _tests.delete_product(
        tester,
        deleteButtonKey:
            '$INVENTORY_DELETEITEM_BUTTON_KEY${_products[_products.length - 1].id}',
        widgetTypetoBeDeleted: InventoryItem,
        qtdeAfterDelete: _products.length - 1,
      );
    });

    testWidgets(_titles.refresh_view, (tester) async {
      await _tests.refresh_view(
        tester,
        draggerWidget: _products[0],
        //a) delete above; b) deleted from DB manually
        qtdeAfterRefresh: _products.length - 2,
      );
    });

    testWidgets(_titles.tap_viewBackButton, (tester) async {
      await _tests.tap_viewBackButton(tester);
    });

    testWidgets(_titles.check_emptyView_noProductInDb, (tester) async {
      _bindings.bindingsBuilderMockedRepoEmptyDb(isWidgetTest: _isWidgetTest);
      await _tests.check_emptyView_noProductInDb(tester, DELAY);
    });
  }
}