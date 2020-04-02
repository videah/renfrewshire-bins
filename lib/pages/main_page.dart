import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:renfrewshire_bins/models.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isLoading = true;
  List<BinCollection> _binCollections = [];

  @override
  void initState() {
    _cacheImages();
    _getBins();
    super.initState();
  }

  Future _cacheImages() async {
    List<String> bins = [
      "green",
      "grey",
      "brown",
      "blue",
    ];

    bins.forEach((bin) async {
      await precacheImage(AssetImage("assets/images/bin_$bin.png"), context);
    });
  }

  Future _getBins() async {
    String prefix = "RENFREWSHIREBINCOLLECTIONS_";
    String webpageUrl = "http://renfrewshire.gov.uk/checkyourbincollectionday";

    // We just provide these headers to make the request look more authentic.
    // Not that I expect them to notice or anything.
    var headers = {
      "Accept": "text/javascript, application/javascript",
      "Referer": webpageUrl,
      "X-Requested-With": "XMLHttpRequest",
    };

    http.Response formScrapResponse = await http.get(webpageUrl);
    dom.Document document = parser.parse(formScrapResponse.body);
    var form = document.getElementById("${prefix}FORM");
    var params = Uri.parse(form.attributes["action"]).queryParameters;

    var box = Hive.box("details");
    FormData formData = FormData.fromMap({
      "${prefix}PAGESESSIONID": params["pageSessionId"],
      "${prefix}SESSIONID": params["fsid"],
      "${prefix}NONCE": params["fsn"],
      "${prefix}VARIABLES": "e30=",
      "${prefix}PAGENAME": "PAGE1",
      "${prefix}PAGEINSTANCE": 0,
      "${prefix}PAGE1_ADDRESSSTRING": box.get("addressString"),
      "${prefix}PAGE1_UPRN": box.get("uprn"),
      "${prefix}PAGE1_ADDRESSLOOKUPPOSTCODE": box.get("postcode"),
      "${prefix}PAGE1_ADDRESSLOOKUPADDRESS": 7,
      "${prefix}FORMACTION_NEXT": "Load Address",
      "${prefix}PAGE1_FIELD13": false,
    });

    var uri = Uri.http(
      "renfrewshire.gov.uk",
      "/apiserver/formsservice/http/processsubmission",
      params,
    );

    try {
      await Dio().postUri(
        uri,
        data: formData,
        options: Options(headers: headers),
      );
    } on DioError catch (error) {
      if (error.response.statusCode == 302) {
        var url = error.response.headers["location"][0];
        print(url);
        http.Response binScrapResponse = await http.get(url);
        dom.Document document = parser.parse(binScrapResponse.body);

        var next = document
            .getElementsByClassName("collection collection--next")
            .first;
        var nextDate =
            next.getElementsByClassName("collection__date").first.text;
        var nextBins = next.getElementsByClassName("bins");
        var nextBinCollection = _parseBinCollection(nextBins);
        nextBinCollection.collectionDate = nextDate;

        List<BinCollection> collections = [nextBinCollection];
        var futureBins = document
            .getElementsByClassName("collection collection--future")
            .first;

        futureBins.children.forEach((binRow) {
          var date =
              binRow.getElementsByClassName("collection__date").first.text;
          var bins = binRow.getElementsByClassName("bins").first.children;
          BinCollection collection = _parseBinCollection(bins);
          collection.collectionDate = date;
          collections.add(collection);
        });

        setState(() {
          _binCollections = collections;
          _isLoading = false;
        });
        return collections;
      }
    }
  }

  BinCollection _parseBinCollection(List<dom.Element> bins) {
    BinCollection collection = BinCollection();
    bins.forEach((bin) {
      var name = bin.getElementsByClassName("bins__name").first.firstChild.text;
      collection.bins.add(Bin(name));
    });
    return collection;
  }

  @override
  Widget build(BuildContext context) {
    _cacheImages();
    return Scaffold(
      appBar: AppBar(
        title: Text("Renfrewshire Bins"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help),
            tooltip: "Help",
            onPressed: () {
              Navigator.of(context).pushNamed("/help");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: "Settings",
            onPressed: () {
              Navigator.of(context).pushNamed("/settings");
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          ValueListenableBuilder(
            valueListenable: Hive.box("settings").listenable(),
            builder: (context, box, widget) {
              if ((box.get("hideInfoBox") ?? false)) return Container();
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Card(
                  elevation: 4.0,
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 42,
                      ),
                      title: Text(
                        "Please put your bin(s) out for collection before 7.00am.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (_isLoading) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Loading Bins"),
                      ),
                    ],
                  );
                }
                return RefreshIndicator(
                  onRefresh: _getBins,
                  child: ListView.builder(
                    itemCount: _binCollections.length,
                    itemBuilder: (context, i) {
                      BinCollection collection = _binCollections[i];
                      DateFormat format = DateFormat("EEEE d MMMM y");
                      DateTime date = format.parse("${collection.collectionDate}");
                      DateTime now = DateTime.now();

                      var difference = now.difference(date).inDays;
                      var labelText = "Unknown Error";
                      if (difference == 0) {
                        labelText = "Due Today!";
                      } else if (difference == 1) {
                        labelText = "Due Tomorrow";
                      } else {
                        labelText = "Due in $difference days";
                      }

                      if (i == 0) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                "Your Next Collection",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text("${collection.collectionDate}"),
                              trailing: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                                color: Colors.green,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0,
                                      top: 10.0,
                                      right: 16.0,
                                      bottom: 10.0),
                                  child: Text(
                                    labelText,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 16.0, left: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  for (var bin in collection.bins)
                                    Container(
                                      width: 135.0,
                                      height: 275.0,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                            "/help/info",
                                            arguments:
                                            bin.name.toLowerCase().trim(),
                                          );
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              image: AssetImage(
                                                "assets/images/bin_${bin.name.toLowerCase().trim()}.png",
                                              ),
                                            ),
                                            Text(
                                              "${bin.name.trim()}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      } else {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                i == 1 ? "Your Future Collections" : "",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text("${collection.collectionDate}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 16.0,
                                left: 16.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  for (var bin in collection.bins)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0, bottom: 8.0),
                                      child: Container(
                                        width: 65.0,
                                        height: 140.0,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              "/help/info",
                                              arguments:
                                                  bin.name.toLowerCase().trim(),
                                            );
                                          },
                                          child: Column(
                                            children: <Widget>[
                                              Image(
                                                image: AssetImage(
                                                  "assets/images/bin_${bin.name.toLowerCase().trim()}.png",
                                                ),
                                              ),
                                              Text(
                                                "${bin.name.trim()}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      }
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
