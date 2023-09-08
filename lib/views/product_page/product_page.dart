import 'package:arv/utils/app_colors.dart';
import 'package:arv/views/widgets/banner_carousel_section.dart';
import 'package:arv/views/widgets/carousel_one/carousel_section_one.dart';
import 'package:arv/views/widgets/category/fixed_category_section.dart';
import 'package:arv/views/widgets/category_collections.dart';
import 'package:arv/views/widgets/dual_card_section.dart';
import 'package:arv/views/widgets/favourite_picks.dart';
import 'package:arv/views/widgets/fixed_dashboard_banner.dart';
import 'package:arv/views/widgets/mini_banner.dart';
import 'package:arv/views/widgets/offer_products.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final List<String> imgList = [
  'assets/images/pp1.png.webp',
  'assets/images/pp2.png.webp',
  'assets/images/pp3.png.webp'
];
final List<String> imgLists = [
  'assets/images/tr.webp',
  'assets/images/tr1.webp',
  'assets/images/tr3.webp',
  'assets/images/tr4.webp',
  'assets/images/tr5.webp',
  'assets/images/tr6.webp',
  'assets/images/tr7.webp',
  'assets/images/tr8.webp',
  'assets/images/tr9.webp',
  'assets/images/tr10.webp',
  'assets/images/tr11.webp',
  'assets/images/tr12.webp',
];
final List<String> imgListss = [
  'assets/images/qw1.webp',
  'assets/images/qw2.webp',
];

final List<String> bnrList = [
  'assets/images/q1.png',
  'assets/images/q2.png',
  'assets/images/q3.png',
  'assets/images/q2.png',
];

class ProductPage extends StatefulWidget {
  bool check;
   ProductPage(this.check) ;

  @override
  State createState() => _ProductPageState();
}

var currentTab = 0;

class _ProductPageState extends State<ProductPage> {
  int selectedIndex = 0;
  int indexVal = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight) / 3;
    final double itemWidth = size.width / 2;
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.white,
    //   statusBarBrightness: Brightness.dark,
    // ));
    final labelTextStyle =
        Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 8.0);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading:InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back,color: Colors.black,),
                ),

              title: Center(child: Text("Product Page",style: TextStyle(color: Colors.black),),)
              ,
            ),
      body: Row(
        children: [
          !widget.check?     Container(
            padding: EdgeInsets.only(top: 10,right: 10),

            decoration: BoxDecoration(
              border: Border.all(color: lightpink),
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 100,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bnrList.length,
                    primary: false,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            indexVal = index;
                          });
                        },
                        child: Container(
                          color: indexVal == index ? pink : Colors.white,
                          height: 100,
                          padding: EdgeInsets.only(bottom: 20, top: 10),
                          margin: EdgeInsets.only(left: 10),
                          width: 50,
                          child: Image.asset(
                            "assets/images/q1.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ):Container(),
    Container(
    width:widget.check?MediaQuery.of(context).size.width:  MediaQuery.of(context).size.width-120,
    padding: EdgeInsets.only(top: 10),
    child:
    GridView.count(
              crossAxisCount:    !widget.check?    2:3,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 8.0,
              children: List.generate(20, (index) {
                return Center(
                  child:  Container(

                    decoration: BoxDecoration(
                      border: Border.all(color: lightpink),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: EdgeInsets.only(left:16 , right: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        width: 140,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                             "assets/images/q1.png",
                              height: 34,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 8), // Add padding to text
                              child: Text(
                                "Name",
                                style: GoogleFonts.poppins(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 4), // Add padding
                              child: Text(
                                "Non",
                                style: GoogleFonts.poppins(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start, // Align text
                                  children: [
                                    Text(
                                      "100 rs",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "100 rs",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: 0 == 0
                                      ? OutlinedButton(
                                    onPressed: () async =>null,
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(width: 1.0, color: pink),
                                    ),
                                    child: Text(
                                      'Add',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w300,
                                        color: pink,
                                      ),
                                    ),
                                  )
                                      : Container(
                                    width: 75,
                                    height: 35,
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.0,
                                        color: pink,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          child: Icon(
                                            Icons.remove,
                                            size: 16,
                                            color: gray,
                                          ),
                                          onTap: () async =>null,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            '11',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          child: Icon(
                                            Icons.add,
                                            size: 16,
                                            color: gray,
                                          ),
                                          onTap: () async =>
                                          await null,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
              }))
    )
        ],
      ),
    ));
  }
}
