

import 'package:market_place_app/utils/exports.dart';

/// VIEW MEMBER DETAILS DIALOG
void sosAlertDialog(
    {required BuildContext context, required Function setDialogueContext}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (ctx) {
      setDialogueContext(ctx);
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.1),
                  RippleAnimation(
                    color: Colors.deepOrange,
                    delay: const Duration(milliseconds: 300),
                    repeat: true,
                    minRadius: 70,
                    maxRadius: 140,
                    ripplesCount: 6,
                    duration: const Duration(milliseconds: 6 * 300),
                    child: CircleAvatar(
                      minRadius: 70,
                      maxRadius: 70,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgxe7zof3JzTMaEWYcBD6sq9Pr-5SmUQkaUkd238NWutbyLuP7Vbrcc2ultZQfVT9_eUE&usqp=CAU'),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  const Text(
                      "Confirmation request send to support team.\nPlease do not press back button",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black87, fontSize: 14)),
                  const SizedBox(height: 15),
                  SizedBox(
                      height: size.height * 0.04,
                      child: CustomButton(
                        onPressed: ()=>Navigator.pop(context),
                        txt: "CANCEL",
                      )),
                  const SizedBox(height: 60)
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
