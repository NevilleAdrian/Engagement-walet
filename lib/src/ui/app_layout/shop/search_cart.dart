
import 'package:engagementwallet/src/logic/bloc/auth_bloc/form_validator_bloc/form_validator_bloc.dart';
import 'package:engagementwallet/src/logic/bloc/auth_bloc/validation_bloc.dart';
import 'package:engagementwallet/src/logic/future_helper/future_helper.dart';
import 'package:engagementwallet/src/logic/mixin/cart_mixin/cart_mixin.dart';
import 'package:engagementwallet/src/logic/models/mock_data.dart';
import 'package:engagementwallet/src/logic/models/product_model/product_model.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/shop_description.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/shop_items.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/functions.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/textforms/editText.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchCart extends StatefulWidget {
  const SearchCart({Key? key}) : super(key: key);

  @override
  State<SearchCart> createState() => _SearchCartState();
}

class _SearchCartState extends State<SearchCart> {

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

  final formKey = GlobalKey<FormState>();
  final validator = ValidationBloc();

  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    validator.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Text('Search', style: textStyleBig.copyWith(fontSize: 26)),
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
          builder: (context, _) => Padding(
              padding: defaultHPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EditTextSignUp(
                    text: '',
                    validatorCallback: formValidatorBloc.emailValidator,
                    controller: searchController,
                    textInputType: TextInputType.emailAddress,
                    labelText: "",
                    prefix: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    prefixColor: Colors.black,
                  ),
                  kSmallHeight,
                  RichText(
                    text: TextSpan(
                        text: 'Showing Results for',
                        style: textStyle400Small.copyWith(fontSize: 14),
                        children: [
                          TextSpan(
                              text: ' Macbook', style: textStyle600Small.copyWith(fontSize: 14))
                        ]),
                  ),
                  kLargeHeight,
    Consumer<CartMixin>(
    builder: (BuildContext context, cart, Widget? child) {
      return SizedBox(
        height: shopData.length <= 3 ? 470 : 700,
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 199,
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 20),
            itemCount: cart.products.length,
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
              )),
        ),
      ],
    );
  }
}

