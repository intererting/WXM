enum DevEnvironment { DEBUG, RELEASE }

const DevEnvironment environment = DevEnvironment.DEBUG;

//开发环境
class BuildConfig {
  String baseUrl = 'http://118.123.213.213:80/wxm_ws/';

  static final Map<DevEnvironment, BuildConfig> singleton = new Map();

  factory BuildConfig(DevEnvironment type) {
    if (singleton.containsKey(type)) {
      return singleton[type];
    } else {
      BuildConfig buildConfig = new BuildConfig._internal(type);
      singleton[type] = buildConfig;
      return buildConfig;
    }
  }

  BuildConfig._internal(DevEnvironment type) {
    switch (type) {
      case DevEnvironment.DEBUG:
        baseUrl = 'http://118.123.213.213:80/wxm_ws/';
        break;
      case DevEnvironment.RELEASE:
        baseUrl = 'http://118.123.213.213:80/wxm_ws/';
        break;
    }
  }
}
