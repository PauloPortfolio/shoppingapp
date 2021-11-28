import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../../core/keys/inventory_keys.dart';
import '../../../../core/texts_icons_provider/generic_words.dart';
import '../../../../core/texts_icons_provider/pages/inventory/inventory_item_icons_provided.dart';
import '../../../../core/texts_icons_provider/pages/inventory/messages_snackbars_provided.dart';
import '../../../overview/controller/overview_controller.dart';
import '../../controller/inventory_controller.dart';
import '../../entity/product.dart';
import '../../view/inventory_edit_view.dart';
import 'icustom_inventory_listtile.dart';

class InventoryItemAnimatedListtile implements ICustomInventoryListtile {
  // final Product product;
  final _inventoryController = Get.find<InventoryController>();
  final _overviewController = Get.find<OverviewController>();

  // InventoryItemAnimatedListtile({required this.product});

  @override
  Widget create(Product product) {
    var _id = product.id!;
    // var context = APP_CONTEXT_GLOBAL_KEY.currentContext;

    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      openBuilder: (context, void Function({Object? returnValue}) openContainer) {
        return InventoryEditView(_id);
      },
      closedBuilder: (context, void Function() openContainer) {
        return ListTile(
            key: Key('$K_INV_ITEM_KEY$_id'),
            leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
            title: Text(product.title),
            trailing: Container(
                width: 100,
                child: Row(children: <Widget>[
                  IconButton(
                      key: Key('$K_INV_UPD_BTN$_id'),
                      icon: INV_ITEM_UPD_ICO,
                      onPressed: openContainer,
                      color: Theme.of(context).errorColor),
                  IconButton(
                      key: Key('$K_INV_DEL_BTN$_id'),
                      icon: INV_ITEM_DEL_ICO,
                      // @formatter:off
                    onPressed: () =>
                        _inventoryController.deleteProduct(_id).then((statusCode) {
                          if (statusCode >= 200 && statusCode < 400) {
                            _inventoryController.updateInventoryProductsObs();
                            _overviewController.deleteProduct(_id);
                            _overviewController.updateFilteredProductsObs();
                            SimpleSnackbar(SUCES, SUCESS_MAN_PROD_DEL).show();
                          }
                          if (statusCode >= 400) SimpleSnackbar(OPS, ERROR_MAN_PROD).show();
                        }),
                      // @formatter:on
                      color: Theme.of(context).errorColor),
                ])));
      },
    );

    // return ListTile(
    //     key: Key('$K_INV_ITEM_KEY$_id'),
    //     leading: CircleAvatar(backgroundImage: NetworkImage(_imageUrl)),
    //     title: Text(_title),
    //     trailing: Container(
    //         width: 100,
    //         child: Row(children: <Widget>[
    //           IconButton(
    //               key: Key('$K_INV_UPD_BTN$_id'),
    //               icon: INV_ITEM_UPD_ICO,
    //               onPressed: () => InventoryEditView(_id),
    //               color: Theme.of(context).errorColor),
    //           IconButton(
    //               key: Key('$K_INV_DEL_BTN$_id'),
    //               icon: INV_ITEM_DEL_ICO,
    //               // @formatter:off
    //               onPressed: () =>
    //                   _inventoryController.deleteProduct(_id).then((statusCode) {
    //                     if (statusCode >= 200 && statusCode < 400) {
    //                       _inventoryController.updateInventoryProductsObs();
    //                       _overviewController.deleteProduct(_id);
    //                       _overviewController.updateFilteredProductsObs();
    //                       SimpleSnackbar(SUCES, SUCESS_MAN_PROD_DEL).show();
    //                     }
    //                     if (statusCode >= 400) SimpleSnackbar(OPS, ERROR_MAN_PROD).show();
    //                   }),
    //               // @formatter:on
    //               color: Theme.of(context).errorColor),
    //         ])));
  }
}