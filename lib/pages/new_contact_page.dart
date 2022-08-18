import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName = '/new_contact';
  const NewContactPage({Key? key}) : super(key: key);

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final nameController = TextEditingController();
  String? dob;
  String? imagePath;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
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
                      onPressed: (){},
                      icon: Icon(Icons.camera),
                      label: Text('Capture')
                  ),
                  TextButton.icon(
                      onPressed: (){},
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
}
