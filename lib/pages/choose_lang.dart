import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/global_functions.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../constants/global_constants.dart';
import '../modals/languages.dart';


class ChooseLanguage extends StatefulWidget {
  final bool fromSplash;
  static const String id = "chooseLanguage";
  const ChooseLanguage({Key? key, this.fromSplash = false}) : super(key: key);

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {

  List<LanguageModal> languages = [
    LanguageModal('English', 'en'),
    LanguageModal('Chineese', 'zh'),
    // Language('Arabian', 'ar'),
  ];
  get()async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    currentLanguage=sharedPreferences.getString('lang').toString();
    setState(() {

    });
    print("sharedPreferences"+sharedPreferences.toString());
  }
  @override
  void initState() {
    // TODO: implement initState
    get();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyColors.whitelight,
      appBar: appBar(context: context, title: translate("choose_lang.title"),),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: ()async{
                      SharedPreferences sharedPreferences =await SharedPreferences.getInstance();

                      currentLanguage="en";
                      sharedPreferences.setString("lang","en");
                      var delegate = await LocalizationDelegate.create(
                          fallbackLocale: currentLanguage, supportedLocales: [currentLanguage]);
                      await LocalizationDelegate.create(
                          fallbackLocale:currentLanguage, supportedLocales: [currentLanguage]);

                      try{
                        changeUserLanguage(userId, currentLanguage);
                      }catch(e){
                        print('hello');
                      }
                      print("sharedPreferences--$currentLanguage-----------"+sharedPreferences.getString('lang').toString());

                      setState(() {

                      });
                      if(widget.fromSplash){
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                      height: 130,
                      // width: MediaQuery.of(context).size.width/2-64,
                      decoration: BoxDecoration(
                        color: MyColors.whitelight,
                        borderRadius: BorderRadius.circular(8),
                        // border: Border.all(color: MyColors.black54Color, width: 1)
                        boxShadow: [BoxShadow(
                          color: MyColors.greyColor,
                          blurRadius: 4,
                          spreadRadius: 2,
                          offset: Offset(0, 5)
                        )],

                        border: currentLanguage=="en"?Border.all(
                          color: MyColors.grey,
                          width: 1
                        ):Border.all(
                            color: Colors.transparent,
                            width: 1
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/images/usa.png', width: 80,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MainHeadingText(text:translate("choose_lang.en"), fontSize: 12,),
                              if(currentLanguage=="en")
                              Icon(Icons.check, size: 16,)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: GestureDetector(
                    onTap: ()async{
                      SharedPreferences sharedPreferences =await SharedPreferences.getInstance();

                      currentLanguage="zh";
                      sharedPreferences.setString("lang",currentLanguage);
                      var delegate = await LocalizationDelegate.create(
                          fallbackLocale: currentLanguage, supportedLocales: [currentLanguage]);
                      await LocalizationDelegate.create(
                          fallbackLocale:currentLanguage, supportedLocales: [currentLanguage]);
                      print("sharedPreferences--$currentLanguage-----------"+sharedPreferences.getString('lang').toString());
                      try{
                        changeUserLanguage(userId, currentLanguage);
                      }catch(e){
                        print('hello');
                      }
                      setState(() {

                      });
                      if(widget.fromSplash){
                        Navigator.pop(context);
                      }

                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      padding: EdgeInsets.only(bottom: 16, left: 16, right: 16
                      ),
                      height: 130,
                      width: MediaQuery.of(context).size.width/2-64,
                      decoration: BoxDecoration(
                          color: MyColors.whitelight,
                          borderRadius: BorderRadius.circular(8),
                          // border: Border.all(color: MyColors.black54Color, width: 1)
                          boxShadow: [BoxShadow(
                              color: MyColors.greyColor,
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: Offset(0, 5)
                          )],
                          border: currentLanguage=="zh"?Border.all(
                              color: MyColors.grey,
                              width: 1
                          ):Border.all(
                              color: Colors.transparent,
                              width: 1
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/images/china.png', width: 80,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MainHeadingText(text:translate("choose_lang.zh"), fontSize: 12,),
                              if(currentLanguage=="zh")
                              Icon(Icons.check, size: 16,)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
