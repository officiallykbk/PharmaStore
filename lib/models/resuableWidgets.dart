// code to use alert
// onPressed: () {
//       showDialog(
//           barrierDismissible: false,
//             context: context,
//             builder: (context) {
//               return

// InfoAlert
import 'package:flutter/material.dart';

class InfoAlert extends StatelessWidget {
  const InfoAlert({super.key, required this.titletext, this.subtext = ''});

  final String titletext;
  final String subtext;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        titletext,
        textAlign: TextAlign.center,
      ),
      content: Text(
        subtext,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.merge(const TextStyle(color: Colors.red)),
          ),
        )
      ],
    );
  }
}

// yes-Cancel Alert window
class YesAlert extends StatelessWidget {
  const YesAlert(
      {super.key,
      required this.titletext,
      this.subtext = '',
      this.Yesfn = true});

  final String titletext;
  final String subtext;
  final bool Yesfn;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        titletext,
        textAlign: TextAlign.center,
      ),
      content: Text(
        subtext,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.white,
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                print('Yes clicked');
                if (Yesfn) {
                  Navigator.of(context).pop(true);
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: const Text(
                  "Yes",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                    )),
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

// successSnackBar
class CustomSnackBar {
  static void show(BuildContext context, String message, IconData icon,
      {Color backgroundColor = Colors.green, int durationMs = 800}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(milliseconds: durationMs),
      backgroundColor: backgroundColor,
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    ));
  }
}
