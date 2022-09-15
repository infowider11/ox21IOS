import 'dart:convert';

import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/pages/forgot_password_page.dart';
import 'package:ox21/register.dart';
import 'package:ox21/secure_account_step_one.dart';
import 'package:ox21/select_channels.dart';
import 'package:ox21/select_language.dart';
import 'package:ox21/select_location.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/tab.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';


class SignInPage extends StatefulWidget {
  static const String id="mnemonic";
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isChecked = false;
  bool passVisible = false;
  bool load = false;

  String strength = passwordStrength[0];
  TextEditingController passPhraseController = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  Uuid uuid = Uuid();
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return MyColors.primaryColor;
  }
  @override
  Widget build(BuildContext context) {
    bool isSwitched = true;
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      appBar:load?null:  appBar(context: context,
          actions: [
            IconButton(onPressed: (){}, icon: Image.asset(MyImages.logowelcom, width: 35, height: 40, fit: BoxFit.fitHeight,))
          ]
      ),
      body:load?CustomLoader():  Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ParagraphText(text: 'Sign in with  Mnemonic Phrase',
                    fontSize: 18,
                    fontFamily: 'bold',
                  ),
                ),
                vSizedBox,
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //   child: ParagraphText(text: 'This password will unlock your OX21 account only on this service.',
                //     fontSize: 16,
                //     fontFamily: 'regular',
                //     color: MyColors.textcolor,
                //   ),
                // ),
                vSizedBox4,
                Stack(
                  children: [

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      child: CustomTextFieldlabel(
                        labeltext: 'Mnemonic phrase',
                        controller: passPhraseController,
                        hintText: 'Enter the 12 Words pass phrase',
                        left: 16,
                        fontsize: 12,
                        hintcolor: MyColors.inputbordercolor,
                        suffixIcon: MyImages.scan,
                        bgColor: Colors.white,
                        border: Border.all(color: MyColors.strokelabel),
                        onChanged: (value){
                          setState(() {

                          });
                        },
                      ),
                    ),
                    // Positioned(
                    //   child: Image.asset(MyImages.eye_visble, width: 24,),
                    //   right: 60,
                    //   top: 20,
                    // ),
                  ],
                ),
                vSizedBox2,
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  child: CustomTextFieldlabel(
                    labeltext: 'password',
                    controller: passwordcontroller,
                    hintText: '*****',
                    left: 16,
                    fontsize: 12,
                    obscureText: passVisible,
                    hintcolor: MyColors.inputbordercolor,
                    suffixIconButton:   IconButton(
                      icon: Icon(passVisible?Icons.visibility:Icons.visibility_off_outlined,size: 26,),
                      onPressed: (){
                        setState(() {
                          passVisible = !passVisible;
                        });
                      },
                    ),
                    // suffixIcon: MyImages.eye_visble,
                    bgColor: Colors.white,
                    border: Border.all(color: MyColors.strokelabel),
                    onChanged: (value){
                      setState(() {

                      });
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 32.0),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       ParagraphText(
                //         text: 'Password strength: ',
                //         color: MyColors.textcolor,
                //         fontSize: 12,
                //         fontFamily: 'regular',
                //       ),
                //       ParagraphText(
                //         text: strength,
                //         color: Colors.green,
                //         fontSize: 12,
                //         // underlined: true,
                //         fontFamily: 'semibold',
                //       ),
                //     ],
                //   ),
                // ),
                vSizedBox2,
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                //   child: CustomTextFieldlabel(
                //     labeltext: 'Confirm password',
                //     controller: passwordcontroller,
                //     hintText: '********',
                //     obscureText: true,
                //     left: 16,
                //     fontsize: 12,
                //     hintcolor: MyColors.inputbordercolor,
                //     suffixIcon: MyImages.eye_visble,
                //     border: Border.all(color: MyColors.strokelabel),
                //     bgColor: Colors.white,
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ParagraphText(
                            text: 'Must be at least 8 characters',
                            color: MyColors.textcolor,
                            fontSize: 11,
                            fontFamily: 'regular',
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordPage()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only( right: 16),
                        child:ParagraphText(
                          text: 'Forgot Password?',
                          color: MyColors.blueColor,
                          fontSize: 11,
                          fontFamily: 'regular',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex:8,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: ParagraphText(text: 'Sign in with Face ID/Touch ID?', fontFamily: 'medium', fontSize: 18, color: MyColors.primaryColor,),
                        )
                    ),

                    Expanded(
                      flex: 2,
                      child: Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            // print(isSwitched);
                          });
                        },
                        activeTrackColor: MyColors.primaryColor,
                        activeColor: MyColors.whiteColor,
                      ),),
                  ],
                ),

              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ParagraphText(
                      text: 'By proceeding, you agree to these ',
                      color: MyColors.lighttext,
                      fontSize: 12,
                      fontFamily: 'regular',
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: ()async{
                        if (!await launch(MyGlobalConstants.termsAndConditionsLink)) throw 'Could not launch ${MyGlobalConstants.termsAndConditionsLink}';
                      },
                      child: ParagraphText(
                        text: 'Term and Conditions.',
                        color: MyColors.primaryColor,
                        fontSize: 12,
                        fontFamily: 'regular',
                      ),
                    ),
                  ],
                ),
                vSizedBox2,
                RoundEdgedButton(
                  text: 'Sign in',
                  textColor: Colors.white,
                  color:
                  // passPhraseController.text.isNotEmpty && passwordcontroller.text.length>7? 
                  MyColors.primaryColor,
                  // : 
                  // Colors.grey.shade300,
                  borderRadius: 12,
                  width: MediaQuery.of(context).size.width - 32,
                  fontSize: 16,
                  verticalPadding: 20,
                  horizontalMargin: 16,
                  fontfamily: 'medium',
                  onTap: ()async{
                    // FocusScope.of(context).requestFocus(new FocusNode());
                    //  Navigator.pushNamed(context, MyStatefulWidget.id);
                    List words = passPhraseController.text.split(" ");
                    if(words.length!=12){
                      showSnackbar(context, 'Mnemonic phrase must be of 12 words');
                    }else if(passwordcontroller.text.length<8){
                      showSnackbar(context, 'Password must be of at least 8 characters');
                    }else{
                      setState(() {
                        load = true;
                      });
                      // sample login credentials
                      // career albino eric portal dollar citrus mary style alfred orient yogurt samuel
                      // 1234@Manish
                      String typedPhrase =
                      uuid.v5(Uuid.NAMESPACE_URL, passPhraseController.text);
                      Crypt hashedPass = Crypt.sha256(
                          passwordcontroller.text,
                          salt: MyGlobalConstants.passwordSalt);
                          // bool result = true;
                      bool result = await Webservices.login(uuid: typedPhrase, password: hashedPass.hash, context: context);
                      setState(() {
                        load = false;
                      });
                      if(result){
                        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        Map userData = jsonDecode(sharedPreferences.getString('data')!);
                        if(userData['language']==0)
                        Navigator.pushNamed(context, Select_language.id);
                        else if(userData['country']==null){
                          await Navigator.pushNamed(context, Select_location.id);
                        }else if(userData['channels']==[]){
                          Navigator.pushNamed(context, SelectChannelPage.id);
                        }else{
                          Navigator.pushNamed(context, MyStatefulWidget.id);
                        }
                      }
                    }
                    
                  },
                ),
                vSizedBox2,
              ],
            ),
          )
        ],
      ),
    );
  }
}
