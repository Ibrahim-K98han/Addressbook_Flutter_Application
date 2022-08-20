import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_addressbook_app/models/contact_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName = '/new_contact';
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
          TextField(
            keyboardType: TextInputType.name,
            controller: nameController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              filled: true,
              labelText: 'Full Name'
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            keyboardType: TextInputType.phone,
            controller: mobileController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                filled: true,
                labelText: 'Enter Mobile Number'
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                filled: true,
                labelText: 'Enter Email Address'
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            keyboardType: TextInputType.streetAddress,
            controller: streetController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.my_location),
                filled: true,
                labelText: 'Streeet Address'
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            keyboardType: TextInputType.text,
            controller: websiteController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.web),
                filled: true,
                labelText: 'Website'
            ),
          ),
          SizedBox(height: 10,),
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
                      onChanged: (value){
                        setState((){
                          genderGroupValue = value!;
                        });
                      },
                    ),
                    Text('Male'),
                    SizedBox(width: 7,),
                    Radio<String>(
                      value: 'Female',
                      groupValue: genderGroupValue,
                      onChanged: (value){
                        setState((){
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
                  child: Text('Select Date of Birth')
              ),
              Chip(
                label: Text(dob == null ? 'No Date Chosen': dob!),
              )
            ],
          ),
          SizedBox(height: 10,),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 5,
                child: imagePath == null ?
                    Image.asset('images/person.png',width: 100,height: 100,fit: BoxFit.cover,):
                    Image.file(File(imagePath!),width: 100,height: 100,fit: BoxFit.cover,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                      onPressed: (){
                        source = ImageSource.camera;
                        _getImage();
                      },
                      icon: Icon(Icons.camera),
                      label: Text('Capture')
                  ),
                  TextButton.icon(
                      onPressed: (){
                        source = ImageSource.gallery;
                        _getImage();
                      },
                      icon: Icon(Icons.photo),
                      label: Text('Gallery')
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  void _showDatePickerDialog() async{
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1922),
        lastDate: DateTime.now());
    if(selectedDate != null){
      setState((){
        dob = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  void _getImage() async{
    final pickedFile = await ImagePicker().pickImage(source: source);
    if(pickedFile != null){
      setState((){
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
    contactList.add(contact);
    Navigator.pop(context);
  }
}
