import 'dart:async';

import 'package:flutter/material.dart';


import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:loading_animations/loading_animations.dart';




class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "https://operationicare.org/";
  bool isLoading = true;

  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription<WebViewStateChanged> _onchanged; // here we checked the url state if it loaded or start Load or abort Load

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onchanged = flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        if(state.type== WebViewState.finishLoad){ // if the full website page loaded
          print("loaded...");
        }else if (state.type== WebViewState.abortLoad){ // if there is a problem with loading the url
          print("there is a problem...");
        } else if(state.type== WebViewState.startLoad){ // if the url started loading
          print("start loading...");
        }
      }
    });



  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flutterWebviewPlugin.dispose(); // disposing the webview widget to avoid any leaks
  }



  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        url: url, // run javascript
        withZoom: false, // if you want the user zoom-in and zoom-out
        hidden: true , // put it true if you want to show CircularProgressIndicator while waiting for the page to load

        appBar: AppBar(
          title: Text("Icare"),
          centerTitle: false,
          backgroundColor: Colors.green,
          elevation: 1, // give the appbar shadows
          iconTheme: IconThemeData(color: Colors.white),
          actions: <Widget>[
            InkWell(
              child: Icon(Icons.refresh),
              onTap: (){
                flutterWebviewPlugin.reload();
                // flutterWebviewPlugin.reloadUrl(); // if you want to reloade another url
              },
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              child: Icon(Icons.arrow_back),
              onTap: (){
                flutterWebviewPlugin.goBack(); // for going back
              },
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              child: Icon(Icons.arrow_forward,size: 23,),
              onTap: (){
                flutterWebviewPlugin.goForward(); // for going forward
              },
            ),
            SizedBox(
              width: 10,
            )

          ],// make the icons colors inside appbar with white color

        ),


        initialChild: Container( // but if you want to add your own waiting widget just add InitialChild
          color: Colors.white,
          child:  Center(
            child: LoadingBouncingLine.circle(
                              size: 34,
                              backgroundColor: Colors.green,
                            ),
          ),)


    );
  }
}