import 'package:engagementwallet/src/logic/future_helper/future_helper.dart';
import 'package:engagementwallet/src/logic/mixin/friends_mixin/friends_mixin.dart';
import 'package:engagementwallet/src/ui/app_layout/more/friends/add_friend.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/functions.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../logic/models/friends_model/friend_list_model.dart';

class ShowFriends extends StatefulWidget {
  const ShowFriends({Key? key}) : super(key: key);

  @override
  State<ShowFriends> createState() => _ShowFriendsState();
}

class _ShowFriendsState extends State<ShowFriends> {
  @override
  Future<List<FriendsList>>? futureFriend;

  //2. Call Api here
  Future<List<FriendsList>>? futureTask() async {
    //Initialize provider
    FriendsMixin friend = FriendsMixin.friendProvider(context);

    final result = await friend.getFriendList(context);

    setState(() {});
    //
    //Return future value
    return Future.value(result);
  }

  ///3. Set Future users to the task
  @override
  void initState() {
    futureFriend = futureTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FriendsMixin friends = FriendsMixin.friendProvider(context, listen: true);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
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
                  Text('My Friends',
                      style: textStyleBig.copyWith(fontSize: 26)),
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
          ],
        ),
        Padding(
          padding: defaultHPadding,
          child: FutureHelper(
            task: futureFriend!,
            loader: Center(
              child: circularProgressIndicator(),
            ),
            noData: const Center(
              child: Text('No Friend Request'),
            ),
            builder: (context, _) => ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  SpaceDivider(
                height: 20,
              ),
              shrinkWrap: true,
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
                              '${friend.firstName} ${friend.lastName}',
                              style: textStyle400Small,
                            ),
                            Text(
                              '@${friend.firstName!}',
                              style: textStyle14Small.copyWith(
                                  color: darkGreyColor),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                            onTap: () async =>
                                await friends.acceptFriendRequest(
                                    friend.userId!, true, context),
                            child: const Icon(
                              Icons.check,
                              color: Colors.green,
                            )),
                        kSmallWidth,
                        InkWell(
                            onTap: () async =>
                                await friends.acceptFriendRequest(
                                    friend.userId!, false, context),
                            child: const Icon(
                              Icons.close,
                              color: Colors.red,
                            )),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
        Padding(
          padding: defaultVHPadding.copyWith(bottom: 30),
          child: CustomButton(
            text: "ADD A NEW FRIEND",
            onPressed: () => openDialog(context, const AddFriend()),
          ),
        ),
      ],
    );
  }
}
