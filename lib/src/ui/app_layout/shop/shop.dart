
import 'package:engagementwallet/src/logic/future_helper/future_helper.dart';
import 'package:engagementwallet/src/logic/mixin/cart_mixin/cart_mixin.dart';
import 'package:engagementwallet/src/logic/models/mock_data.dart';
import 'package:engagementwallet/src/logic/models/product_model/product_model.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/add_to_cart.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/order_history.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/search_cart.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/shop_description.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/shop_items.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/functions.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  ///1. Initiliaze
  Future<List<ProductModel>>? futureProducts;

  //2. Call Api here
  Future<List<ProductModel>>? futureTask() async {
    //Initialize provider
    CartMixin cart = CartMixin.cartProvider(context);

    final result = await cart.getProducts(context);

    print('result: $result');

    setState(() {});
    //
    //Return future value
    return Future.value(result);
  }

  ///3. Set Future users to the task
  @override
  void initState() {
    futureProducts = futureTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartMixin cart = CartMixin.cartProvider(context);

    return FutureHelper(
      task: futureProducts!,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SHOP', style: textStyle600Small.copyWith(fontSize: 18)),
                  kVerySmallHeight,
                  InkWell(
                    onTap: () => openDialog(context, const OrderHistory()),
                    child: Text(
                      'View order history',
                      style: textStyleSecondary,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () => openDialog(context, const SearchCart()),
                  child: const Icon(Icons.search_outlined ))
              // cart.cartList.isEmpty
              //     ? SvgPicture.asset(Assets.cart)
              //     : InkWell(
              //         onTap: () => navigate(context, const AddToCart()),
              //         child: SvgPicture.asset(Assets.inCart))
            ],
          ),
          kNormalHeight,
          Consumer<CartMixin>(
           builder: (BuildContext context, cart, Widget? child) {
             return SizedBox(
               height: cart.products.length <= 3 ? 470 : 700,
               child: GridView.builder(
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       mainAxisExtent: 199,
                       crossAxisCount: 2,
                       crossAxisSpacing: 12,
                       mainAxisSpacing: 20),
                   itemCount: 6,
                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   itemBuilder: (context, index) {
                     int amount = cart.products[index].unitPrice!;
                     String? title = cart.products[index].name;
                     String? description =  cart.products[index].description;
                     List<String> image =  cart.products[index].images!;
                     String id = cart.products[index].id.toString();
                     String? thumbNail = cart.products[index].coverImage;
                     return ShopItems(
                       onTap: () => navigate(
                           context,
                           ShopDescription(
                             id: id,
                             amount: amount,
                             title: title,
                             description: description,
                             image: image,
                             thumbNail: thumbNail,
                           )),
                       amount: amount,
                       description: title,
                       image: thumbNail!,
                     );
                   }),
             );
           }

          ),
        ],
      ),
    );
  }
}
