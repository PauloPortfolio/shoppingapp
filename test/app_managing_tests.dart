import 'package:test/test.dart';

import 'app/pages_modules/cart/cart_controller_test.dart';
import 'app/pages_modules/cart/cart_repo_test.dart';
import 'app/pages_modules/cart/cart_service_test.dart';
import 'app/pages_modules/orders/orders_repo_test.dart';
import 'app/pages_modules/overview/controller/overview_controller_test.dart';
import 'app/pages_modules/overview/overview_page_test.dart';
import 'app/pages_modules/overview/repo/overview_repo_test.dart';
import 'app/pages_modules/overview/service/overview_service_test.dart';

void main() {
  const OVERVIEW_MODULE_PAGE = 'Overview Page|';
  group(
    "$OVERVIEW_MODULE_PAGE\Mocked-Repo: Unit",
    OverviewRepoTest.unitTests,
  );
  group(
    "$OVERVIEW_MODULE_PAGE\Service|Mocked-Repo: Unit",
    OverviewServiceTest.unitTests,
  );
  group(
    "$OVERVIEW_MODULE_PAGE\Controller|Service|Mocked-Repo: Integr",
    OverviewControllerTest.integrationTests,
  );
  group(
    "$OVERVIEW_MODULE_PAGE\UI(WidgetTests): Integr",
    OverviewPageTest.widgetTests,
  );
//***********
  const CART_MODULE_PAGE = 'Cart Page|';
  group("$CART_MODULE_PAGE\Repo: Unit", CartRepoTest.unitTests);
  group("$CART_MODULE_PAGE\Service|Repo: Unit", CartServiceTest.unitTests);
  group(
    "$CART_MODULE_PAGE\Controller|Service|Repo: Integr",
    CartControllerTest.integrationTests,
  );

  const ORDERS_MODULE_PAGE = 'Orders Page|';
  group("$ORDERS_MODULE_PAGE\Repo: Unit", OrdersRepoTest.unitTests);

  // group("$ORDERS_MODULE_PAGE\Service|Repo: Unit", CartServiceTest.unitTests);
  // group(
  //   "$ORDERS_MODULE_PAGE\Controller|Service|Repo: Integr",
  //   CartControllerTest.integrationTests,
  // );
}