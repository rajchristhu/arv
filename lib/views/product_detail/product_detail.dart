import 'package:flutter/material.dart';


class ProductDetailPageView extends StatefulWidget {
  const ProductDetailPageView({super.key});

  @override
  State createState() => _ProductDetailPageViewState();
}

class _ProductDetailPageViewState extends State<ProductDetailPageView> {
  List<Color> colors = [Colors.blue, Colors.green, Colors.yellow, Colors.pink];
  List<String> imagePath = ["images/shoe_blue.png", "images/shoe_green.png", "images/shoe_yellow.png", "images/shoe_pink.png"];
  Color selectedColor = Colors.blue;
  var isFavourite = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              header(),
              hero(),
              Expanded(child: section()),
              bottomButton()
            ],
          ),
        ));
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("images/back_button.png"),
          Column(
            children: [
              Text("MEN'S ORIGINAL",
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 16)),
              Text("Smith Shoes",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24))
            ],
          ),
          Image.asset(
            "images/bag_button.png",
            height: 34,
            width: 34,
          ),
        ],
      ),
    );
  }

  Widget hero() {
    return Container(
      child: Stack(
        children: [
          Image.asset(imagePath[colors.indexOf(selectedColor)]),
          Positioned(
              bottom: 10,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: (){
                  setState(() {
                    isFavourite = !isFavourite;
                  });
                },
                child: Image.asset(
                  isFavourite ? "images/heart_icon.png" : "images/heart_icon_disabled.png",
                  height: 34,
                  width: 34,
                ),
              ))
        ],
      ),
    );
  }

  Widget section() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In "
                "rutrum at ex non eleifend. Aenean sed eros a purus "
                "gravida scelerisque id in orci. Mauris elementum id "
                "nibh et dapibus. Maecenas lacinia volutpat magna",
            textAlign: TextAlign.justify,
            style:
            TextStyle(color: Colors.black, fontSize: 14, height: 1.5),
          ),
          SizedBox(height: 20),
          property()
        ],
      ),
    );
  }

  Widget property() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Color",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              SizedBox(height: 10),
              Row(
                children: List.generate(
                    4,
                        (index) => GestureDetector(
                      onTap: (){
                        print("index $index clicked");
                        setState(() {
                          selectedColor = colors[index];
                        });
                      },
                      child: Container(
                        padding:EdgeInsets.all(8),
                        margin: EdgeInsets.only(right: 10),
                        height: 34,
                        width: 34,
                        child: selectedColor == colors[index]? Image.asset("images/checker.png") : SizedBox(),
                        decoration: BoxDecoration(
                            color: colors[index],
                            borderRadius: BorderRadius.circular(17)),
                      ),
                    )),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Size",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Text(
                    "10.2",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget bottomButton() {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
              onPressed: () {},
              child: Text(
                "Add to Bag +",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              )),
          Text(r"$95", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28))
        ],
      ),
    );
  }
}