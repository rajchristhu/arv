import 'package:arv/models/response_models/categories.dart';
import 'package:arv/models/response_models/products.dart';
import 'package:arv/models/response_models/sub_categories.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/custom_progress_bar.dart';
import 'package:arv/views/product_page/product_grid_card.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  final bool isExploreAll;
  final bool isCategoryPage;
  final String? majorCategory;
  final String? category;
  final String? subSubCategory;
  final int currentPage;

  const ProductsPage(
    this.isExploreAll,
    this.isCategoryPage,
    this.currentPage,
    this.majorCategory,
    this.category,
    this.subSubCategory, {
    super.key,
  });

  @override
  State createState() => _ProductsPageState();
}

var currentTab = 0;

class _ProductsPageState extends State<ProductsPage> {
  bool isDisposed = false;
  int page = 0;
  int selectedIndex = 0;
  int indexVal = 0;
  String selectedCategory = "";
  Products products = Products(
    list: [],
    currentPage: 0,
    totalCount: 0,
    totalPages: 0,
  );

  ValueNotifier<Products> productsNotifier = ValueNotifier(Products(
    list: [],
    currentPage: 0,
    totalCount: 0,
    totalPages: 0,
  ));

  getProductsByCategory(String categoryId, String? subCategory) async {
    if (isDisposed) return;
    ArvProgressDialog.instance.showProgressDialog(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      products = await arvApi.getAllProducts(
        page,
        widget.majorCategory,
        categoryId,
        subCategory,
      );
      productsNotifier.value = products;
      // ignore: use_build_context_synchronously
      ArvProgressDialog.instance.dismissDialog(context);
    });
  }

  void safeUpdate() => WidgetsBinding.instance
      .addPostFrameCallback((timeStamp) => setState(() {}));

  @override
  void initState() {
    super.initState();
    page = widget.currentPage;
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight) / 3;
    final double itemWidth = size.width / 2.5;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const Center(
            child: Text(
              "Product Page",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: Row(
          children: [
            widget.isExploreAll
                ? Container(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: lightpink),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 100,
                          height: MediaQuery.of(context).size.height * 0.85,
                          child: FutureBuilder<Categories>(
                            future: arvApi.getAllCategories(),
                            builder: (context, snapshot) {
                              Categories? categories = snapshot.data;
                              if (categories == null) return Container();
                              return ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: categories.list.length,
                                primary: false,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  Category category = categories.list[index];
                                  if (selectedCategory == "") {
                                    selectedCategory = category.id;
                                    getProductsByCategory(
                                      category.id,
                                      widget.subSubCategory,
                                    );
                                  }
                                  return InkWell(
                                    onTap: () {
                                      isDisposed = false;
                                      setState(() {
                                        indexVal = index;
                                        selectedCategory = category.id;
                                        getProductsByCategory(
                                          category.id,
                                          widget.subSubCategory,
                                        );
                                      });
                                    },
                                    child: Container(
                                      color: indexVal == index
                                          ? pink
                                          : Colors.white,
                                      height: 100,
                                      padding: const EdgeInsets.only(
                                          bottom: 20, top: 10),
                                      margin: const EdgeInsets.only(left: 10),
                                      width: 50,
                                      child: Image.network(
                                        arvApi
                                            .getMediaUri(category.image ?? ""),
                                        width: 50,
                                        height: 50,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              color: indexVal == index
                                                  ? pink
                                                  : gray50,
                                            ),
                                            child: Center(
                                              child: Text(
                                                category.name,
                                                style: TextStyle(
                                                  color: indexVal == index
                                                      ? white
                                                      : black,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                : widget.isCategoryPage
                    ? Container(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: lightpink),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 100,
                              height: MediaQuery.of(context).size.height * 0.85,
                              child: FutureBuilder<SubCategories>(
                                future: arvApi.getAllSubCategoriesById(
                                    '${widget.category}'),
                                builder: (context, snapshot) {
                                  SubCategories? subCategories = snapshot.data;
                                  if (subCategories == null) return Container();
                                  return ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: subCategories.list.length,
                                    primary: false,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      SubCategory subCategory =
                                          subCategories.list[index];
                                      if (selectedCategory == "") {
                                        selectedCategory = subCategory.id;
                                        getProductsByCategory(
                                          '${widget.category}',
                                          subCategory.id,
                                        );
                                      }
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            indexVal = index;
                                            isDisposed = false;
                                            selectedCategory = subCategory.id;
                                            getProductsByCategory(
                                              '${widget.category}',
                                              subCategory.id,
                                            );
                                          });
                                        },
                                        child: Container(
                                          color: indexVal == index
                                              ? pink
                                              : Colors.white,
                                          height: 100,
                                          padding: const EdgeInsets.only(
                                              bottom: 20, top: 10),
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          width: 50,
                                          child: Image.network(
                                            arvApi.getMediaUri(
                                                subCategory.image ?? ""),
                                            width: 50,
                                            height: 50,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5)),
                                                  color: indexVal == index
                                                      ? pink
                                                      : gray50,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    subCategory.name,
                                                    style: TextStyle(
                                                      color: indexVal == index
                                                          ? white
                                                          : black,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
            Container(
              width: !(widget.isCategoryPage || widget.isExploreAll)
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width - 120,
              padding: const EdgeInsets.only(top: 10),
              child: ValueListenableBuilder<Products>(
                valueListenable: productsNotifier,
                builder: (context, value, child) {
                  return GridView.count(
                    crossAxisCount:
                        (widget.isCategoryPage || widget.isExploreAll) ? 2 : 3,
                    crossAxisSpacing: 2.0,
                    childAspectRatio: (itemWidth / itemHeight),
                    mainAxisSpacing: 12.0,
                    children: List.generate(
                      value.list.length,
                      (index) => ProductGridCard(product: value.list[index]),
                      growable: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
