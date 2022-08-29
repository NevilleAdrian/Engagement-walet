import 'package:engagementwallet/src/logic/future_helper/future_helper.dart';
import 'package:engagementwallet/src/logic/mixin/cart_mixin/cart_mixin.dart';
import 'package:engagementwallet/src/logic/models/mock_data.dart';
import 'package:engagementwallet/src/logic/models/order_history_model/order_history_model.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/functions.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  ///1. Initiliaze
  Future<List<OrderHistoryModel>>? futureOrders;

  //2. Call Api here
  Future<List<OrderHistoryModel>>? futureTask() async {
    //Initialize provider
    CartMixin cart = CartMixin.cartProvider(context);

    final result = await cart.getOrderHistory(context);

    setState(() {});
    //
    //Return future value
    return Future.value(result);
  }

  ///3. Set Future users to the task
  @override
  void initState() {
    futureOrders = futureTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureHelper(
      task: futureOrders!,
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
      builder: (context, _) => Column(
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
                Text('My Order History',
                    style: textStyleBig.copyWith(fontSize: 22)),
                SvgPicture.asset(Assets.search)
              ],
            ),
          ),
          SpaceDivider(
            height: 30,
          ),
          Consumer<CartMixin>(
            builder: (BuildContext context, cart, Widget? child) {
              return Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) => SpaceDivider(
                      height: 50,
                    ),
                    itemCount: cart.orderHistory.length,
                    itemBuilder: (context, index) {
                      final items = cart.orderHistory[index];
                      return Padding(
                        padding: defaultHPadding,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(
                                      formatDate(items.deliveryDate.toString()),
                                      style: textStyle600Small,
                                    )),
                                kSmallWidth,
                                Text(toBeginningOfSentenceCase(items.orderStatus)!,
                                    style: textStyle600Small.copyWith(
                                        color: colorType(items.orderStatus!))),
                              ],
                            ),
                            kSmallHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Women Tops Solid Color', style: textStyle400Small),
                                Text('N ${'500'}',
                                    style: textStyle400Small),
                              ],
                            ),
                            kSmallHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('X2',
                                    style: textStyle400Small),
                              ],
                            ),
                            // kSmallHeight,
                            // Center(
                            //   child: Text(toBeginningOfSentenceCase(items['status'] == 'delivered' ? 'Reorder': 'Cancel')!,
                            //       style: textStyle600Small.copyWith(
                            //           color: colorType(items['status']))),
                            // )

                          ],
                        ),
                      );
                    }),
              );
            },
          )
        ],
      ),
    );
  }
}
