import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_addressbook_app/models/contact_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/contact_provider.dart';

class NewContactPage extends StatefulWidget {
  const NewContactPage({Key? key}) : super(key: key);

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final streetController = TextEditingController();
  final websiteController = TextEditingController();
  String? dob;
  String? imagePath;
  String genderGroupValue = 'Male';
  ImageSource source = ImageSource.camera;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    streetController.dispose();
    websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
        actions: [
          IconButton(
            onPressed: _saveContact,
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextInputField(
              nameController: nameController,
              labelText: 'Full Name',
              prefix: Icons.person,
              keyboardType: TextInputType.name),
          SizedBox(
            height: 10,
          ),
          TextInputField(
              nameController: mobileController,
              prefix: Icons.call,
              labelText: 'Enter Mobile Number',
              keyboardType: TextInputType.number),
          SizedBox(
            height: 10,
          ),
          TextInputField(
              nameController: emailController,
              labelText: 'Enter Email Address',
              prefix: Icons.email,
              keyboardType: TextInputType.emailAddress),
          SizedBox(
            height: 10,
          ),
          TextInputField(
            nameController: streetController,
            prefix: Icons.location_city,
            labelText: 'Streeet Address',
          ),
          SizedBox(
            height: 10,
          ),
          TextInputField(
            nameController: websiteController,
            prefix: Icons.web_sharp,
            labelText: 'Website',
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            elevation: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Select Gender'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: 'Male',
                      groupValue: genderGroupValue,
                      onChanged: (value) {
                        setState(() {
                          genderGroupValue = value!;
                        });
                      },
                    ),
                    Text('Male'),
                    SizedBox(
                      width: 7,
                    ),
                    Radio<String>(
                      value: 'Female',
                      groupValue: genderGroupValue,
                      onChanged: (value) {
                        setState(() {
                          genderGroupValue = value!;
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: _showDatePickerDialog,
                  child: Text('Select Date of Birth')),
              Chip(
                label: Text(dob == null ? 'No Date Chosen' : dob!),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 5,
                child: imagePath == null
                    ? Image.asset(
                        'images/person.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(imagePath!),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        source = ImageSource.camera;
                        _getImage();
                      },
                      icon: Icon(Icons.camera),
                      label: Text('Capture')),
                  TextButton.icon(
                      onPressed: () {
                        source = ImageSource.gallery;
                        _getImage();
                      },
                      icon: Icon(Icons.photo),
                      label: Text('Gallery'))
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  void _showDatePickerDialog() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1922),
        lastDate: DateTime.now());
    if (selectedDate != null) {
      setState(() {
        dob = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  void _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  void _saveContact() {
    final contact = ContactModel(
      name: nameController.text,
      mobile: mobileController.text,
      email: emailController.text,
      streetAddress: streetController.text,
      website: websiteController.text,
      dob: dob,
      image: imagePath,
      gender: genderGroupValue,
    );
    Provider.of<ContactProvider>(context, listen: false).addContact(contact);
    Navigator.pop(context);
  }
}

class TextInputField extends StatelessWidget {
  String? labelText;
  IconData? prefix;
  TextInputType? keyboardType;
  TextInputField({
    Key? key,
    this.labelText,
    this.keyboardType,
    this.prefix,
    required this.nameController,
  }) : super(key: key);

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: nameController,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        filled: false,
        labelText: labelText.toString(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
    );
  }
}
