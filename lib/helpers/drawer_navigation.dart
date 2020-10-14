import 'package:flutter/material.dart';
import 'package:todoy/home_screen.dart';
import 'package:todoy/screens/categories_screen.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text('toDO'),
                accountEmail:  Text('Category & priority based Todo App'),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: Icon(Icons.filter_list,color: Colors.white,),
                  ),
                ),
              decoration: BoxDecoration(
                color: Color(0xff7579e7),
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomeScreen()));
              },
            ),
            ListTile(
              title: Text('Categories'),
              leading: Icon(Icons.view_list),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CategoriesScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
