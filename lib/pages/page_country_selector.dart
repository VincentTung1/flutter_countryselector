
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_countryselector/entity/Country.dart';
import 'package:lpinyin/lpinyin.dart';

class CountrySelectorPage extends StatefulWidget {
  @override
  _CountrySelectorPageState createState() => _CountrySelectorPageState();
}

class _CountrySelectorPageState extends State<CountrySelectorPage> {


  List<Widget> indexWidgets;

  ScrollController _controller = ScrollController();


  bool _isHighlight = false;

  String _currentLetter = "";


  Map<int,double> _heights = {};


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.addListener((){

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(

          leading: InkWell(

              onTap: (){

                 Navigator.pop(context);
              },

              child: Icon(Icons.arrow_back),
          ),

          title: Text("国家选择",style: TextStyle(color: Colors.white),),centerTitle: true,),

        body: Container(

            child: FutureBuilder(

               future: _getCountrys(),

               builder: (context,snapshot){

                  if(!snapshot.hasData) return Container();


                  List<Widget> listWidgets  =  snapshot.data;

                  return Stack(
                    children: <Widget>[

                      ListView(
                          children: listWidgets,

                         controller: _controller,
                      ),



                      Positioned(

                        right: 20,

                        top: 10,

                        child: Container(

                           width: 30,

                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.all(Radius.circular(10.0)),

                              color: Colors.grey

                          ),

                          child:  ListView(

                          shrinkWrap: true,

                           physics: NeverScrollableScrollPhysics(),

                          children: indexWidgets,
                        ),

                        ),

                      ),





                      Visibility(

                        visible: _isHighlight,

                        child: Center(

                           child:Container(

                              alignment: Alignment.center,

                               width: 100,

                               height: 100,

                               color: Colors.black38,

                               child: Text(_currentLetter,style: TextStyle(fontSize: 80,color: Colors.white),))
                        ),
                      )


                    ],
                  );
               },
            )
        ),
    );
  }

  Future<List<Widget>> _getCountrys() async{

    var countryStr = await DefaultAssetBundle.of(context).loadString('assets/code.json');

    List<dynamic> data = await json.decode(countryStr);

    List<Country> _countrys = new List();
    await data.forEach((map) {
         Country country = Country.fromJson(map);
         _countrys.add(country);

    });

    List<Widget> _items  = new List();

    await _countrys.sort((left,right) {

          var leftName =  PinyinHelper.getShortPinyin(left.zh);

          var rightName = PinyinHelper.getShortPinyin(right.zh);

         return leftName.compareTo(rightName);
    });


    indexWidgets = List();

    var _lastFirstPinYinWord;

    _heights.clear();
    double currentHeight = 0;

    await _countrys.asMap().keys.map((index){


      var firsstPinYinWord =  PinyinHelper.getShortPinyin(_countrys[index].zh).substring(0,1).toUpperCase();


      Container item =  new Container(      //列表item数据

            child:

            Column(children: <Widget>[

              Visibility(

                child:
                Container(
                    height:45,
                    child: ListTile(title: Text(
                      firsstPinYinWord, style: TextStyle(fontSize: 28),),)),

                visible: _lastFirstPinYinWord != firsstPinYinWord,
              ),


               Container(

                   height: 45,
                   child: ListTile(
                     onTap: (){
                       print(_countrys[index].zh);


                        Navigator.pop(context,{

                            "name" : _countrys[index].zh,

                            "code" : _countrys[index].code
                        });
                     },
                     title: Row(

                       crossAxisAlignment: CrossAxisAlignment.center,

                       children: <Widget>[
                         Text(_countrys[index].zh),

                         SizedBox(width: 10,),


                         Container(

                             alignment: Alignment.center,
                             child: Text("+${_countrys[index].code}",style: TextStyle(color: Colors.grey)))
                       ],
                     ),)

               ),
            ],)


         );
         _items.add(item);


          //记录每个控件的高度
         if(_lastFirstPinYinWord != firsstPinYinWord){

             _heights[index] = currentHeight;

             currentHeight += 90;
         }else{
             currentHeight += 45;
         }


         if(_lastFirstPinYinWord != firsstPinYinWord){      // 拼音指示器item数据
           indexWidgets.add(Container(


                width: 30,

                height: 30,

                padding: EdgeInsets.all(5),

                alignment: Alignment.center,

               child: InkWell(

                    onHighlightChanged: (highlight){

                        setState(() {
                          _isHighlight = highlight;

                          _currentLetter = firsstPinYinWord;
                        });
                    },

                    onTap: (){


                      var height  =   _heights[index];

                      if(height >= _controller.position.maxScrollExtent){

                        _controller?.jumpTo(_controller.position.maxScrollExtent);
                      }else{
                        _controller?.jumpTo(height);
                      }



                    },

                   child: Text(firsstPinYinWord,style: TextStyle(fontSize: 20),))));
         }


       _lastFirstPinYinWord = firsstPinYinWord;
    }).toList();

    return _items;
  }

}
