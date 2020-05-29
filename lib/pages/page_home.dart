

import 'package:flutter/material.dart';
import 'package:flutter_countryselector/manager/country_selector_manager.dart';
import 'package:flutter_countryselector/pages/page_country_selector.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  String name,code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
        body: Center(
          
          
            child:  Column(


                mainAxisAlignment: MainAxisAlignment.center,
              
               children: <Widget>[
                 
                 
                 
                    RaisedButton(
                        
                     onPressed: () async{

//                       var data = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CountrySelectorPage()));
                       var data = await CountrySelectorManager.get().push(context);

                       name = data['name'];

                       code  = data['code'].toString();

                       setState(() {

                       });
                       
                    },child: Text("请选择国家"),),
                 
                   Text("name : $name , \n code : $code",style: TextStyle( fontSize: 35),)
                 
                 
                  
               ],
            ),
        ),
    );
  }
}
