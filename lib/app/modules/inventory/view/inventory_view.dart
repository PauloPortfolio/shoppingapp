import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../../../core/properties/app_routes.dart';
import '../../components/app_messages_provided.dart';
import '../../components/progres_indicator.dart';
import '../components/inventory_item.dart';
import '../controller/inventory_controller.dart';
import '../core/inventory_keys.dart';
import '../core/texts_icons/inventory_texts_icons_provided.dart';

class InventoryView extends StatelessWidget {
  final InventoryController controller;

  InventoryView({this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(INV_TIT_APPBAR), actions: <Widget>[
        IconButton(
            key: Key(K_INV_ADD_BTN),
            icon: INV_ICO_ADD_APPBAR,
            onPressed: () =>
                Get.toNamed(AppRoutes.MANAGED_PRODUCTS_ADDEDIT_PAGE))
      ]),

      // GERENCIA DE ESTADO REATIVA - COM O GET
      body: Obx(() => (controller.getManagedProductsObs().length == 0
          ? ProgresIndicator.message(message: NO_PROD, fontSize: 20)
          : RefreshIndicator(
              onRefresh: controller.getProducts,
              child: controller.getManagedProductsObs().length == 0
                  ? Center(child: Text('cccc'))
                  : ListView.builder(
                      itemCount: controller.getManagedProductsObs().length,
                      itemBuilder: (ctx, i) => Column(children: [
                            InventoryItem(
                              product: controller.getManagedProductsObs()[i],
                              inventoryController: controller,
                              overviewController: Get.find(),
                            ),
                            Divider()
                          ]))))),
    );
  }
}
// GERENCIA DE ESTADO SIMPLES - COM O GET
//      body: GetBuilder<ManagedProductsController>(
//          init: ManagedProductsController(),
//          builder: (_) => ListView.builder(
//              itemCount: _.managedProducts.length,
//              itemBuilder: (ctx, item) => Column(children: [
//                    ManagedProductItem(
//                      _.managedProducts[item].id,
//                      _.managedProducts[item].title,
//                      _.managedProducts[item].imageUrl,
//                    ),
//                    Divider()
//                  ]))),

//----------