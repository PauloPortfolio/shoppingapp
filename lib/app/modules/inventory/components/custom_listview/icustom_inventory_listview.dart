import 'package:flutter/widgets.dart';

import '../../../../modules/inventory/entity/product.dart';

abstract class ICustomInventoryListview {
  Widget inventoryListview(List<Product> products);
}