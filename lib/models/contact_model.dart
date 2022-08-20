final contactListDB = <ContactModel>[
  ContactModel(
      id: 1,
      name: 'Ibrahim Khan',
      mobile: '01751800957',
      email: 'ibrahim@gmail.com',
      streetAddress: 'Demra Dhaka',
      gender: 'Male',
      dob: '06/03/1998',
      website: 'www.ibrahim.com'
  ),
  ContactModel(
      id: 2,
      name: 'Hasan Khan',
      mobile: '01851800957',
      email: 'hasan@gmail.com',
      streetAddress: 'Demra Dhaka',
      gender: 'Male',
      dob: '06/03/1998',
      website: 'www.hasan.com'
  ),
];

class ContactModel{
  int? id;
  String name;
  String mobile;
  String? email;
  String? streetAddress;
  String? dob;
  String? image;
  String? gender;
  String? website;

  ContactModel({
      this.id,
      required this.name,
      required this.mobile,
      this.email,
      this.streetAddress,
      this.dob,
      this.image,
      this.gender,
      this.website
  });

  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, mobile: $mobile, email: $email, streetAddress: $streetAddress, dob: $dob, image: $image, gender: $gender, website: $website}';
  }
}