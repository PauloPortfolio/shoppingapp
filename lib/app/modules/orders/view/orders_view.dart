import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/custom_widgets/custom_indicator.dart';
import '../../../core/custom_widgets/custom_sliver_appbar.dart';
import '../../../core/texts_icons_provider/pages/components/app_messages_provided.dart';
import '../../../core/texts_icons_provider/pages/order/orders_texts_icons_provided.dart';
import '../controller/orders_controller.dart';
import '../core/custom_listview/staggered_sliver_listview.dart';

class OrdersView extends StatelessWidget {
  final _controller = Get.find<OrdersController>();
  final _sliverAppbar = Get.find<CustomSliverAppBar>();

  @override
  Widget build(BuildContext context) {
    _controller.getOrders();
    return Scaffold(
        body: Obx(
      () => _controller.ordersObs.isEmpty
          ? CustomIndicator.message(message: NO_ORD, fontSize: 20)
          : CustomScrollView(slivers: [
              _sliverAppbar.create(ORD_TIT_PAGE, Get.back),
              StaggeredSliverListview().ordersListview(_controller.ordersObs.toList())
            ]),
    ));
  }
}