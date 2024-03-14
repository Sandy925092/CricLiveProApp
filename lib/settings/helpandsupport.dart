import 'package:flutter/material.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  TextEditingController emailController = TextEditingController();
  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColors,
          elevation: 0.0,
          leadingWidth: 30,
          centerTitle: false,
          title: commonText(
                  data: "Help and Support",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  color: Colors.white)
              .p(10),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset(
                "assets/images/backicon.png",
                height: 0,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  hintStyle: TextStyle(
                      color: white, fontSize: 14, fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: primaryColors,
                      width: 1.0,
                    ),
                  ),
                  prefixIcon: Image.asset(
                    "assets/images/user.png",
                    scale: 4,
                    color: white,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Container(
                // height: 134,
                // width: double.infinity,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: queryController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Your Querry',
                    hintStyle: TextStyle(
                        color: white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: primaryColors,
                        width: 1.0,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  ),
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: commonText(
                    data: "Submit",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    color: primaryColors),
              ),
            ).pOnly(left: 20, right: 20, top: 20),
          ],
        ),
      ),
    );
  }
}
