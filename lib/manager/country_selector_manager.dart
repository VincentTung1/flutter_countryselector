

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countryselector/pages/page_country_selector.dart';

class CountrySelectorManager{

  static CountrySelectorManager _instance = CountrySelectorManager();

  static CountrySelectorManager get() => _instance;

  Future<Map<String,Object>> push(BuildContext context) async =>
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CountrySelectorPage()));

}
