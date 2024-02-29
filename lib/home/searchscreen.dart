import 'package:flutter/material.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColors,
          elevation: 0.0,
          leadingWidth: 30,
          centerTitle: false,
          title: commonText(
                  data: "Search",
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
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search here...',
                  hintStyle: TextStyle(
                      color: primaryColors,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: primaryColors,
                      width: 1.0,
                    ),
                  ),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search, size: 30, color: primaryColors),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            2.h.heightBox,
            ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonText(
                        data: index == 0 ? "Match Odds" : "T20",
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Poppins",
                        color: primaryColors,
                      ).pOnly(left: 20.0, right: 16.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0 , bottom: 9),
                        child: Divider(
                          thickness: 1.0,
                          color: buttonColors,
                        ),
                      ),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
