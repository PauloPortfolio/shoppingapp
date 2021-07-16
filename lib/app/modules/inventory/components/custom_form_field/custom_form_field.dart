import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';

import '../../../../core/properties/app_form_field_sizes.dart';
import '../../../../core/properties/app_properties.dart';
import '../../core/texts_icons/inventory_edit_texts_icons_provided.dart';
import '../../entities/product.dart';
import 'field_validators/description_validator.dart';
import 'field_validators/price_validator.dart';
import 'field_validators/title_validator.dart';
import 'field_validators/url_validator.dart';
import 'field_validators/validator_abstraction.dart';

class CustomFormField {
  final ValidatorAbstraction _title = TitleValidator();
  final ValidatorAbstraction _price = PriceValidator();
  final ValidatorAbstraction _descr = DescriptionValidator();
  final ValidatorAbstraction _url = UrlValidator();

  String _hint;
  String _labelText;
  TextInputAction _textInputAction;
  TextInputType _textInputType;
  String _initialValue;
  int _maxLength;
  var _controller;

  var _validatorCriteria;

  TextFormField create({
    required Product product,
    required BuildContext context,
    required Function function,
    required String fieldName,
    required String key,
    required FocusNode node,
    var controller,
  }) {
    _loadTextFieldsParameters(fieldName, product);

    return TextFormField(
      key: Key(key),

      //************  CONTROLLER + INITIAL_VALUE are incompativel  ************
      initialValue: controller == null ? _initialValue : null,
      controller: controller ?? (fieldName == INV_ADEDT_FLD_PRICE ? _controller : null),
      //***********************************************************************
      decoration: InputDecoration(labelText: _labelText, hintText: _hint),
      textInputAction: _textInputAction,
      maxLength: _maxLength,
      maxLines: fieldName == INV_ADEDT_FLD_DESCR ? 4 : 1,
      keyboardType: _textInputType,
      validator: _validatorCriteria,
      onFieldSubmitted: function,
      onSaved: (field) => _loadProductWithFieldValue(fieldName, product, field),
      focusNode: node,
    );
  }

  void _loadTextFieldsParameters(String fieldName, Product product) {
    switch (fieldName) {
      case INV_ADEDT_FLD_TITLE:
        {
          _labelText = fieldName;
          _textInputAction = TextInputAction.next;
          _textInputType = TextInputType.text;
          _maxLength = FIELD_TITLE_MAX_SIZE;
          _validatorCriteria = _title.validate();
          _initialValue = product.title;
        }
        break;
      case INV_ADEDT_FLD_PRICE:
        {
          _labelText = fieldName;
          _textInputAction = TextInputAction.next;
          _textInputType = TextInputType.number;
          _maxLength = FIELD_PRICE_MAX_SIZE;
          _validatorCriteria = _price.validate();
          _initialValue = product.price == null ? null : product.price.toString();
          _controller = product.price == null ? _priceController() : null;
        }
        break;
      case INV_ADEDT_FLD_DESCR:
        {
          _labelText = fieldName;
          _textInputAction = TextInputAction.next;
          _textInputType = TextInputType.multiline;
          _maxLength = FIELD_DESCRIPT_MAX_SIZE;
          _validatorCriteria = _descr.validate();
          _initialValue = product.description;
        }
        break;
      case INV_ADEDT_FLD_IMGURL:
        {
          _labelText = fieldName;
          _textInputAction = TextInputAction.done;
          _textInputType = TextInputType.url;
          _validatorCriteria = _url.validate();
          _maxLength = FIELD_URL_MAX_SIZE;
          _initialValue = product.imageUrl == null ? null : product.imageUrl;
        }
        break;
    }
  }

  CurrencyTextFieldController _priceController() {
    return CurrencyTextFieldController(
        rightSymbol: CURRENCY_FORMAT,
        decimalSymbol: DECIMAL_SYMBOL,
        thousandSymbol: THOUSAND_SYMBOL);
  }

  void _loadProductWithFieldValue(String field, Product product, var value) {
    if (field == INV_ADEDT_FLD_TITLE) product.title = value;
    if (field == INV_ADEDT_FLD_IMGURL) product.imageUrl = value;
    if (field == INV_ADEDT_FLD_DESCR) product.description = value;
    if (field == INV_ADEDT_FLD_PRICE) {
      var stringValue = value as String;
      stringValue = stringValue.replaceAll(",", "");
      stringValue = stringValue.replaceAll("\$", "");
      product.price = double.parse(stringValue);
    }
  }
}
