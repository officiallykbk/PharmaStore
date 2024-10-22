import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmaplus/models/resuableWidgets.dart';
import 'package:pharmaplus/provider/profile_provider.dart';
import 'package:provider/provider.dart';

final _formkey = GlobalKey<FormState>();
final name = TextEditingController();
final email = TextEditingController();

class EditProfile extends StatefulWidget {
  final String name;
  final String email;
  final String profileImg;
  const EditProfile(
      {super.key,
      required this.name,
      required this.email,
      required this.profileImg});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    name.text = widget.name;
    email.text = widget.email;
  }

  final picker = ImagePicker();
  String? Imageurl;

  Future getImageGallery(imgsource) async {
    try {
      final pickedFile = await picker.pickImage(source: imgsource);

      if (pickedFile != null) {
        await uploadImageToFirebase(File(pickedFile.path));
      }
    } catch (e) {
      print('Failed to pick image {e}');
    }
  }

  Future<void> uploadImageToFirebase(File image) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.png');
      await ref.putFile(image).whenComplete(() {
        CustomSnackBar.show(context, 'Image Uploaded', Icons.check);
      });
      Imageurl = await ref.getDownloadURL();
    } catch (e) {
      print('Failed to upload image ${e}');
      CustomSnackBar.show(context, 'Failed to Upload Image', Icons.error,
          backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Edit Profile Data'),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.close)),
          actions: [
            IconButton(
                onPressed: () {
                  bool valid = _formkey.currentState!.validate();
                  if (valid) {
                    Navigator.pop(context);
                    context.read<ProfileProvider>().setname(name.text);
                    // context.read<ProfileProvider>().setemail(email.text);
                    context.read<ProfileProvider>().setprofileImg(Imageurl);
                  } else {
                    valid;
                  }
                },
                icon: const Icon(Icons.save_as_rounded))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Select Image Option'),
                          actions: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder()),
                                    onPressed: () {
                                      getImageGallery(ImageSource.gallery);
                                    },
                                    child: const Text(
                                        'Select image from gallery')),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder()),
                                    onPressed: () {
                                      getImageGallery(ImageSource.camera);
                                    },
                                    child:
                                        const Text('Take image using camera'))
                              ],
                            )
                          ],
                        );
                      });
                },
                child: Container(
                  decoration: BoxDecoration(border: Border.all()),
                  width: 200,
                  height: 200,
                  child: Imageurl != null
                      ? Image.network(
                          Imageurl!,
                          fit: BoxFit.cover,
                        )
                      : Stack(
                          children: [
                            Image.network(
                              width: 200,
                              height: 200,
                              widget.profileImg,
                              fit: BoxFit.cover,
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Tap to change photo',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ],
                        ),
                ),
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 15),
                      child: TextFormField(
                        readOnly: true,
                        controller: name,
                        minLines: 1,
                        maxLines: 5,
                        decoration: const InputDecoration(
                            labelText: 'Name', border: OutlineInputBorder()),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field can not be empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 15),
                      child: TextFormField(
                        readOnly: true,
                        controller: email,
                        decoration: const InputDecoration(
                            enabled: false,
                            labelText: 'Email',
                            border: OutlineInputBorder()),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field can not be empty';
                          } else {
                            bool isValidEmail(String email) {
                              final emailRegex = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                              );
                              return emailRegex.hasMatch(email);
                            }

                            if (isValidEmail(email.text)) {
                              return null;
                            } else {
                              return 'Invalid Email';
                            }
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
