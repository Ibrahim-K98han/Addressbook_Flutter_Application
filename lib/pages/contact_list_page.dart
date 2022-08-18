import 'package:flutter/material.dart';
import 'package:flutter_addressbook_app/pages/new_contact_page.dart';

class ContactListPage extends StatefulWidget {
  static const String routeName = '/';
  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.pushNamed(context, NewContactPage.routeName),
        child: Icon(Icons.add),
      ),
    );
  }
}
