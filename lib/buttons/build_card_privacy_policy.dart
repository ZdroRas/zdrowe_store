import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildCardPrivacyPolicy extends StatefulWidget {
  const BuildCardPrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<BuildCardPrivacyPolicy> createState() => _BuildCardPrivacyPolicyState();
}

class _BuildCardPrivacyPolicyState extends State<BuildCardPrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 380,
      height: 60,
      child: TextButton(onPressed: () {
        Uri uri = Uri.parse("https://www.zdrowerasowe.pl/regulamin-i-polityka-prywatnosci");
        launchUrl(uri);
      },
        child: Text("policy".tr, style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
            textAlign: TextAlign.center
        ),
      ),
    );
  }
}