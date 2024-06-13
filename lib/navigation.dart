import 'package:adminpanel/addproducts.dart';
import 'package:adminpanel/category.dart';
import 'package:adminpanel/product.dart';
import 'package:adminpanel/productlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationPage extends StatefulWidget {
  NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int selectindex = 0;
  final List<Widget> screen = [
    Expanded(child: Category()),
    Expanded(child: AddProducts()),
    Expanded(child: ProductsScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
            backgroundColor: Colors.white,
            indicatorShape: RoundedRectangleBorder(),
            indicatorColor: Colors.white,
            selectedIconTheme:
                IconThemeData(color: Color.fromARGB(255, 225, 61, 49)),
            labelType: NavigationRailLabelType.all,
            selectedLabelTextStyle: TextStyle(
                color: Color.fromARGB(255, 225, 61, 49),
                fontFamily: 'Popp',
                fontWeight: FontWeight.bold),
            unselectedLabelTextStyle: TextStyle(
              color: Colors.black,
              fontFamily: 'MeFont',
            ),
            minWidth: MediaQuery.of(context).size.width * 0.1,
            leading: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 225, 61, 49),
                radius: 30,
                child: Icon(
                  Icons.person_2,
                  color: Colors.white,
                  size: 40,
                )),
            onDestinationSelected: (int index) {
              setState(() {
                selectindex = index;
              });
            },
            destinations: [
              NavigationRailDestination(
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                  icon: Icon(Icons.add_box_outlined),
                  label: Text(
                    'Category',
                  )),
              NavigationRailDestination(
                  icon: FaIcon(Icons.add_chart_outlined),
                  label: Text(
                    'AddProducts',
                  )),
              NavigationRailDestination(
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                  icon: Icon(Icons.production_quantity_limits),
                  label: Text(
                    'All Products',
                  )),
            ],
            selectedIndex: selectindex),
        screen[selectindex]
      ],
    );
  }
}
