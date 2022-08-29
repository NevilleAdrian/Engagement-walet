import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:engagementwallet/src/logic/mixin/friends_mixin/friends_mixin.dart';
import 'package:engagementwallet/src/ui/app_layout/more/friends/add_friend.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowFriends extends StatefulWidget {
  const ShowFriends({Key? key}) : super(key: key);

  @override
  State<ShowFriends> createState() => _ShowFriendsState();
}

class _ShowFriendsState extends State<ShowFriends> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FriendsMixin friends = FriendsMixin.friendProvider(context, listen: true);

    return Column(
      children: [
        Padding(
          padding: defaultVHPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => popView(context),
                child: Icon(
                  Icons.cancel,
                  color: greyColor,
                ),
              ),
              Text('My Friends', style: textStyleBig.copyWith(fontSize: 26)),
              Icon(
                Icons.cancel,
                color: whiteColor,
              )
            ],
          ),
        ),
        Divider(
          thickness: 0.8,
          height: 15,
          color: greyColor,
        ),
        Padding(
          padding: defaultHPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ConstrainedBox(
              //   constraints: const BoxConstraints(maxWidth: 100),
              //   child: const Text(
              //     'Enter the 6-digit PIN sent via SMS to your number +234 906 1234 567.',
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              kNormalHeight,
              SizedBox(
                height: 500.h,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      SpaceDivider(
                    height: 40,
                  ),
                  itemCount: friends.friendsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final friend = friends.friendsList[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              child: Image.asset(Assets.friendPic),
                              radius: 27,
                              backgroundColor: secondaryColor,
                            ),
                            kSmallWidth,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  friend['name']!,
                                  style: textStyle400Small,
                                ),
                                Text(
                                  '@${friend['userName']!}',
                                  style: textStyle14Small.copyWith(
                                      color: darkGreyColor),
                                ),
                              ],
                            )
                          ],
                        ),
                        InkWell(
                            onTap: () =>
                                friends.removeItemFromList(friend['id']),
                            child: const Icon(
                              Icons.close,
                              color: Colors.red,
                            ))
                      ],
                    );
                  },
                ),
              ),
              kNormalHeight,
              CustomButton(
                text: "ADD A NEW FRIEND",
                onPressed: () => openDialog(context, const AddFriend()),
              ),
            ],
          ),
        )
      ],
    );
  }
}
