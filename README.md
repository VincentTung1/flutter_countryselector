# flutter_countryselector
Flutter版的国家选择器。


## 使用方法

  1.导入包
  `import 'package:flutter_countryselector/manager/country_selector_manager.dart';`

  2.调用,返回  Future<Map<String,Object>> 对象
 `await CountrySelectorManager.get().push(context);`