import 'package:arv/models/response_models/categories.dart';
import 'package:arv/models/response_models/products.dart';
import 'package:arv/models/response_models/sub_categories.dart';
import 'package:arv/shared/cart_service.dart';
import 'package:arv/utils/app_colors.dart';
import 'package:arv/utils/arv_api.dart';
import 'package:arv/utils/custom_progress_bar.dart';
import 'package:arv/views/product_page/product_grid_card.dart';
import 'package:arv/views/product_page/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../shared/navigation_service.dart';

class ProductsPage extends StatefulWidget {
  final bool isExploreAll;
  final bool isCategoryPage;
  final String? category;
  final String? subSubCategory;
  final int currentPage;

  const ProductsPage(
    this.isExploreAll,
    this.isCategoryPage,
    this.currentPage,
    this.category,
    this.subSubCategory, {
    super.key,
  });

  @override
  State createState() => _ProductsPageState();
}

int count = 0;

class _ProductsPageState extends State<ProductsPage> {
  bool isDisposed = false;
  int page = 0;
  Category? category;
  int selectedIndex = 0;
  int indexVal = 0;
  String selectedCategory = "";
  Products products = Products(
    list: [],
    currentPage: 0,
    totalCount: 0,
    totalPages: 0,
  );

  final PagingController<int, ProductDto> _pagingController =
      PagingController(firstPageKey: 0);
  ValueNotifier<Products> productsNotifier = ValueNotifier(Products(
    list: [],
    currentPage: 0,
    totalCount: 0,
    totalPages: 0,
  ));

  getProductsByCategory(
      String majorCategory, String categoryId, String? subCategory) async {
    if (isDisposed) return;
    ArvProgressDialog.instance.showProgressDialog(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      products = await arvApi.getAllProducts(
        page,
        majorCategory,
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
    _pagingController.addPageRequestListener((pageKey) {
      fetchApiCall(
        pageKey,
        "",
        widget.category,
        widget.subSubCategory,
      );
    });
  }

  static const _pageSize = 100;

  Future<void> fetchApiCall(
    int pageKey,
    String? majorCategory,
    String? categoryId,
    String? subCategoryId,
  ) async {
    try {
      final Products articles;
      articles = await Provider.of<NewsProvider>(context, listen: false)
          .fetchNews(pageKey, majorCategory, categoryId, subCategoryId);
      final isLastPage = articles.list.length < 15;
      print("fdfdf");
      print(articles.list.length);
      if (isLastPage) {
        _pagingController.appendLastPage(articles.list);
      } else {
        _pagingController.appendPage(articles.list, pageKey + 1);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    _pagingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    count = (widget.isCategoryPage || widget.isExploreAll) ? 2 : 3;
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
                                   category = categories.list[index];

                                  if (selectedCategory == "") {
                                    selectedCategory = category!.id;
                                    getProductsByCategory(
                                      category!.majorCategory,
                                      category!.id,
                                      widget.subSubCategory,
                                    );
                                    if (_pagingController.itemList != null) {
                                      _pagingController.itemList!.clear();
                                    }
                                    fetchApiCall(
                                      0,
                                      category!.majorCategory,
                                      category!.id,
                                      widget.subSubCategory,
                                    );
                                  }
                                  return InkWell(
                                    onTap: () {
                                      isDisposed = false;
                                      setState(() {
                                        indexVal = index;
                                        selectedCategory = category!.id;
                                        getProductsByCategory(
                                          category!.majorCategory,
                                          category!.id,
                                          widget.subSubCategory,
                                        );
                                        if (_pagingController.itemList !=
                                            null) {
                                          _pagingController.itemList!.clear();
                                        }
                                        fetchApiCall(
                                          0,
                                          category!.majorCategory,
                                          category!.id,
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
                                            .getMediaUri(category!.image ?? ""),
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
                                                category!.name,
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
                                          subCategory.majorCategory,
                                          '${widget.category}',
                                          subCategory.id,
                                        );
                                        if (_pagingController.itemList !=
                                            null) {
                                          _pagingController.itemList!.clear();
                                        }

                                        fetchApiCall(
                                          0,
                                          subCategory.majorCategory,
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
                                              subCategory.majorCategory,
                                              '${widget.category}',
                                              subCategory.id,
                                            );
                                            if (_pagingController.itemList !=
                                                null) {
                                              _pagingController.itemList!
                                                  .clear();
                                            }
                                            fetchApiCall(
                                              0,
                                              subCategory.majorCategory,
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
            // Container(
            //   width: !(widget.isCategoryPage || widget.isExploreAll)
            //       ? MediaQuery.of(context).size.width
            //       : MediaQuery.of(context).size.width - 120,
            //   padding: const EdgeInsets.only(top: 10),
            //   child: ValueListenableBuilder<Products>(
            //     valueListenable: productsNotifier,
            //     builder: (context, value, child) {
            //       return GridView.count(
            //         crossAxisCount:
            //             (widget.isCategoryPage || widget.isExploreAll) ? 2 : 3,
            //         crossAxisSpacing: 6.0,
            //         childAspectRatio: (itemWidth / itemHeight),
            //         mainAxisSpacing: 8.0,
            //         children: List.generate(
            //           value.list.length,
            //           (index) => ProductGridCard(product: value.list[index]),
            //           growable: true,
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Container(
              width: !(widget.isCategoryPage || widget.isExploreAll)
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width - 120,
              padding: const EdgeInsets.only(top: 10),
              child: PagedGridView<int, ProductDto>(
                showNewPageProgressIndicatorAsGridChild: false,
                showNewPageErrorIndicatorAsGridChild: false,
                showNoMoreItemsIndicatorAsGridChild: false,
                pagingController: _pagingController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: (itemWidth / itemHeight),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: count,
                ),
                builderDelegate: PagedChildBuilderDelegate<ProductDto>(
                  itemBuilder: (context, value, index) => ProductGridCard(
                    product: value,
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Stack(children: [
          FloatingActionButton(
            heroTag: null,
            backgroundColor: pink,
            onPressed: () => {
              Navigator.pop(context),
              navigationService.setNavigation = 4,
            },
            child: SvgPicture.asset(
              "assets/images/bag.svg",
              semanticsLabel: 'Acme Logo',
              color: Colors.white,
              width: 28,
              height: 28,
            ),
          ),
          Positioned(
            top: 0,
            left: 30,
            child: GetBuilder<CartService>(
              init: Get.find<CartService>(),
              builder: (controller) {
                if (controller.items.length == 0) {
                  return Container();
                }
                return Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25), // border color
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2), // border width
                    child: Container(
                      // or ClipRRect if you need to clip the content
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor, // inner circle color
                      ),
                      child: Center(
                        child: Text(
                          "${controller.items.length}",
                          style: TextStyle(
                            fontSize: 12,
                            color: white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ), // inner content
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
