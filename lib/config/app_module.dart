// extends from MainModule
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/entities_models/product.dart';
import 'package:shopingapp/repositories/i_products_repo.dart';
import 'package:shopingapp/repositories/products_repo.dart';
import 'package:shopingapp/service_stores/ItemsOverviewGridProductItemStore.dart';
import 'package:shopingapp/service_stores/ItemsOverviewGridProductsStore.dart';
import 'package:shopingapp/views/cart_view.dart';
import 'package:shopingapp/views/item_detail_view.dart';
import 'package:shopingapp/views/items_overview_fav_view.dart';
import 'package:shopingapp/views/items_overview_view.dart';

import '../app_driver.dart';
import 'appProperties.dart';

class AppModule extends MainModule {
  // here will be any class you want to inject into your project (eg bloc, dependency)
  @override
  List<Bind> get binds => [
        Bind<IItemsOverviewGridProductsStore>((i) => ItemsOverviewGridProductsStore()),
        Bind<IItemsOverviewGridProductItemStore>((i) => ItemsOverviewGridProductItemStore(),
            singleton: false),
        Bind<IProductsRepo>((i) => ProductsRepo()),
        Bind((i) => Product),
      ];

  // here will be the routes of your module
  @override
  List<Router> get routers => [
        Router(ROUTE_ITEM_OVERV_VIEW, child: (_, args) => ItemsOverviewView()),
        Router(ROUTE_ITEM_OVERV_FAV_VIEW,
            child: (_, args) => ItemsOverviewFavView(), transition: TransitionType.noTransition),
        Router(ROUTE_CART, child: (_, args) => CartView()),
        Router(ROUTE_ITEM_DETAIL + ':id', child: (_, args) => ItemDetailView(args.params['id'])),
      ];

  @override
  Widget get bootstrap => AppDriver();
}
