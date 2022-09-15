import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_functions.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/pages/btc_send_page.dart';
import 'package:ox21/pages/deposit_btc_page.dart';
import 'package:ox21/pages/deposit_btc_qr_page.dart';
import 'package:ox21/pages/my_purchased_banners.dart';
import 'package:ox21/pages/search_domain_page.dart';
import 'package:ox21/pages/top_banner_bid_page.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/top_banner_purchase_bid_language.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/avatar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/customtextfield.dart';

import 'constants/colors.dart';
import 'constants/image_urls.dart';

class WalletPage extends StatefulWidget {
  static const String id = "wallet";
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  TextEditingController searchDomainController = TextEditingController();
  TextEditingController searchChannelController = TextEditingController();
  TextEditingController bannerTradeController = TextEditingController();


  bool load = false;
  bool isDomainValid = false;
  String domainErrorMessage = '';
  bool domainSearchLoad = false;
  Map<String, dynamic>? domainData;

  String btcConversionPrice = '0';
  getPrice() async{
    setState(() {
      load = true;
    });
    await updateSharedPreferenceFromServer();
    btcConversionPrice = await Webservices.getLiveConversionRateBTCToUSD();

    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    getPrice();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      appBar: appBar(
        context: context,
        title: 'Investment',
        fontfamily: 'bold',
        implyLeading: false,
        titleColor: MyColors.primaryColor,
      ),
      body:load?CustomLoader(): Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                    color: MyColors.whiteColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubHeadingText(text: 'Wallet Balance'),
                        SubHeadingText(text: '${double.parse(userData!['btc_wallet'].toString()).toStringAsFixed(2)} BTC', color: MyColors.primaryColor,),
                      ],
                    )
                  ],
                ),
              ),
              CustomDivider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [

                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Image.asset(
                            MyImages.jinLogo,
                            fit: BoxFit.fitHeight,
                            height: 40,
                          ),
                        ),
                        hSizedBox,
                        Expanded(
                            flex: 12,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SubHeadingText(text: 'JIN'),
                                vSizedBox05,
                                ParagraphText(text: '${double.parse(userData!['jin_wallet'].toString()).toStringAsFixed(0)} JIN', color: MyColors.black54Color,),
                              ],
                            )
                        ),
                        Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SubHeadingText(text: '1.00 BTC'),
                                vSizedBox05,
                                ParagraphText(text: '≈${(double.parse(btcConversionPrice)/6).toStringAsFixed(2)} JIN', color: MyColors.black54Color,),
                              ],
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CustomDivider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Image.asset(
                            MyImages.logo_hori,
                            fit: BoxFit.fill,
                            height: 40,
                            width: 40,
                          ),
                        ),
                        hSizedBox,
                        Expanded(
                          flex: 12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SubHeadingText(text: 'Points'),
                              vSizedBox05,
                              ParagraphText(text: '${userData!['points']}', color: MyColors.black54Color,),
                            ],
                          )
                        ),
                        Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SubHeadingText(text: '1.00 USD'),
                                vSizedBox05,
                                ParagraphText(text: '≈3600/15 Points', color: MyColors.black54Color,),
                              ],
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if(serverStatus==1)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDivider(),
                    SubHeadingText(text: 'Deposit BTC'),
                    vSizedBox2,
                    ParagraphText(text: '11PEEokWFSFNYshLfuLvZfMuPE93aMJd4'),
                    vSizedBox2,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Expanded(
                            child: Column(
                              children: [
                                RoundEdgedButton(
                                  text: 'Deposit BTC',
                                  color: MyColors.secondary,
                                  textColor: Colors.white,
                                  fontSize: 11,
                                  borderRadius: 8,
                                  height: 40,
                                  fontfamily: 'medium',
                                  width: 150,
                                  onTap: ()async{
                                    setState(() {
                                      load  = true;
                                    });
                                    List data = await Webservices.getList(ApiUrls.checkPendingDepositOrders + userId);
                                    if(data.length==0){
                                      await push(context: context, screen: DepositBtcPage());
                                    }else{
                                      await push(context: context, screen: DepositBTCQRPage(purchaseData: data[0]));
                                    }
                                    setState(() {
                                      load = false;
                                    });
                                  },
                        ),
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              ),
              
              if(serverStatus==1)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDivider(),
                    SubHeadingText(text: 'Domain Trade'),
                    vSizedBox,
                    CustomTextFieldlabel(
                      controller: searchDomainController,
                      hintText: 'Search Domain',
                      labeltext: 'Search Domain',
                      icon: Icons.search,
                      suffixIconButton:!domainSearchLoad?
                      null
                          : IconButton(
                        onPressed: (){},
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomLoader(),
                        ),
                      ),
                      onChanged: (val)async{

                        print(val);
                        setState(() {
                          domainSearchLoad = true;
                        });
                        var response =  await Webservices.getData(ApiUrls.checkDomain + 'domain=$val&user_id=$userId');
                        print('step 1');
                        print(' I am here with Stcode ${response.statusCode}');
                        if(response.statusCode==200){

                          var jsonResponse = jsonDecode(response.body);

                          print('the jsonResponse is $jsonResponse');
                          if(jsonResponse['status']==1){
                            domainErrorMessage = 'This domain is available for Exchange';
                            isDomainValid = true;
                            domainData = jsonResponse['data'];
                            // domainErrorMessage = jsonResponse['message'];
                          }
                          else{
                            print('imhere');
                            domainErrorMessage = jsonResponse['message'];
                            isDomainValid = false;
                            domainData = null;
                          }
                          print(jsonResponse);
                          print('hellooo world');
                        }else if(response.statusCode==500){
                          try{
                            var jsonResponse = jsonDecode(response.body);
                            domainErrorMessage = jsonResponse['message'];
                            isDomainValid = false;
                            domainData = null;
                          }catch(e){
                            print('Error in catch block 453 $e');
                            domainErrorMessage = 'Something went wrong.';
                          }

                        }else{
                          domainErrorMessage = 'Something went wrong.';
                        }
                        setState(() {
                          domainSearchLoad = false;
                        });
                      },
                    ),
                    // vSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ParagraphText(text: domainErrorMessage, color: isDomainValid?MyColors.green:MyColors.redColor,),
                      ],
                    ),
                    vSizedBox,
                    Row(
                      children: [
                        Expanded(
                            child: RoundEdgedButton(text:!(isDomainValid && domainData!=null)? 'Exchange Domain':'Exchange Domain with ${domainData!['jinCost']} JIN',
                             color:!(isDomainValid && domainData!=null)?MyColors.grey.withOpacity(0.2): MyColors.secondary,
                              textColor: Colors.white,
                              fontSize: 12,
                              fontfamily: 'medium',
                              borderRadius: 8,
                              height: 40,
                              onTap:!(isDomainValid && domainData!=null)?null: ()async{
                              // Navigator.pushNamed(context, SearchDomainPage.id);
                                FocusScope.of(context).requestFocus(new FocusNode());
                              await push(context: context, screen: SearchDomainPage(domainData: domainData!,));
                              searchDomainController.clear();
                              },
                              // verticalPadding: 4,
                            )
                        ),
                      ],
                    )
                  ],
                ),
              ),
              CustomDivider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubHeadingText(text: 'Top Banner Trade'),
                    // vSizedBox,
                    // CustomTextFieldlabel(controller: bannerTradeController, hintText: 'Search Channel', labeltext: 'Search Channel', icon: Icons.search,),
                    vSizedBox,
                    Row(
                      children: [
                        Expanded(
                            child: RoundEdgedButton(
                              text: 'Exchange Top Banner with BTC',
                              color: MyColors.secondary,
                              textColor: Colors.white,
                              fontSize: 12,
                              verticalPadding: 4,
                              borderRadius: 8,
                              height: 40,
                              fontfamily: 'medium',
                              onTap: (){
                         push(context: context, screen: MyPurchasedBanners());
                        },)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:ox21/constants/dummy_data.dart';
// import 'package:ox21/constants/global_constants.dart';
// import 'package:ox21/constants/sized_box.dart';
// import 'package:ox21/functions/navigation_functions.dart';
// import 'package:ox21/pages/btc_send_page.dart';
// import 'package:ox21/pages/search_domain_page.dart';
// import 'package:ox21/pages/top_banner_bid_page.dart';
// import 'package:ox21/services/api_urls.dart';
// import 'package:ox21/services/webservices.dart';
// import 'package:ox21/top_banner_purchase_bid_language.dart';
// import 'package:ox21/widgets/CustomTexts.dart';
// import 'package:ox21/widgets/appbar.dart';
// import 'package:ox21/widgets/avatar.dart';
// import 'package:ox21/widgets/buttons.dart';
// import 'package:ox21/widgets/customLoader.dart';
// import 'package:ox21/widgets/customtextfield.dart';

// import 'constants/colors.dart';
// import 'constants/image_urls.dart';

// class WalletPage extends StatefulWidget {
//   static const String id = "wallet";
//   const WalletPage({Key? key}) : super(key: key);

//   @override
//   State<WalletPage> createState() => _WalletPageState();
// }

// class _WalletPageState extends State<WalletPage> {
//   TextEditingController searchDomainController = TextEditingController();
//   TextEditingController searchChannelController = TextEditingController();

//   bool isDomainValid = false;
//   String domainErrorMessage = '';
//   bool domainSearchLoad = false;
//   Map<String, dynamic>? domainData;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MyColors.backcolor,
//       appBar: appBar(
//         context: context,
//         title: 'Investment',
//         fontfamily: 'bold',
//         implyLeading: false,
//         titleColor: MyColors.primaryColor,
//       ),
//       body: Container(
//         margin: EdgeInsets.symmetric(horizontal: 16),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                 decoration: BoxDecoration(
//                     color: MyColors.whiteColor,
//                     borderRadius: BorderRadius.circular(16)),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           // flex: 12,
//                           child: Container(
//                             padding:
//                                 EdgeInsets.symmetric(vertical: 2, horizontal: 0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     ParagraphText(
//                                       text: 'Total Assets',
//                                       color: MyColors.heading,
//                                       fontSize: 12,
//                                       fontFamily: 'bold',
//                                     ),
//                                     ParagraphText(
//                                       text: 'Wallet Balance',
//                                       color: MyColors.bulletcolor,
//                                       fontSize: 12,
//                                       fontFamily: 'bold',
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         ParagraphText(
//                                           text: '\$0.00',
//                                           color: MyColors.secondary,
//                                           fontSize: 18,
//                                           fontFamily: 'bold',
//                                         ),
//                                         Image.asset(
//                                           MyImages.graph,
//                                           width: 12,
//                                         )
//                                       ],
//                                     ),
//                                     ParagraphText(
//                                       text: '\$0.00',
//                                       color: MyColors.secondary,
//                                       fontSize: 14,
//                                       fontFamily: 'bold',
//                                     ),
//                                   ],
//                                 ),
//                                 vSizedBox2,
//                                 Image.asset(
//                                   MyImages.line,
//                                   width: MediaQuery.of(context).size.width,
//                                 ),
//                                 vSizedBox2,
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: RoundEdgedButton(
//                                         text: 'Send',
//                                         textColor: Colors.white,
//                                         color: MyColors.primaryColor,
//                                         borderRadius: 12,
//                                         width: MediaQuery.of(context).size.width,
//                                         fontSize: 12,
//                                         verticalPadding: 20,
//                                         horizontalMargin: 0,
//                                         height: 40,
//                                         fontfamily: 'medium',
//                                         onTap: () {

//                                           Navigator.pushNamed(context, BTCSendPage.id);
//                                         },
//                                       ),
//                                     ),
//                                     hSizedBox,
//                                     Expanded(
//                                       child: RoundEdgedButton(
//                                         text: 'Receive',
//                                         textColor: MyColors.blackColor,
//                                         color: Color(0xFFEEEEEE),
//                                         borderRadius: 12,
//                                         height: 40,
//                                         width: MediaQuery.of(context).size.width,
//                                         fontSize: 12,
//                                         verticalPadding: 20,
//                                         horizontalMargin: 0,
//                                         fontfamily: 'medium',
//                                         onTap: () {
//                                           // Navigator.pushNamed(context, MyStatefulWidget.id);
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               vSizedBox2,
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                 decoration: BoxDecoration(
//                     color: Colors.white, borderRadius: BorderRadius.circular(16)),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Image.asset(
//                             MyImages.bitcoinLogo,
//                             fit: BoxFit.fitHeight,
//                             height: 40,
//                           ),
//                         ),
//                         hSizedBox,
//                         Expanded(
//                           flex: 12,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SubHeadingText(text: 'BTC'),
//                               vSizedBox05,
//                               ParagraphText(text: '\$6263.77', color: MyColors.black54Color,),
//                             ],
//                           )
//                         ),
//                         Expanded(
//                             flex: 3,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SubHeadingText(text: '0.00'),
//                                 vSizedBox05,
//                                 ParagraphText(text: '≈\$0.00', color: MyColors.black54Color,),
//                               ],
//                             )
//                         ),
//                       ],
//                     ),
//                     CustomDivider(),
//                     Row(
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Image.asset(
//                             MyImages.jinLogo,
//                             fit: BoxFit.fitHeight,
//                             height: 40,
//                           ),
//                         ),
//                         hSizedBox,
//                         Expanded(
//                             flex: 12,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SubHeadingText(text: 'JIN'),
//                                 vSizedBox05,
//                                 ParagraphText(text: '\$6263.77', color: MyColors.black54Color,),
//                               ],
//                             )
//                         ),
//                         Expanded(
//                             flex: 3,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SubHeadingText(text: '0.00'),
//                                 vSizedBox05,
//                                 ParagraphText(text: '≈\$0.00', color: MyColors.black54Color,),
//                               ],
//                             )
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               vSizedBox2,
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                 decoration: BoxDecoration(
//                     color: Colors.white, borderRadius: BorderRadius.circular(16)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SubHeadingText(text: 'Deposit BTC'),
//                     vSizedBox2,
//                     ParagraphText(text: '123sasadsadsdsad'),
//                     vSizedBox2,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [

//                         Expanded(
//                             child: Column(
//                               children: [
//                                 RoundEdgedButton(
//                                   text: 'Deposit BTC',
//                                   color: MyColors.secondary,
//                                   textColor: Colors.white,
//                                   fontSize: 11,
//                                   borderRadius: 8,
//                                   height: 40,
//                                   fontfamily: 'medium',
//                                   width: 150,
//                                   onTap: (){
//                                     Navigator.pushNamed(context, BTCSendPage.id);
//                                   },
//                         ),
//                               ],
//                             )),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               vSizedBox2,
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                 decoration: BoxDecoration(
//                     color: Colors.white, borderRadius: BorderRadius.circular(16)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SubHeadingText(text: 'Domain Trade'),
//                     vSizedBox,
//                     CustomTextFieldlabel(
//                       controller: searchDomainController,
//                       hintText: 'Search Domain',
//                       labeltext: 'Search Domain',
//                       icon: Icons.search,
//                       suffixIconButton:!domainSearchLoad?
//                       null
//                       // IconButton(
//                       //   onPressed: (){},
//                       //   icon: Padding(
//                       //     padding: const EdgeInsets.all(8.0),
//                       //     child: Icon(isDomainValid?Icons.check:Icons.close, color: isDomainValid?MyColors.green:Colors.red,),
//                       //   ),
//                       // )
//                           : IconButton(
//                         onPressed: (){},
//                         icon: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: CustomLoader(),
//                         ),
//                       ),
//                       onChanged: (val)async{

//                         print(val);
//                         setState(() {
//                           domainSearchLoad = true;
//                         });
//                         // var response = Response(jsonEncode(dummyCheckDomainResponse),
//                         // 200);
//                         var response =  await Webservices.getData(ApiUrls.checkDomain + 'domain=$val&user_id=$userId');
//                         print('step 1');
//                         print(' I am here with Stcode ${response.statusCode}');
//                         if(response.statusCode==200){

//                           var jsonResponse = jsonDecode(response.body);

//                           print('the jsonResponse is $jsonResponse');
//                           if(jsonResponse['status']==1){
//                             domainErrorMessage = 'This domain is available for Exchange';
//                             isDomainValid = true;
//                             domainData = jsonResponse['data'];
//                             // domainErrorMessage = jsonResponse['message'];
//                           }
//                           else{
//                             print('imhere');
//                             domainErrorMessage = jsonResponse['message'];
//                             isDomainValid = false;
//                             domainData = null;
//                           }
//                           print(jsonResponse);
//                           print('hellooo world');
//                         }else if(response.statusCode==500){
//                           try{
//                             var jsonResponse = jsonDecode(response.body);
//                             domainErrorMessage = jsonResponse['message'];
//                             isDomainValid = false;
//                             domainData = null;
//                           }catch(e){
//                             print('Error in catch block 453 $e');
//                             domainErrorMessage = 'Something went wrong.';
//                           }

//                         }
//                         setState(() {
//                           domainSearchLoad = false;
//                         });
//                       },
//                     ),
//                     // vSizedBox,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         ParagraphText(text: domainErrorMessage, color: isDomainValid?MyColors.green:MyColors.redColor,),
//                       ],
//                     ),
//                     vSizedBox,
//                     Row(
//                       children: [
//                         Expanded(
//                             child: RoundEdgedButton(text:!(isDomainValid && domainData!=null)? 'Exchange Domain':'Exchange Domain with ${domainData!['jinCost']} JIN',
//                              color:!(isDomainValid && domainData!=null)?MyColors.grey.withOpacity(0.2): MyColors.secondary,
//                               textColor: Colors.white,
//                               fontSize: 12,
//                               fontfamily: 'medium',
//                               borderRadius: 8,
//                               height: 40,
//                               onTap:!(isDomainValid && domainData!=null)?null: ()async{
//                               // Navigator.pushNamed(context, SearchDomainPage.id);
//                                 FocusScope.of(context).requestFocus(new FocusNode());
//                               await push(context: context, screen: SearchDomainPage(domainData: domainData!,));
//                               searchDomainController.clear();
//                               },
//                               // verticalPadding: 4,
//                             )
//                         ),
//                         // hSizedBox,
//                         // Expanded(child: RoundEdgedButton(text: 'Exchange Domain with BTC',
//                         //   color: MyColors.secondary,
//                         //   textColor: Colors.white,
//                         //   fontSize: 11,
//                         //   borderRadius: 8,
//                         //   height: 40,
//                         //   fontfamily: 'medium',
//                         // )),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               vSizedBox2,
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                 decoration: BoxDecoration(
//                     color: Colors.white, borderRadius: BorderRadius.circular(16)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SubHeadingText(text: 'Top Banner Trade'),
//                     vSizedBox,
//                     CustomTextFieldlabel(controller: searchDomainController, hintText: 'Search Channel', labeltext: 'Search Channel', icon: Icons.search,),
//                     vSizedBox,
//                     Row(
//                       children: [
//                         Expanded(child: RoundEdgedButton(
//                           text: 'Trade Top Banner',
//                           color: MyColors.secondary,
//                           textColor: Colors.white,
//                           fontSize: 12,borderRadius: 8,
//                           height: 40,
//                           fontfamily: 'medium',
//                           onTap: (){
//                             Navigator.pushNamed(context, TopBannerLanguagePage.id);
//                           },
//                         )
//                         ),
//                         hSizedBox,
//                         Expanded(
//                             child: RoundEdgedButton(
//                               text: 'Trade Top Banner\nwith BTC',
//                               color: MyColors.secondary,
//                               textColor: Colors.white,
//                               fontSize: 12,
//                               verticalPadding: 4,
//                               borderRadius: 8,
//                               height: 40,
//                               fontfamily: 'medium',
//                               onTap: (){
//                           Navigator.pushNamed(context, TopBannerBidPage.id);
//                         },)),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
