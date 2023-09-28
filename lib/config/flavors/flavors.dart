import 'dart:developer';

import 'base_config/base_config.dart';
import 'base_config/dev_config.dart';
import 'base_config/prod_config.dart';

enum AppEnv { dev, prod }

class Flavors {
  late BaseConfig _config;

  BaseConfig get config => _config;

  initConfig(AppEnv appEnv) {
    _config = _getConfig(appEnv);
    log(" 'Environment' configured with $appEnv ✓");
  }

  BaseConfig _getConfig(AppEnv appEnv) {
    switch (appEnv) {
      case AppEnv.dev:
        return DevConfig();
      case AppEnv.prod:
        return ProdConfig();
      default:
        return DevConfig();
    }
  }
}
