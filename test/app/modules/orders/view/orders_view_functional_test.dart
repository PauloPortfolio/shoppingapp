import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/components/keys/progres_indicator_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/orders.dart';
import 'package:shopingapp/app/modules/cart/core/cart_widget_keys.dart';
import 'package:shopingapp/app/modules/cart/view/cart_view.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../mocked_datasource/products_mocked_datasource.dart';
import '../../../../test_utils/test_utils.dart';
import '../orders_test_config.dart';
import 'orders_view_tests.dart';

class OrdersViewFunctionalTest {
  void functional() {
    TestUtils _seek;
    var tests = Get.put(OrdersViewTests());
    var testConfig = Get.put(OrdersTestConfig());
    var bindings;
    var products = ProductsMockedDatasource().products();

    setUp(() {
      bindings = testConfig.bindingsBuilderMockedRepo(execute: true);
      _seek = Get.put(TestUtils());
    });

    tearDown(Get.reset);

    testWidgets('${testConfig.OpenOrderViewWithAnOrderInDB}', (tester) async {
      bindings ? await tester.pumpWidget(app.AppDriver()) : app.main();

      await tests.openDrawerAndClickAnOption(
        tester,
        keyOption: DRAWER_ORDER_OPTION_KEY,
      );
      tests.checkOneOrderInOrdersView(widgetsMinimalQtde: 1);
    });

    testWidgets('${testConfig.OpenOrderPageWithoutAnyOrderInDB}', (tester) async {
      bindings = testConfig.bindingsBuilderMockRepoEmptyDb(execute: true);
      bindings ? await tester.pumpWidget(app.AppDriver()) : app.main();

      await tests.openDrawerAndClickAnOption(tester);

      expect(_seek.type(CircularProgressIndicator), findsOneWidget);
      expect(_seek.text(NO_PRODUCTS_FOUND_IN_YET), findsNothing);
      expect(_seek.text(ORDERS_TITLE_PAGE), findsOneWidget);

      await tester.pump();
      await tester.pump(_seek.delay(3));

      expect(_seek.text(ORDERS_TITLE_PAGE), findsOneWidget);
      expect(_seek.text(NO_PRODUCTS_FOUND_IN_YET), findsOneWidget);
      expect(_seek.type(CircularProgressIndicator), findsNothing);
    });

    testWidgets('${testConfig.TestPageBackButton}', (tester) async {
      bindings ? await tester.pumpWidget(app.AppDriver()) : app.main();
      // await tests.openDrawerAndClickAnOption(tester, _seek);
      await tests.openDrawerAndClickAnOption(
        tester,
        keyOption: DRAWER_ORDER_OPTION_KEY,
      );
      await tests.tapBackButtonView(
        tester,
        from: OrdersView,
        to: OverviewView,
      );
    });

    testWidgets('${testConfig.OrderingFromCartViewUsingTheButtonOrderNow}',
        (tester) async {
      bindings ? await tester.pumpWidget(app.AppDriver()) : app.main();

      //1) ADDING ONE PRODUCT IN THE CART
      await tester.pumpAndSettle();
      expect(_seek.type(OverviewView), findsOneWidget);
      await tester.tap(_seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0"));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text("1"), findsOneWidget);

      //2) CLICKING CART-BUTTON-PAGE AND CHECK THE AMOUNT CART
      await tester.tap(_seek.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.type(CartView), findsOneWidget);
      expect(_seek.text(products[0].title), findsOneWidget);

      //3) CLICKING ORDER-NOW-BUTTON AND GO BACK TO THE PREVIOUS PAGE
      await tester.tap(_seek.key(CART_PAGE_ORDERSNOW_BUTTON_KEY));
      await tester.pump(_seek.delay(1));
      expect(_seek.key(CART_PAGE_ORDERSNOW_BUTTON_KEY), findsNothing);
      expect(_seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
      await tester.pump(_seek.delay(2));
      expect(_seek.type(OverviewView), findsOneWidget);

      //4) OPEN ORDERS-DRAWER-OPTION AND CHECK THE ORDER DONE ABOVE
      await tests.openDrawerAndClickAnOption(
        tester,
        keyOption: DRAWER_ORDER_OPTION_KEY,
      );
      expect(_seek.type(OrdersView), findsOneWidget);
      tests.checkOneOrderInOrdersView(widgetsMinimalQtde: 1);

      //5) PRESS BACK-BUTTON AND GOBACK TO OVERVIEW-PAGE
      await tester.tap(_seek.type(BackButton));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.type(OverviewView), findsOneWidget);
    });
  }
}
