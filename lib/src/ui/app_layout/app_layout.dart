import 'package:engagementwallet/src/logic/mixin/page_controller_mixin.dart';
import 'package:engagementwallet/src/ui/app_layout/home/home.dart';
import 'package:engagementwallet/src/ui/app_layout/more/more.dart';
import 'package:engagementwallet/src/ui/app_layout/reward/reward.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/add_to_cart.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/shop.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../values/assets.dart';


class AppLayout extends StatefulWidget {
  final int? index;
  const AppLayout({this.index, Key? key}) : super(key: key);

  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  PageController? _pageController;
  int? _selectedIndex;


  final List<Widget> _screens = [
    const HomeScreen(),
    const AddToCart(),
    const RewardScreen(),
    const MoreScreen(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTapped(int selectedIndex) {
    _pageController!.jumpToPage(selectedIndex);
  }

  @override
  void initState() {
    _pageController = PageController(
      initialPage: widget.index ?? 0,
    );
    _selectedIndex = widget.index ?? 0;
    PageMixin.pageProvider(context).setPageController(_pageController!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTapped,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex!,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: secondaryColor,
        iconSize: 20,
        items: [
          BottomNavigationBarItem(
            icon:  SvgPicture.asset(Assets.home),
            activeIcon: SvgPicture.asset(Assets.homeActive),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon:  SvgPicture.asset(Assets.shop),
            activeIcon: SvgPicture.asset(Assets.shopActive) ,
            label: 'Cart'
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.reward),
            activeIcon: SvgPicture.asset(Assets.rewardActive),
            label: 'Rewards'
          ),
          BottomNavigationBarItem(
            icon:  SvgPicture.asset(Assets.lightBulb),
            activeIcon: SvgPicture.asset(Assets.lightBulbActive),
            label: 'More'
          ),

        ],
      ),
    );
  }


}
