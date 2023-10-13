import 'package:ZdroweRasowe/buttons/build_card_privacy_policy.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ZdroweRasowe/buttons/build_card_app.dart';
import 'package:ZdroweRasowe/buttons/build_card_dog.dart';
import 'package:ZdroweRasowe/buttons/build_card_family.dart';
import 'package:ZdroweRasowe/pages/fb.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'buttons/build_card_cat.dart';
import 'buttons/build_card_guarantee.dart';
import 'buttons/build_card_premium.dart';
import 'buttons/build_card_safe.dart';
import 'buttons/build_card_warning.dart';
import 'buttons/build_card_vet.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {

  @override
  void initState() {
    super.initState();
    _checkVersionAndroid();
    _checkVersionIos();
  }

  void _checkVersionAndroid() async {
    String appStoreLink = "https://play.google.com/store/apps/details?id=studio.aleksandraweber.store";
    final newVersionPlus = NewVersionPlus(
        androidId: "studio.aleksandraweber.store",
        androidPlayStoreCountry: "PL");
    newVersionPlus.showAlertIfNecessary(context: context);
    final status = await newVersionPlus.getVersionStatus();
    status!.appStoreLink;
    newVersionPlus.showUpdateDialog(
        context: context,
        versionStatus: status!,
        dialogTitle: "Update avaliable",
        allowDismissal: true,
        dismissButtonText: "Later",
        dismissAction: () => SystemNavigator.pop(),
        dialogText: "Update your app to the latest version",
        updateButtonText: "Let's update"
    );
  }

  void _checkVersionIos() async {
    String appStoreLink = "https://appstoreconnect.apple.com/apps/6466717422/appstore/ios/version/deliverable";
    final newVersionPlus = NewVersionPlus(
        iOSId: "studio.aleksandraweber.zdrowerasowe",
        iOSAppStoreCountry: "PL");
    newVersionPlus.showAlertIfNecessary(context: context);
    final status = await newVersionPlus.getVersionStatus();
    status!.appStoreLink;
    newVersionPlus.showUpdateDialog(
        context: context,
        versionStatus: status!,
        dialogTitle: "Update avaliable",
        allowDismissal: true,
      dismissAction: () => SystemNavigator.pop(),
      dismissButtonText: "Later",
        dialogText: "Update your app to the latest version",
        updateButtonText: "Let's update"
        );
  }

  final List locale = [
    {"name": "English", "locale": const Locale("en", "US")},
    {"name": "Polish", "locale": const Locale("pl", "PL")},
    {"name": "українська", "locale": const Locale("ua", "UA")},
    {"name": "Deutsch", "locale": const Locale("de", "DE")}
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  List imageList = [
    {"id": 2, "image_path": 'assets/pies1.jpg'},
    {"id": 3, "image_path": 'assets/pies2.jpg'},
    {"id": 4, "image_path": 'assets/pies3.jpg'},
    {"id": 5, "image_path": 'assets/pies4.png'},
    {"id": 5, "image_path": 'assets/pies5.jpg'},
    {"id": 6, "image_path": 'assets/szczeniak1.png'},
    {"id": 7, "image_path": 'assets/psy1.png'},
    {"id": 8, "image_path": 'assets/psy2.jpg'},
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  double screenWidth = 0;
  double screenHeight = 0;

  Icon languageIcon = const Icon(Icons.language_rounded);

  builddialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text("title".tr),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () {
                            print(locale[index]["name"]);
                            updateLanguage(locale[index]["locale"]);
                          },
                          child: Text(locale[index]["name"])),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Image.asset("assets/zr-bez-tla.png"),
          backgroundColor: Colors.blueGrey,
          actions: [
            IconButton(
              icon: languageIcon,
              color: Colors.amber,
              onPressed: () {
                builddialog(context);
                Text("changeLang".tr);
              },
            ),
          ],
        ),
        body: Container(
          color: Colors.blueGrey,
          child: Column(children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    print(currentIndex);
                  },
                  child: CarouselSlider(
                    items: imageList
                        .map(
                          (item) => Image.asset(
                            item['image_path'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                        .toList(),
                    carouselController: carouselController,
                    options: CarouselOptions(
                      scrollPhysics: const BouncingScrollPhysics(),
                      autoPlay: true,
                      aspectRatio: 1.5,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () =>
                            carouselController.animateToPage(entry.key),
                        child: Container(
                          width: currentIndex == entry.key ? 17 : 8,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 3.0,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentIndex == entry.key
                                  ? Colors.red
                                  : Colors.teal),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  SizedBox(width: 15),
                  BuildCardApp(),
                  SizedBox(width: 15),
                  BuildCardFamily(),
                  SizedBox(width: 15),
                  BuildCardDog(),
                  SizedBox(width: 15),
                  BuildCardCat(),
                  SizedBox(width: 15),
                  BuildCardVet(),
                  // SizedBox(width: 15),
                  // BuildCardHealth(),
                  // SizedBox(width: 15),
                  // BuildCardLaw(),
                  SizedBox(width: 15),
                  BuildCardSafe(),
                  SizedBox(width: 15),
                  BuildCardWarning(),
                  SizedBox(width: 15),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const BuildCardGuarantee(),
            // SizedBox(height: 15),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     children: [
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           // Text(
            //           //   "strategic_partners".tr,
            //           //   style: TextStyle(fontSize: 18, color: Colors.white),
            //           // ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 25),
            const Row(
              children: [
                // StrategicPartners(),
                // FB(),
                SizedBox(
                  width: 280,
                ),
                BuildCardPremium(),
              ],
            ),
            const SizedBox(height: 3),
            // BuildCardWebsite()

            Row(
              children: [
                FB(),
                SizedBox(
                  width: 50,
                ),
                Image.asset(
                  "assets/kot-linia.png",
                  color: Colors.red[400],
                  height: 50,
                  width: 200,
                ),
              ],
            ),
            const SizedBox(
              height: 38,
            ),
            BuildCardPrivacyPolicy(),
            // const BuildCardStudio(),
          ]),
        ));
  }
}
