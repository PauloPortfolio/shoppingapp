import 'dart:io';

import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/cart/repo/cart_repo_http.dart';
import 'package:shopingapp/app/modules/cart/repo/i_cart_repo.dart';
import 'package:shopingapp/app/modules/cart/service/cart_service.dart';
import 'package:shopingapp/app/modules/cart/service/i_cart_service.dart';
import 'package:shopingapp/app/modules/orders/controller/orders_controller.dart';
import 'package:shopingapp/app/modules/orders/repo/i_orders_repo.dart';
import 'package:shopingapp/app/modules/orders/service/i_orders_service.dart';
import 'package:shopingapp/app/modules/orders/service/orders_service.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../app/modules/orders/repo/orders_mocked_repo.dart';
import '../app/modules/overview/repo/overview_mocked_repo.dart';

class OrdersTestConfig {
  final IOrdersRepo _mocked_repo_used_in_this_module_test = OrdersMockedRepo();

  void _bindingsBuilder(IOrdersRepo ordersRepo) {
    Get.reset();

    expect(Get.isPrepared<DarkThemeController>(), isFalse);

    expect(Get.isPrepared<IOverviewRepo>(), isFalse);
    expect(Get.isPrepared<IOverviewService>(), isFalse);
    expect(Get.isPrepared<OverviewController>(), isFalse);

    expect(Get.isPrepared<IOrdersRepo>(), isFalse);
    expect(Get.isPrepared<IOrdersService>(), isFalse);
    expect(Get.isPrepared<OrdersController>(), isFalse);

    expect(Get.isPrepared<ICartRepo>(), isFalse);
    expect(Get.isPrepared<ICartService>(), isFalse);
    expect(Get.isPrepared<CartController>(), isFalse);

    var binding = BindingsBuilder(() {
      Get.lazyPut<DarkThemeController>(() => DarkThemeController());

      //OVERVIEW
      Get.lazyPut<IOverviewRepo>(() => OverviewMockedRepo());
      Get.lazyPut<IOverviewService>(
          () => OverviewService(repo: Get.find<IOverviewRepo>()));
      Get.lazyPut<OverviewController>(
          () => OverviewController(service: Get.find<IOverviewService>()));

      //ORDERS
      Get.lazyPut<IOrdersRepo>(() => ordersRepo);
      Get.lazyPut<IOrdersService>(() => OrdersService(repo: Get.find<IOrdersRepo>()));
      Get.lazyPut<OrdersController>(
          () => OrdersController(service: Get.find<IOrdersService>()));

      //CART
      Get.lazyPut<ICartRepo>(() => CartRepoHttp());
      Get.lazyPut<ICartService>(() => CartService(repo: Get.find<ICartRepo>()));
      Get.lazyPut<CartController>(() => CartController(
          cartService: Get.find<ICartService>(),
          ordersService: Get.find<IOrdersService>()));
    });

    binding.builder();

    expect(Get.isPrepared<DarkThemeController>(), isTrue);

    expect(Get.isPrepared<IOverviewRepo>(), isTrue);
    expect(Get.isPrepared<IOverviewService>(), isTrue);
    expect(Get.isPrepared<OverviewController>(), isTrue);

    expect(Get.isPrepared<IOrdersRepo>(), isTrue);
    expect(Get.isPrepared<IOrdersService>(), isTrue);
    expect(Get.isPrepared<OrdersController>(), isTrue);

    expect(Get.isPrepared<ICartRepo>(), isTrue);
    expect(Get.isPrepared<ICartService>(), isTrue);
    expect(Get.isPrepared<CartController>(), isTrue);

    HttpOverrides.global = null;
  }

  void bindingsBuilderMockedRepo({required bool isWidgetTest}) {
    if (isWidgetTest) _bindingsBuilder(_mocked_repo_used_in_this_module_test);
  }

  void bindingsBuilderMockRepoEmptyDb({required bool isWidgetTest}) {
    if (isWidgetTest) _bindingsBuilder(OrdersMockedRepoEmptyDb());
  }

  String repoName() => _mocked_repo_used_in_this_module_test.runtimeType.toString();

  // @formatter:off
  //GROUP-TITLES ---------------------------------------------------------------
  static get ORDERS_GROUP_TITLE => 'Orders|Integration-Tests:';

  //MVC-TITLES -----------------------------------------------------------------
  get REPO_TEST_TITLE => '${repoName()}|Repo: Unit';
  get SERVICE_TEST_TITLE => '${repoName()}|Service: Unit';
  get CONTROLLER_TEST_TITLE => '${repoName()}|Controller: Integr';
  get VIEW_TEST_TITLE => '${repoName()}|View: Functional';

  //TEST-TITLES ----------------------------------------------------------------
  get check_oneOrderInDB => 'Opening View ONE ORDER in DB';
  get check_emptyDB => 'Opening View NONE Order in DB';
  get tap_ViewBackButton => 'Testing View BackButton';
  get ordering_InCartView_tapOrderNowBtn =>
      'Ordering from CartView - Taping OrderNow Button';
  // @formatter:on
}
