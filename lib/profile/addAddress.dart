import 'package:flutter/material.dart';
import 'package:pharmaplus/models/address.dart';
import 'package:pharmaplus/models/resuableWidgets.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({super.key});

  @override
  State<AddressForm> createState() => _AddressFormState();
}

final _formkey = GlobalKey<FormState>();
final GPS = TextEditingController();
final info = TextEditingController();
final region = TextEditingController();
final city = TextEditingController();
final district = TextEditingController();
final landmark = TextEditingController();

void clearFields() {
  GPS.clear();
  info.clear();
  region.clear();
  city.clear();
  district.clear();
  landmark.clear();
}

class _AddressFormState extends State<AddressForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15),
                  child: TextFormField(
                    controller: GPS,
                    decoration: InputDecoration(
                        labelText: 'Ghana Post Address',
                        border: const OutlineInputBorder(),
                        hintText: 'AK-XXX-XXXX',
                        suffixIcon: TextButton(
                            onPressed: () async {
                              final Useraddress = await fetchAddress(GPS.text);

                              // we are going to save the editted address AS Address instead not ghanapost address
                              setState(() {
                                if (Useraddress != null) {
                                  region.text = Useraddress.region;
                                  city.text = Useraddress.city;
                                  district.text = Useraddress.district;
                                  landmark.text = Useraddress.landmark;
                                } else {
                                  CustomSnackBar.show(context,
                                      'Invalid Ghana Post Address', Icons.error,
                                      backgroundColor: Colors.red);
                                }
                              });
                            },
                            child: const Text('Check'))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field can not be empty.\nEnter AK-000-0000, check and fill popup form below';
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
                    controller: region,
                    decoration: const InputDecoration(
                      labelText: 'Region',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15),
                  child: TextFormField(
                    controller: city,
                    decoration: const InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15),
                  child: TextFormField(
                    controller: district,
                    decoration: const InputDecoration(
                      labelText: 'District',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15),
                  child: TextFormField(
                    controller: landmark,
                    decoration: const InputDecoration(
                      labelText: 'LandMark',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      bool valid = _formkey.currentState!.validate();
                      if (valid) {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.white, Colors.blue],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft)),
                      child: Text(
                        'Save',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
