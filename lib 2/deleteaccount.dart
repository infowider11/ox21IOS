import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/register.dart';
import 'package:ox21/secure_account_step_one.dart';
import 'package:ox21/select_language.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customtextfield.dart';

class DeleteAccountPage extends StatefulWidget {
  static const String id="delte";
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  bool isChecked = false;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
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
      appBar: appBar(context: context,
          title: 'Delete Account',
          titleColor: MyColors.primaryColor,
          actions: [
            IconButton(onPressed: (){}, icon: Image.asset(MyImages.logowelcom, width: 35, height: 40, fit: BoxFit.fitHeight,))
          ]
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox,
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //   child: ParagraphText(text: 'Delete Account',
                //     fontSize: 18,
                //     fontFamily: 'bold',
                //   ),
                // ),
                vSizedBox4,
                Stack(
                  children: [

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      child: CustomTextFieldlabel(
                        labeltext: 'Mnemonic phrase',
                        controller: emailcontroller,
                        hintText: '***** **** **** ***** ',
                        left: 16,
                        fontsize: 12,
                        hintcolor: MyColors.inputbordercolor,
                        maxLines: 3,
                        suffixIcon: MyImages.scan,
                        bgColor: Colors.white,
                        border: Border.all(color: MyColors.strokelabel),
                      ),
                    ),
                    Positioned(
                      child: Image.asset(MyImages.eye_visble, width: 24,),
                      right: 60,
                      top: 20,
                    ),
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
                      text: 'Once you delete an account, there is no way to recover it\nAre you sure you want to delete your account?',
                      color: MyColors.lighttext,
                      fontSize: 12,
                      fontFamily: 'regular',
                    ),
                  ],
                ),
                vSizedBox2,
                RoundEdgedButton(
                  text: 'Delete Account',
                  textColor: Colors.white,
                  color: Color(0xFFDC2430),
                  borderRadius: 12,
                  width: MediaQuery.of(context).size.width - 32,
                  fontSize: 16,
                  verticalPadding: 20,
                  horizontalMargin: 16,
                  fontfamily: 'medium',
                  onTap: (){
                    Navigator.pushNamed(context, Select_language.id);
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
