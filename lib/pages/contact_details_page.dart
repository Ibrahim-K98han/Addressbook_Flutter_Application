import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_addressbook_app/models/contact_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailsPage extends StatelessWidget {
  final ContactModel contact;
  ContactDetailsPage({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
      ),
      body: ListView(
        children: [
          contact.image == null
              ? Image.asset(
                  'images/person.png',
                  width: double.maxFinite,
                  height: 250,
                  fit: BoxFit.cover,
                )
              : Image.file(
                  File(contact.image!),
                  width: double.maxFinite,
                  height: 250,
                  fit: BoxFit.cover,
                ),
          ListTile(
            title: Text(contact.mobile),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    //  _callPerson
                  },
                  icon: Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //  _smsContact
                  },
                  icon: Icon(
                    Icons.sms,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(contact.email == null || contact.email!.isEmpty
                ? 'Unavailable'
                : contact.email!),
            trailing: IconButton(
              icon: Icon(
                contact.email == null || contact.email!.isEmpty
                    ? Icons.edit
                    : Icons.email,
                color: Colors.green,
              ),
              onPressed: () {
                // _mailContact
              },
            ),
          ),
          ListTile(
            title: Text(
                contact.streetAddress == null || contact.streetAddress!.isEmpty
                    ? 'Unavailable'
                    : contact.streetAddress!),
            trailing: IconButton(
              icon: Icon(
                contact.streetAddress == null || contact.streetAddress!.isEmpty
                    ? Icons.edit
                    : Icons.map,
                color: Colors.green,
              ),
              onPressed: () {
                // _showMap
              },
            ),
          ),
        ],
      ),
    );
    ;
  }
}

// class ContactDetailsPage extends StatefulWidget {
//   static const String routeName = '/contact_details';
//   const ContactDetailsPage({Key? key, required ContactModel contact})
//       : super(key: key);

//   @override
//   State<ContactDetailsPage> createState() => _ContactDetailsPageState();
// }

// class _ContactDetailsPageState extends State<ContactDetailsPage> {
//   late ContactModel contact;

//   @override
//   void didChangeDependencies() {
//     contact = ModalRoute.of(context)!.settings.arguments as ContactModel;
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(contact.name),
//       ),
//       body: ListView(
//         children: [
//           contact.image == null
//               ? Image.asset(
//                   'images/person.png',
//                   width: double.maxFinite,
//                   height: 250,
//                   fit: BoxFit.cover,
//                 )
//               : Image.file(
//                   File(contact.image!),
//                   width: double.maxFinite,
//                   height: 250,
//                   fit: BoxFit.cover,
//                 ),
//           ListTile(
//             title: Text(contact.mobile),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   onPressed: _callPerson,
//                   icon: Icon(
//                     Icons.call,
//                     color: Colors.green,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: _smsContact,
//                   icon: Icon(
//                     Icons.sms,
//                     color: Colors.green,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             title: Text(contact.email == null || contact.email!.isEmpty
//                 ? 'Unavailable'
//                 : contact.email!),
//             trailing: IconButton(
//               icon: Icon(
//                 contact.email == null || contact.email!.isEmpty
//                     ? Icons.edit
//                     : Icons.email,
//                 color: Colors.green,
//               ),
//               onPressed: _mailContact,
//             ),
//           ),
//           ListTile(
//             title: Text(
//                 contact.streetAddress == null || contact.streetAddress!.isEmpty
//                     ? 'Unavailable'
//                     : contact.streetAddress!),
//             trailing: IconButton(
//               icon: Icon(
//                 contact.streetAddress == null || contact.streetAddress!.isEmpty
//                     ? Icons.edit
//                     : Icons.map,
//                 color: Colors.green,
//               ),
//               onPressed: _showMap,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _callPerson() async {
//     final uri = Uri.parse('tel:${contact.mobile}');
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'cannot launch url';
//     }
//   }

//   void _smsContact() async {
//     final uri = Uri.parse('sms:${contact.mobile}');
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'cannot launch url';
//     }
//   }

//   void _mailContact() async {
//     final uri = Uri.parse('mailto:${contact.email}');
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'cannot launch url';
//     }
//   }

//   void _showMap() async {
//     String urlString;
//     if (Platform.isAndroid) {
//       urlString = 'geo:0,0?q=${contact.streetAddress}';
//     } else if (Platform.isIOS) {
//       urlString = 'http://maps.apple.com/?q=${contact.streetAddress}';
//     } else {
//       urlString = 'geo:0,0?q=${contact.streetAddress}';
//     }
//     if (await canLaunchUrl(Uri.parse(urlString))) {
//       await launchUrl(Uri.parse(urlString));
//     } else {
//       throw 'cannot launch url';
//     }
//   }
// }
