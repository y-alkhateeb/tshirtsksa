import 'package:flutter/material.dart';
import 'app.dart';
import 'core/common/appConfig.dart';
import 'core/localization/localization_provider.dart';
import 'service_locator.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _appLanguage = AppConfigProvider();
  // Init Language.
  await _appLanguage.fetchLocale();
  appConfig.initVersion();
  setupInjection();
  runApp(
    App(
      appLanguage: _appLanguage,
    ),
  );
}