import 'package:b2b_project/src/config/database_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'src/app.dart';

initialization() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await DatabaseConfig().database;
}



void main() async {
  await initialization();
  runApp(MyApp());
}
