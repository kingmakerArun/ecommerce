import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'home.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isSwitched = false;
  static const List<String> list = <String>['Male', 'Female', 'Transgender'];
  String dropdownValue = list.first;
  static const List<String> list1 = <String>['Select your city',
    'Ariyalur','Chengalpattu','Chennai','Coimbatore','Cuddalore',
    'Dharmapuri','Dindigul','Erode','Kallakurichi','Kancheepuram',
    'Karur','Krishnagiri','Madurai','Mayiladuthurai','Nagapattinam',
    'Nagercoil','Namakkal','Perambalur','Pudukkottai','Ramanathapuram',
    'Ranipet','Salem','Sivagangai','Tenkasi','Thanjavur',
    'Theni','Thiruvallur','Thiruvarur','Thoothukudi','Tiruchirappalli',
    'Tirunelveli','Tirupathur','Tiruppur','Tiruvannamalai','Ooty',
    'Vellore','Viluppuram','Virudhunagar','Outside of Tamilnadu'];
  String dropdownValue1 = list1.first;
  Uint8List? _image;
  @override
  void initState() {
    super.initState();
    loadImageFromPreferences();  }

  Future<void> loadImageFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? base64String = prefs.getString('saved_image');
    if (base64String != null) {
      final Uint8List bytes = base64Decode(base64String);
      setState(() {
        _image = bytes;
      });
    }
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/10,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      getImageFromGallery();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(Icons.image,size: 70,color: Colors.redAccent),
                          Text("Files",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      getImageFromCamera();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt, size: 70,color: Colors.redAccent),
                          Text( "Camera",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage
      (source: ImageSource.gallery);
    if (pickedFile != null) {
      final Uint8List imageBytes = await pickedFile.readAsBytes();
      await saveImageToPreferences(imageBytes); // Save image to SharedPreferences
      setState(() {
        _image = imageBytes;
      });
    }
  }
  Future<void> getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final Uint8List imageBytes = await pickedFile.readAsBytes();
      await saveImageToPreferences(imageBytes); // Save image to SharedPreferences
      setState(() {
        _image = imageBytes;
      });
    }
  }
  Future<void> saveImageToPreferences(Uint8List imageBytes) async {
    final String base64String = base64Encode(imageBytes);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_image', base64String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Stack(
                      alignment: Alignment.center, // Align items in the center
                      children: [
                        _image != null
                            ? CircleAvatar(
                          radius: 70,
                          backgroundImage: MemoryImage(_image!),
                        )
                            : const CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpd4mJRIUwqgE8D_Z2znANEbtiz4GhI4M8NQ&s"),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 2,
                          child: IconButton(
                            onPressed: () {
                              showImagePickerOption(context);
                            },
                            icon: const Icon(Icons.add_a_photo, size: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Icon(Icons.person),
                          ),
                          Text("Name", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.only(left:60.0),
                            child: Text("Arun", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(color: Colors.red,
                    height: 15,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Icon(Icons.phone_iphone),
                          ),
                          Text("Phone no", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.only(left:60.0),
                            child: Text("+919876543210", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(color: Colors.red,
                    height: 15,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Icon(Icons.add),
                          ),
                          const Text("Gender", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.only(left: 100.0),
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black ),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              items: list.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(value: value,child: Text(value));
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(color: Colors.red,
                    height: 15,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Icon(Icons.add_location),
                          ),
                          const Text("Location", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.only(left: 60.0),
                            child: DropdownButton<String>(
                              value: dropdownValue1,
                              // icon: const Icon(Icons.arrow_downward),
                              // elevation: 25,
                              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue1 = value!;
                                });
                              },
                              items: list1.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(value: value,child: Text(value));
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(color: Colors.red,
                    height: 15,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(onPressed: (){
                      setState(() {
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>
                          const Home()),);
                      });
                    }, child: const Text("Save", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
