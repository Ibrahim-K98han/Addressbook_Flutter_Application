import 'package:flutter/material.dart';
import 'package:flutter_addressbook_app/pages/contact_details_page.dart';
import 'package:flutter_addressbook_app/pages/contact_list_page.dart';
import 'package:flutter_addressbook_app/pages/new_contact_page.dart';
import 'package:flutter_addressbook_app/provider/contact_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ContactProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ContactListPage.routeName,
      routes: {
        ContactListPage.routeName : (context) => ContactListPage(),
        NewContactPage.routeName : (context) => NewContactPage(),
        ContactDetailsPage.routeName : (context) => ContactDetailsPage()
      },
    );
  }
}

