import 'package:flutter/material.dart';
import 'package:pharmaplus/profile/addAddress.dart';

class Address extends StatefulWidget {
  const Address({super.key});
  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final addressModel = Provider.of<AddressProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => AddressForm()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Center(
        child: SizedBox(
            height: 300,
            child: PageView.builder(
              clipBehavior: Clip.none,
              controller: _pageController,
              itemCount: 3, //addressModel.address.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            offset: Offset(18, 29),
                            blurRadius: 2)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Page ${index}')],
                  ),
                );
              },
            )),
      ),
    );
  }
}
