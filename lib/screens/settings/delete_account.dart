import 'package:market_place_app/screens/settings/dialogs.dart';
import 'package:market_place_app/utils/exports.dart';

class DeleteUserAccount extends StatefulWidget {
  const DeleteUserAccount({super.key});

  @override
  State<DeleteUserAccount> createState() => _DeleteUserAccountState();
}

class _DeleteUserAccountState extends State<DeleteUserAccount> {
  String? selectedValue;
  List<String> reasonList = [
    'Find a Better Alternative',
    'Need a Break',
    'Do not find useful anymore',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppbar(title: 'Delete Account'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Image.asset(Assets.appLogo, width: size.width * 0.6,color: AppColors.themeColor),
            SizedBox(height: 50),
            Text('Delete your account ',
                style: AppStyle.medium_20(AppColors.themeColor)),
            SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                    "Help us improve our app, Explain the reason why you want to delete your account",
                    textAlign: TextAlign.center,
                    style: AppStyle.medium_14(AppColors.blackColor))),
            const SizedBox(height: 20),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text('Select Reason Type',
                    style: AppStyle.normal_16(AppColors.blackColor),
                    overflow: TextOverflow.ellipsis),
                items: reasonList
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: AppStyle.medium_16(AppColors.blackColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (String? value) {
                  selectedValue = value;
                  setState(() {});
                },
                buttonStyleData: ButtonStyleData(
                    height: 50,
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)))),
                iconStyleData: const IconStyleData(
                    icon: Icon(Icons.arrow_drop_down_sharp), iconSize: 25),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  offset: const Offset(0, -5),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(5),
                    thickness: MaterialStateProperty.all<double>(6),
                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.only(left: 14, right: 14),
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                if (selectedValue != null) {
                  logOutPermissionDialog(context,forDelete: true);
                } else {
                  snackBar(
                      context, 'Please Select Reason Type', AppColors.redColor);
                }
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.themeColor),
                child: Center(
                  child: Text(
                    'Delete Account',
                    style: AppStyle.medium_16(AppColors.whiteColor),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
