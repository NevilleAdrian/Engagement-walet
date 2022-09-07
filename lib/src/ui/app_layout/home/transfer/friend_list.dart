import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:engagementwallet/src/logic/future_helper/future_helper.dart';
import 'package:engagementwallet/src/logic/mixin/friends_mixin/friends_mixin.dart';
import 'package:engagementwallet/src/logic/models/friends_model/friend_list_model.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/functions.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendList extends StatefulWidget {
  const FriendList({Key? key}) : super(key: key);

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  bool? checkedValue = false;

  CustomGroupController controller = CustomGroupController(
    isMultipleSelection: true,
    // initSelectedItem:
  );

  Future<List<FriendsList>>? futureFriend;

  //2. Call Api here
  Future<List<FriendsList>>? futureTask() async {
    //Initialize provider
    FriendsMixin friend = FriendsMixin.friendProvider(context);

    final result = await friend.getFriendList(context);

    print('resultt: $result');

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
    FriendsMixin friends = FriendsMixin.friendProvider(context);

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
        FutureHelper(
          task: futureFriend!,
          loader: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [circularProgressIndicator()],
          ),
          noData: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('No data available')],
          ),
          builder: (context, _) => SingleChildScrollView(
            child: Padding(
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
                  // kNormalHeight,
                  SizedBox(
                      height: 500.h,
                      child: CustomGroupedCheckbox<FriendsList>(
                        controller: controller,
                        isScroll: true,
                        itemBuilder: (ctx, index, selected, isDisabled) {
                          String? name =
                              '${friends.friendsList[index].firstName} ${friends.friendsList[index].lastName}';
                          String? userName =
                              friends.friendsList[index].firstName;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                activeColor: secondaryColor,
                                title: Row(
                                  children: [
                                    CircleAvatar(
                                      child: Image.asset(Assets.friendPic),
                                      radius: 27,
                                      backgroundColor: secondaryColor,
                                    ),
                                    kSmallWidth,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: textStyle400Small,
                                        ),
                                        Text(
                                          '@${userName!}',
                                          style: textStyle14Small.copyWith(
                                              color: darkGreyColor),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                value: selected,
                                onChanged: (bool? newValue) {
                                  print('newValue');
                                }),
                          );
                        },
                        values: friends.friendsList,
                      )),
                  kNormalHeight,
                  CustomButton(
                    text: "DONE",
                    onPressed: () => popView(context),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
