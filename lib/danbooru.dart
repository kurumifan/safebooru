import 'package:flutter/material.dart';

import 'package:firebase_admob/firebase_admob.dart';


///Android ad ID
final String myAppID = "ca-app-pub-7280036561880717~6090211926";
final String myAdMobAdUnitId = "ca-app-pub-7280036561880717/5067956052";

BannerAd myBanner = new BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: myAdMobAdUnitId,
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
  keywords: <String>['anime', 'beautiful picture', 'comic'],
  contentUrl: 'https://www.ai16bit.com',
  birthday: new DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender: MobileAdGender
      .unknown, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);



class Danbooru extends StatefulWidget {
  @override
  _DanbooruState createState() => new _DanbooruState();
}

class _DanbooruState extends State<Danbooru> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseAdMob.instance.initialize(appId: myAppID);

    myBanner
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 60.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
  }


  int setcount = 2;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        ///column按钮
        leading: IconButton(
          icon: Icon(Icons.view_column),
          onPressed: () {
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 60.0,
                    child: new Row(children: <Widget>[
                      Expanded(
                        child: new IconButton(
                          icon: Icon(Icons.view_week),
                          onPressed: () {
                            setState(() {
                              setcount < 10 ? setcount++ : setcount;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: new IconButton(
                          icon: Icon(Icons.pause),
                          onPressed: () {
                            setState(() {
                              setcount > 2 ? setcount-- : setcount;
                            });
                          },
                        ),
                      ),
                    ]),
                  );
                });
          },
        ),
        title: new Text('danbooru.donmai.us'),
        actions: <Widget>[
          new IconButton(
            onPressed: () {
              // Navigator.of(context).push(new MaterialPageRoute(
              //     builder: (BuildContext context) => new AdPage()));
            },
            icon: Icon(Icons.search),
          ),         
        ],
      ),
      body: new Center(
        child: new Text('这是测试'),
      ),
    );
  }
}
