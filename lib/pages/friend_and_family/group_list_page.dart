import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_keys.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/pages/friend_and_family/GroupPage.dart';
import 'package:ox21/pages/friend_and_family/create_group_page.dart';
import 'package:ox21/pages/friend_and_family/scan_qr_to_join_group_page.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_circular_image.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../constants/colors.dart';

class FriendsAndFamilyGroupListPage extends StatefulWidget {
  const FriendsAndFamilyGroupListPage({Key? key}) : super(key: key);

  @override
  State<FriendsAndFamilyGroupListPage> createState() =>
      _FriendsAndFamilyGroupListPageState();
}

class _FriendsAndFamilyGroupListPageState
    extends State<FriendsAndFamilyGroupListPage> {
  List groupList = [];
  bool load = false;

  getGroupList() async {
    setState(() {
      load = true;
    });
    groupList = await Webservices.getList(
        ApiUrls.myGroups + '?user_id=${userId}&type=all');
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getGroupList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Friends And Family'),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                // height: 160 + MediaQuery.of(context).viewInsets.bottom,
                // margin: viewInset,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                    color: MyColors.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    vSizedBox,
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        Navigator.pop(context);
                        bool? result = await push(
                            context: MyGlobalKeys.navigatorKey.currentContext!,
                            screen: CreateGroupPage());
                        if (result == true) {
                          getGroupList();
                        }
                      },
                      child: MainHeadingText(text: "Create Group"),
                    ),
                    CustomDivider(),
                    vSizedBox,
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        // Navigator.pop(context);
                        // Br? result = Br(
                        //     '1c305724-e81b-50ed-8d39-161170364196cadb0f9a-d2fa-5186-9c91-46f08d441e27');
                        Barcode? result = await push(
                            context: MyGlobalKeys.navigatorKey.currentContext!,
                            screen: ScanQrToJoinGroupPage());
                        if (result != null) {
                          print('hello workddd');
                          print(result.code);

                          var request = {
                            'user_id': userId,
                            'groupID': result.code,
                          };
                          var jsonResponse = await Webservices.postData(
                              url: ApiUrls.checkgroup,
                              request: request,
                              context: context,
                              isGetMethod: true);
                          if (jsonResponse['status'] == 1) {
                            TextEditingController nicknameController =
                                TextEditingController();
                            await showModalBottomSheet(
                              context:
                                  MyGlobalKeys.navigatorKey.currentContext!,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  bool dialogLoad = false;
                                  return Container(
                                    height: 300 +
                                        MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                    // margin: viewInset,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                        color: MyColors.whiteColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40),
                                        )),
                                    child: Scaffold(
                                      body: dialogLoad
                                          ? CustomLoader()
                                          : Column(
                                              children: [
                                                vSizedBox,
                                                MainHeadingText(
                                                    text:
                                                        "Join ${jsonResponse['data']['title']}"),
                                                CustomDivider(),
                                                vSizedBox,
                                                SubHeadingText(
                                                    text: 'Nick Name'),
                                                vSizedBox,
                                                CustomTextField(
                                                    controller:
                                                        nicknameController,
                                                    hintText:
                                                        'This will be displayed as your name in this group'),
                                                vSizedBox,
                                                RoundEdgedButton(
                                                  text: 'Join Group',
                                                  onTap: () async {
                                                    var request = {
                                                      'user_id': userId,
                                                      'groupID': result.code,
                                                      "nickname":
                                                          nicknameController
                                                              .text
                                                    };
                                                    setState(() {
                                                      dialogLoad = true;
                                                    });
                                                    var joinGroupJsonResponse =
                                                        await Webservices
                                                            .postData(
                                                                url: ApiUrls
                                                                    .join_group,
                                                                request:
                                                                    request,
                                                                context:
                                                                    context,
                                                                isGetMethod:
                                                                    true);
                                                    setState(() {
                                                      dialogLoad = false;
                                                    });
                                                    if (joinGroupJsonResponse[
                                                            'status'] ==
                                                        1) {
                                                      showSnackbar(
                                                          MyGlobalKeys
                                                              .navigatorKey
                                                              .currentContext!,
                                                          joinGroupJsonResponse[
                                                              'message']);
                                                    }
                                                    Navigator.pop(MyGlobalKeys
                                                        .navigatorKey
                                                        .currentContext!);
                                                    // Navigator.pop(MyGlobalKeys.navigatorKey.currentContext!);
                                                  },
                                                )
                                              ],
                                            ),
                                    ),
                                  );
                                });
                              },
                            );
                            // showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, jsonResponse['message']);
                          }
                          // print('${result.format.formatName}');
                          // print('${result.format.name}');
                          // getGroupList();
                          Navigator.pop(context);
                        }
                      },
                      child: MainHeadingText(text: "Join Group"),
                    ),
                    vSizedBox,
                  ],
                ),
              );
            },
          );

          // bool? result = await push(context: context, screen: CreateGroupPage());
          // if(result==true){
          //   getGroupList();
          // }
        },
        backgroundColor: MyColors.secondary,
        child: const Icon(Icons.add),
      ),
      body: load
          ? CustomLoader()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: groupList.length == 0
                  ? Center(
                      child: ParagraphText(
                        text: 'No Groups Found',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: groupList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            await push(
                                context: context,
                                screen:
                                    GroupPage(groupDetail: groupList[index]));
                            getGroupList();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                                // color:
                                ),
                            child: Row(
                              children: [
                                CustomCircularImage(
                                    imageUrl: groupList[index]['image'] ?? ''),
                                hSizedBox,
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SubHeadingText(
                                        text: groupList[index]['title']),
                                  ],
                                ))
                              ],
                            ),
                            // child: ParagraphText(text: groupList[index].toString(),),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}

class Br {
  String code;
  Br(this.code);
}
