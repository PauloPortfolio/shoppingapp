import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/config/routes.dart';
import 'package:shopingapp/config/titlesIconsMessages/views/managedProductView.dart';

import 'package:shopingapp/service_stores/managedProductsStore.dart';
import 'package:shopingapp/widgets/drawwer.dart';
import 'package:shopingapp/widgets/managedProductItem.dart';

class ManagedProductsView extends StatefulWidget {
  @override
  _ManagedProductsViewState createState() => _ManagedProductsViewState();
}

class _ManagedProductsViewState extends State<ManagedProductsView> {
  final _store = Modular.get<ManagedProductsStoreInt>();

  @override
  void initState() {
    _store.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(MAN_APPBAR_TIT), actions: <Widget>[
        IconButton(
            icon: MAN_ADD_APPBAR_ICO,
            onPressed: () => Modular.to.pushReplacementNamed(MANAGEDPRODUCT_ADD_VIEW))
      ]),
      drawer: Drawwer(),
      body: Observer(
          builder: (BuildContext _) => ListView.builder(
              itemCount: _store.products.length,
              itemBuilder: (ctx, item) => Column(children: <Widget>[
                    ManagedProductItems(
                      _store.products[item].get_id(),
                      _store.products[item].get_title(),
                      _store.products[item].get_imageUrl(),
                    ),
                    Divider()
                  ]))),
    );
  }
}
