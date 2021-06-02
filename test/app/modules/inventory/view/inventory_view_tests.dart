import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/core/messages/field_form_validation_provided.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_add_edit_view.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_view.dart';
import 'package:shopingapp/app/modules/overview/components/overview_grid_item.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';

import '../../../../app_tests_config.dart';
import '../../../../test_utils/test_utils.dart';
import '../../../../test_utils/view_test_utils.dart';

class InventoryViewTests {
  final _seek = Get.put(TestUtils());
  final _viewTestUtils = Get.put(ViewTestUtils());

  Future tapingBackButtonInInventoryView(tester) async {
    await _viewTestUtils.navigationBetweenViews(
      tester,
      from: InventoryView,
      to: OverviewView,
      trigger: BackButton,
      delaySeconds: DELAY,
    );
  }

  Future checkInventoryProductsAbsence(
    WidgetTester tester,
    int delaySeconds,
  ) async {
    await _viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      keyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetQtde: 0,
      widgetType: InventoryItem,
    );

    expect(_seek.text(NO_INVENTORY_PRODUCTS_FOUND_YET), findsOneWidget);

    await _viewTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: InventoryView,
      to: OverviewView,
      trigger: BackButton,
    );
  }

  Future refreshingInventoryView(tester) async {
    await tester.pump();

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: OverviewView,
      widgetType: OverviewGridItem,
      widgetQtde: 4,
    );

    await _viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: DELAY,
      keyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetType: InventoryItem,
      widgetQtde: 4,
    );

    // "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0"
    // var dragInitialPointElement = _seek.key('$INVENTORY_ITEM_KEY${_prods[0].id}');
    // await tester.drag(dragInitialPointElement, Offset(0.0, -50.0));
    await tester.pump();
    await tester.pumpAndSettle(_seek.delay(1));

    expect(_seek.type(RefreshIndicator), findsNWidgets(1));
  }

  Future updateInventoryProduct(
    tester, {
    String currentTitle,
    String updatedTitle,
    String keyUpdateButton,
    int delaySeconds,
  }) async {
    await tester.pump();

    await _viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      keyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    // 1) InventoryView
    //   -> Check 'CurrentTitle'
    //   -> Click in 'UpdateButton'
    //   -> Open InventoryAddEditView
    expect(_seek.text(currentTitle), findsWidgets);
    await tester.tap(_seek.key(keyUpdateButton));
    await tester.pump();
    await tester.pumpAndSettle(_seek.delay(delaySeconds));

    // 2) InventoryAddEditView
    //   -> Checking View + Title-Form-Field
    expect(_seek.type(InventoryAddEditView), findsOneWidget);
    expect(_seek.text(currentTitle), findsWidgets);

    // 3) InventoryAddEditView
    //   -> Insert 'UpdatedValue' in Title-Page-Form-Field
    //   -> Checking the change
    await tester.tap(_seek.key(INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY));
    await tester.enterText(_seek.key(INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY), updatedTitle);
    await tester.pump();
    await tester.pump(_seek.delay(delaySeconds));
    expect(_seek.text(updatedTitle), findsOneWidget);

    // 4) Save form
    //   -> Tap Saving (Backing to InventoryView automatically)
    //   -> Test absence of INValidation messages
    //   -> Checking UpdatedValue
    await tester.tap(_seek.key(INVENTORY_ADDEDIT_VIEW_SAVEBUTTON_KEY));
    await tester.pump();
    await tester.pump(_seek.delay(delaySeconds));
    expect(_seek.text(INVALID_TITLE_MSG), findsNothing);
    expect(_seek.text(updatedTitle), findsOneWidget);
    expect(_seek.type(InventoryView), findsOneWidget);

    // 5) Click InventoryView-BackButton
    //   -> Go to OverviewView + UpdatedValue

    //todo: BUG Update - the key BACKbUTTON is being tapped; HOWEVER, it does not go to
    // OverviewView
    //THEREFORE: the test fail in find OverviewView
    await tester.tap(_seek.type(BackButton));
    await tester.pump(_seek.delay(delaySeconds));
    expect(_seek.type(OverviewView), findsOneWidget);
    expect(_seek.text(updatedTitle), findsOneWidget);
  }

  Future deleteInventoryProduct(
    tester, {
    int initialQtde,
    int finalQtde,
    String keyDeleteButton,
    Type widgetTypeToDelete,
  }) async {
    await tester.pump();

    await _viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: DELAY,
      keyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetQtde: initialQtde,
      widgetType: widgetTypeToDelete,
    );

    await tester.tap(_seek.key(keyDeleteButton));
    await tester.pump();
    await tester.pumpAndSettle(_seek.delay(DELAY));

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetQtde: finalQtde,
      widgetType: widgetTypeToDelete,
    );

    await _viewTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: DELAY,
      from: InventoryView,
      to: OverviewView,
      trigger: BackButton,
    );

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: OverviewView,
      widgetQtde: 1,
      widgetType: OverviewGridItem,
    );
  }

  Future checkInventoryProducts(tester, int ProductsQtde) async {
    await tester.pump();

    await _viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: DELAY,
      keyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetType: InventoryItem,
      widgetQtde: ProductsQtde,
    );
  }
}
