import 'package:test/test.dart';

import 'orders_controller_test.dart';
import 'orders_test_config.dart';
import 'view/orders_functional_test.dart';
import 'repo/orders_repo_test.dart';
import 'service/orders_service_test.dart';

class OrdersTest {
  static void groups() {
    group("${OrdersTestConfig().REPO_TEST_TITLE}", OrdersRepoTests.unit);
    group("${OrdersTestConfig().SERVICE_TEST_TITLE}", OrdersServiceTests.unit);
    group(
        "${OrdersTestConfig().CONTROLLER_TEST_TITLE}", OrdersControllerTests.integration);
    group("${OrdersTestConfig().VIEW_TEST_TITLE}", OrdersViewTests().functional);
  }
}
