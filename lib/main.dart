import 'package:calculadora_imc_hive/model/pessoa_model_hive.dart';
import 'package:calculadora_imc_hive/my_app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory = await path_provider.getApplicationCacheDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(PessoaModelHiveAdapter());
  runApp(const MyApp());
}
