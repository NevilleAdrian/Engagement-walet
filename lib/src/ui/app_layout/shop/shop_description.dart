import 'package:carousel_slider/carousel_slider.dart';
import 'package:engagementwallet/src/logic/mixin/cart_mixin/cart_mixin.dart';
import 'package:engagementwallet/src/logic/models/mock_data.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/add_to_cart.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/functions.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/back_arrow.dart';
import 'package:engagementwallet/src/widgets/backgrounds/authentication_backgrounds.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/sliders/vertical_sliders.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../values/text_styles.dart';

class ShopDescription extends StatefulWidget {
  const ShopDescription(
      {Key? key,
      this.title,
      this.description,
      required this.amount,
      required this.image, this.thumbNail, this.id})
      : super(key: key);

  final String? id;
  final String? title;
  final String? description;
  final String? thumbNail;
  final int amount;
  final List<String> image;

  @override
  State<ShopDescription> createState() => _ShopDescriptionState();
}

class _ShopDescriptionState extends State<ShopDescription> {
  late List<String> imageList;

  @override
  void initState() {
    if(widget.image.isEmpty){
      imageList = shopData[0]['image'];
    } else {
      imageList = widget.image;

    }
    CartMixin.cartProvider(context).setAmount(widget.amount);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartMixin cart = CartMixin.cartProvider(context, listen: true);

    final List<Widget> imageSliders = imageList
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    ],
                  )),
            ))
        .toList();

    return AuthenticationBackGround(
      height: 1.9.h,
      childPadding: defaultVHPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           BackArrow(
            onTap: (){
              popView(context);
              cart.setPrice(1);
            },
          ),
          kSmallHeight,
          Text(widget.title!.toUpperCase(),
              style: textStyle600Small.copyWith(fontSize: 18)),
          kNormalHeight,
          VerticalSlider(imageSliders: imageSliders, imageList: imageList,)
        ],
      ),
      secondChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text('Product Description', style: textStyle600Small),
          kSmallHeight,
          Text(widget.description!, style: textStyle400Small),
          kNormalHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CartBox(
                amount: widget.amount,
              ),
              kSmallWidth,
              Expanded(
                child: CustomButton(
                  text: "Add To Cart  ₦${addSeparator(toDecimalPlace(cart.amount))}",
                  loader: false,
                  onPressed: () {
                    cart.setCartList({
                      "id": widget.id,
                      "image": widget.thumbNail,
                      "product": widget.title,
                      "quantity": cart.quantity,
                      "amount": cart.amount,
                    });
                    navigate(context, const AddToCart());
                  },
                ),
              )

            ],
          )

        ],
      )
    );
  }
}

class CartBox extends StatefulWidget {
  const CartBox({Key? key, required this.amount}) : super(key: key);

  final int amount;

  @override
  State<CartBox> createState() => _CartBoxState();
}

class _CartBoxState extends State<CartBox> {
  @override
  Widget build(BuildContext context) {
    CartMixin cart = CartMixin.cartProvider(context, listen: true);
    return Row(
      children: [
        // CartButtons(
        //   color: greyishColor,
        //   item: '-',
        //   onTap: () {
        //     cart.reducePrice();
        //     cart.reduceAmount(widget.amount);
        //   },
        // ),
        CartButtons(
          color: greyishColor,
          item: cart.quantity.toString(),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        // CartButtons(
        //   color: greyishColor,
        //   item: '+',
        //   onTap: () {
        //     cart.addPrice();
        //     cart.increaseAmount(widget.amount);
        //   },
        // ),

      ],
    );

  }
}


class CartButtons extends StatelessWidget {
  const CartButtons({
    Key? key, this.color, this.item, this.fontWeight, this.fontSize, this.onTap, this.padding,
  }) : super(key: key);

  final Color? color;
  final String? item;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Function()? onTap;
  final EdgeInsets? padding;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => null,
      child: Container(
        padding: padding ?? defaultCartPadding,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6)
        ),
        child:  Text(item!, style: textStyle400Small.copyWith(fontSize: fontSize ?? 20, fontWeight: fontWeight ?? FontWeight.w400 ),),
      ),
    );
  }
}
