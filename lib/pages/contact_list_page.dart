import 'package:flutter/material.dart';
import 'package:flutter_addressbook_app/models/contact_model.dart';
import 'package:flutter_addressbook_app/pages/contact_details_page.dart';
import 'package:flutter_addressbook_app/pages/new_contact_page.dart';
import 'package:flutter_addressbook_app/provider/contact_provider.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<ContactProvider>(
        builder: (context, provider, _) => ListView.builder(
          itemCount: provider.contactList.length,
          itemBuilder: (context, index) {
            final contact = provider.contactList[index];
            return Card(
              child: ListTile(
                onTap: () => Navigator
                    .pushNamed(
                    context,
                    ContactDetailsPage.routeName,
                    arguments: contact),
                leading: CircleAvatar(
                  child: Text(contact.name.substring(0,2)),
                ),
                title: Text(contact.name),
                trailing: IconButton(
                    icon: Icon(contact.favoite ? Icons.favorite : Icons.favorite_border,color: Colors.red,),
                    onPressed: (){
                      provider.updateFavorite(index);
                    },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator
            .pushNamed(context,
            NewContactPage.routeName
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
