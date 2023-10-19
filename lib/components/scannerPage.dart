import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_tagger/DataModels/Tree.dart';
import 'package:forest_tagger/components/treeListItem.dart';
import 'package:forest_tagger/main.dart';

class ScannerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScannerPageState();
  }
}

class ScannerPageState extends State<ScannerPage> {
  List<Tree> listOfScanneedTrees = [];

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.green, width: 3.0),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      String res = await FlutterBarcodeScanner.scanBarcode(
                          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
                      var arr = res.split(", ");
                      Tree t = Tree(arr[0], (arr[1]), (arr[2]));
                      TreeProvider().insert(t);
                      List<Tree> newList = [];
                      listOfScanneedTrees.forEach((element) {
                        newList.add(element);
                      });
                      newList.add(t);
                      setState(() {
                        listOfScanneedTrees = newList;
                      });
                    },
                    child: Text(
                      'Open Scanner',
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Divider(
                  color: Colors.black,
                  height: 20,
                  thickness: 1,
                  endIndent: 0,
                ),
              ),
              StreamBuilder(
                stream: TreeProvider().getTrees().asStream(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return new Text("Error!");
                  } else if (snapshot.data == null) {
                    return LinearProgressIndicator();
                  } else {
                    return Container(
                      height: 400,
                      child: ListView(
                        children: [
                          for (int i = 0; i < snapshot.data.length; i++)
                            TreeListItem(i + 1, Tree.fromMap(snapshot.data[i]))
                        ],
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
