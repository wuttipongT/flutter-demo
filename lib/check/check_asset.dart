import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:asset_mobile/model/drawer_item.dart';

import 'dart:async';
import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:asset_mobile/bloc/session_bloc.dart';

class CheckAsset extends StatefulWidget {
  final DrawerItem drawerItem;

  CheckAsset({Key key, @required this.drawerItem}) : super(key: key);

  @override
  CheckAssetState createState() {
    return new CheckAssetState();
  }
}

class CheckAssetState extends State<CheckAsset> {
  final txtLocation = TextEditingController();
  final txtBarcode = TextEditingController();
  String _section;
  String _year;
  String _month;
  String _token;
  FocusNode _node1 = FocusNode();

  @override
  void initState() {
    super.initState();
    bloc.getSession();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<Map>(
      stream: bloc.subject.stream,
      builder: (context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          return _buildCheckAssetWidget(snapshot.data);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Loading data..."), CircularProgressIndicator()],
        ));
  }

  @override
  void deactivate() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }


  Widget _buildCheckAssetWidget(Map o) {
    this._section = o['section'];
    this._year = o['year'];
    this._month = o['month'];
    this._token = o['token'];

    return new Column(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.location_on),
          title: new TextField(
//            autofocus: true,
            decoration: new InputDecoration(
                hintText: "Location"
            ),
            controller: txtLocation,
            onSubmitted: (term) {
              FocusScope.of(context).requestFocus(_node1);
            },
          ),
        ),
        ListTile(
          leading: Icon(Icons.scanner),
          title: new TextField(
            focusNode: _node1,
            decoration: new InputDecoration(
                hintText: "Scan Asset Number"
            ),
            controller: txtBarcode,
            onSubmitted: (term) {_checkData();},
          ),
          trailing: new IconButton(icon: Icon(Icons.camera_alt), onPressed: barcodeScanning) ,
        ),
        const Divider(
          height: 1.0,
        )
        ,
        ListTile(
          leading: new IconButton(icon: Icon(Icons.group), onPressed: barcodeScanning),
          title: const Text('Sections'),
          subtitle: Text("$_section"),
        ),
        ListTile(
          leading: new IconButton(icon: Icon(Icons.calendar_today), onPressed: barcodeScanning),
          title: const Text('Year'),
          subtitle: Text('$_year'),
        ),
        ListTile(
          leading: new IconButton(icon: Icon(Icons.calendar_today), onPressed: barcodeScanning),
          title: const Text('Month'),
          subtitle: Text('$_month'),
        )
      ],
    );
  }

  Future barcodeScanning() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
//        this.barcode = barcode;
        this.txtBarcode.text = barcode;
        _checkData();
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          _showMessage("No camera permission!");
        });
      } else {
        setState(() {
          _showMessage("Unknown error: $e");
        });
      }
    } on FormatException {
      setState(() {
//        _showMessage("Nothing captured.");
      });
    } catch (e) {
      setState(() {
        _showMessage("Unknown error: $e");
      });
    }
  }

  Future _checkData() async {
    String url = "http://assets.world-electric.com/api/input";
    try {
      var box = {
        "location":  txtLocation.text,
        "assetnb": txtBarcode.text,
        "section": this._section,
        "year": this._year,
        "month": this._month
      };
      Response response = await Dio().post(url, data: box, options: new Options(headers: {"Authorization": "Bearer $_token"}));

      Map<String, dynamic> o = response.data;
      if (o['success']) {
        _showSnackBar("Success Check ${o['success1']}", Colors.lightGreen);
      } else if (o['success2']){
        _showSnackBar("Double Check ${o['error1']}", Colors.redAccent);
      } else if (o['success3']) {
        _showSnackBar("Section Not Found ${o['error1']}", Colors.redAccent);
      }else {
        _showSnackBar("Data Not Found ${o['error1']}", Colors.redAccent);
      }

      txtBarcode.selection = TextSelection(baseOffset:0, extentOffset: txtBarcode.text.length);

    } catch (e) {
      print(e);
    }
  }
  _showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text the user has typed in using our
          // TextEditingController
          content: Text(message),
        );
      },
    );
  }

  _showSnackBar(String message, Color _color) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(message),
        backgroundColor: _color
    ));
  }
}