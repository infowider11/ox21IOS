import 'package:crypt/crypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:ox21/congratulations.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/pages/terms_and_conditions_page.dart';
import 'package:ox21/register.dart';
import 'package:ox21/secure_account_step_one.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import 'constants/getStrengthColor.dart';

class CreatePassword extends StatefulWidget {
  static const String id = "createpasswordpage";
  final List passPhrase;
  const CreatePassword({Key? key, required this.passPhrase}) : super(key: key);

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  bool isChecked = false;
  bool isThirteen = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  Uuid uuid = Uuid();

  bool load = false;

  String strength = passwordStrength[0];

  bool passVisible = false;

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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: load
            ? null
            : appBar(context: context, actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                MyImages.logowelcom,
                width: 35,
                height: 40,
                fit: BoxFit.fitHeight,
              ))
        ]),
        body: load
            ? CustomLoader()
            : Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vSizedBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ParagraphText(
                      text: translate("createPassword.title"),
                      fontSize: 18,
                      fontFamily: 'bold',
                    ),
                  ),
                  vSizedBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ParagraphText(
                      text:
                      translate("createPassword.subTitle"),
                      fontSize: 16,
                      fontFamily: 'regular',
                      color: MyColors.textcolor,
                    ),
                  ),
                  vSizedBox4,
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    child: CustomTextFieldlabel(
                      labeltext: translate("createPassword.newPassword"),
                      controller: passwordController,
                      obscureText: !passVisible,
                      hintText: '********',
                      left: 16,
                      fontsize: 12,
                      hintcolor: MyColors.inputbordercolor,
                      suffixIconButton: IconButton(
                        icon: Icon(
                          passVisible
                              ? Icons.visibility
                              : Icons.visibility_off_outlined,
                          size: 26,
                        ),
                        onPressed: () {
                          setState(() {
                            passVisible = !passVisible;
                          });
                        },
                      ),
                      onChanged: (value) {
                        if (value.length < 8) {
                          print(' ia her');
                          strength = passwordStrength[4];
                          setState(() {});
                        } else {
                          print(value);
                          RegExp upperCaseRegex = RegExp("^(?=.*[A-Z])");
                          RegExp lowerCaseRegex = RegExp("^(?=.*[a-z])");
                          RegExp numberRegex = RegExp("^(?=.*[0-9])");
                          RegExp specialCharacterRegex =
                          RegExp("^(?=.*?[#?!@\$%^&*-])");
                          print('_________');
                          print(upperCaseRegex.hasMatch(value));
                          print(lowerCaseRegex.hasMatch(value));
                          print(numberRegex.hasMatch(value));
                          print(specialCharacterRegex.hasMatch(value));

                          int tempStrength = -1;
                          if (upperCaseRegex.hasMatch(value))
                            tempStrength++;
                          if (lowerCaseRegex.hasMatch(value))
                            tempStrength++;
                          if (numberRegex.hasMatch(value)) tempStrength++;
                          if (specialCharacterRegex.hasMatch(value))
                            tempStrength++;
                          if (tempStrength != -1)
                            setState(() {
                              strength = passwordStrength[tempStrength];
                            });
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ParagraphText(
                          text: translate("createPassword.passStrength"),
                          color: MyColors.textcolor,
                          fontSize: 12,
                          fontFamily: 'regular',
                        ),
                        Expanded(
                          child: ParagraphText(
                            text: strength,
                            color: getStrengthColor(strength),
                            fontSize: 12,
                            // underlined: true,
                            fontFamily: 'semibold',
                          ),
                        ),
                      ],
                    ),
                  ),
                  vSizedBox2,
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    child: CustomTextFieldlabel(
                      labeltext: translate("createPassword.confirmPassword"),
                      controller: confirmpasswordController,
                      hintText: '********',
                      obscureText: true,
                      left: 16,
                      fontsize: 12,
                      hintcolor: MyColors.inputbordercolor,
                      onChanged: (v) {
                        setState(() {});
                      },
                      suffixIcon: passwordController.text ==
                          confirmpasswordController.text &&
                          (strength == passwordStrength[2] ||
                              strength == passwordStrength[3])
                          ? MyImages.check_green
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ParagraphText(
                          text: translate("createPassword.passValidation"),
                          color: MyColors.textcolor,
                          fontSize: 12,
                          fontFamily: 'regular',
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 8,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: ParagraphText(
                              text: translate("createPassword.signInToggle"),
                              fontFamily: 'medium',
                              fontSize: 18,
                              color: MyColors.primaryColor,
                            ),
                          )),
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
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 0, horizontal: 16),
                    child: Row(
                      children: [
                        Checkbox(
                          visualDensity:
                          VisualDensity(horizontal: -4, vertical: 0),
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          checkColor: Colors.white,
                          fillColor:
                          MaterialStateProperty.resolveWith(getColor),
                          value: isThirteen,
                          onChanged: (bool? value) {
                            setState(() {
                              isThirteen = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8),
                            child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,

                                    letterSpacing: 0,
                                  ),
                                  children: [
                                    TextSpan(
                                        text:
                                        translate("createPassword.13yearoldertext")),

                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Row(
                      children: [
                        Checkbox(
                          visualDensity:
                          VisualDensity(horizontal: -4, vertical: 0),
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          checkColor: Colors.white,
                          fillColor:
                          MaterialStateProperty.resolveWith(getColor),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8),
                            child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,

                                    letterSpacing: 0,
                                  ),
                                  children: [
                                    TextSpan(
                                        text:
                                        translate("createPassword.checkboxText")),
                                    TextSpan(
                                      text: translate("createPassword.learnMore"),
                                      style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline,),
                                      recognizer: new TapGestureRecognizer()..onTap = ()async{
                                        // if (!await launch(MyGlobalConstants.termsAndConditionsLink)) throw 'Could not launch ${MyGlobalConstants.termsAndConditionsLink}';
                                        push(context: context, screen: TermsAndConditionsPage());
                                      },
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  vSizedBox2,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ParagraphText(
                      text: translate("createPassword.tipText"),
                      color: MyColors.primaryColor,
                      fontSize: 12,
                      fontFamily: 'bold',
                    ),
                  ),
                  vSizedBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ParagraphText(
                              text: "• ",
                              fontSize: 20,
                              color: MyColors.bulletcolor,
                            ),
                            Expanded(
                              child: ParagraphText(
                                text:
                                translate("createPassword.tip1"),
                                color: MyColors.bulletcolor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ParagraphText(
                              text: "• ",
                              fontSize: 20,
                              color: MyColors.bulletcolor,
                            ),
                            Expanded(
                              child: ParagraphText(
                                text:
                                translate("createPassword.tip2"),
                                color: MyColors.bulletcolor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ParagraphText(
                              text: "• ",
                              fontSize: 20,
                              color: MyColors.bulletcolor,
                            ),
                            Expanded(
                              child: ParagraphText(
                                text: translate("createPassword.tip3"),
                                color: MyColors.bulletcolor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ParagraphText(
                              text: "• ",
                              fontSize: 20,
                              color: MyColors.bulletcolor,
                            ),
                            Expanded(
                              child: ParagraphText(
                                text:
                                translate("createPassword.tip4"),
                                color: MyColors.bulletcolor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  vSizedBox2,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RoundEdgedButton(
                        text: translate("createPassword.title"),
                        textColor: Colors.white,
                        color: MyColors.primaryColor,
                        borderRadius: 12,
                        width: MediaQuery.of(context).size.width - 32,
                        fontSize: 16,
                        horizontalMargin: 16,
                        fontfamily: 'medium',
                        onTap: () async {
                          if (passwordController.text ==
                              confirmpasswordController.text &&
                              passwordController.text.length > 7) {
                            if (
                            // strength == passwordStrength[2] ||
                            strength == passwordStrength[3]) {
                              if (isChecked && isThirteen) {
                                String passPhrase = '';
                                for (int i = 0;
                                i < widget.passPhrase.length;
                                i++) {
                                  passPhrase =
                                      passPhrase + widget.passPhrase[i];
                                  if (i != widget.passPhrase.length - 1) {
                                    passPhrase = passPhrase + " ";
                                  }
                                }
                                print('the passphrase is $passPhrase');
                                String typedPhrase = uuid.v5(
                                    Uuid.NAMESPACE_URL, passPhrase);
                                Crypt hashedPass = Crypt.sha256(
                                    passwordController.text,
                                    salt: MyGlobalConstants.passwordSalt);
                                print('hello $typedPhrase');
                                print(hashedPass.hash);
                                setState(() {
                                  load = true;
                                });
                                bool success =
                                await Webservices.createAccount(
                                    uuid: typedPhrase,
                                    password: hashedPass.hash,
                                    context: context);
                                if (success) {
                                  Navigator.popUntil(context, (route) => route.isFirst);
                                  await Navigator.pushReplacementNamed(
                                      context, CongratulationsPage.id);
                                }
                              } else {
                                if(!isThirteen){
                                  showSnackbar(
                                      context, translate("createPassword.alert2"));
                                }else{
                                  showSnackbar(
                                      context, translate("createPassword.alertMsgTerms"));
                                }

                              }
                            } else {
                              showSnackbar(context,
                                  translate("createPassword.alertStrongPassword"));
                            }
                          } else {
                            if (passwordController.text.length > 7)
                              showSnackbar(context,
                                  translate("create_new_password.confirmPass"));
                            else {
                              showSnackbar(context,
                                  translate("createPassword.alert"));
                            }
                          }
                          setState(() {
                            load = false;
                          });
                          // Navigator.pushNamed(context, CongratulationsPage.id);
                        },
                      ),
                      vSizedBox2,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
