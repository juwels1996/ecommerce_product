import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//===================Regex=======================//

final letterOnly = FilteringTextInputFormatter.allow(
  RegExp(r"[a-zA-Z]+|\s"),
);

final numberOnly = FilteringTextInputFormatter.allow(
  RegExp(r"\d"),
);

//==============DATA BASE=============//

const String databaseName = 'b2b.db';
const int databaseVersion = 1;

const String userTable = 'users';
const String productTable = 'products';
const String orderTable = 'orders';
const String orderItemsTable = 'order_items';
