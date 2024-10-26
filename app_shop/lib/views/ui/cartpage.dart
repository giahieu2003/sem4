import 'package:app_shop/controllers/cart_provider.dart';
import 'package:app_shop/models/cart/get_products.dart';
import 'package:app_shop/services/cart_helper.dart';
import 'package:app_shop/views/shared/appstyle.dart';
import 'package:app_shop/views/shared/checkout_btn.dart';
import 'package:app_shop/views/shared/reuseable_text.dart';
import 'package:app_shop/views/ui/mainscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<dynamic> cart = [];

  late Future<List<Product>> _cartList;

  @override
  void initState() {
    _cartList = CartHelper().getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    AntDesign.close,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "My Cart",
                  style: appstyle(36, Colors.black, FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: FutureBuilder(
                      future: _cartList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: ReusableText(
                                  text: "Failed to get cart data",
                                  style: appstyle(
                                      18, Colors.black, FontWeight.w600)));
                        } else {
                          final cartData = snapshot.data;
                          return ListView.builder(
                              itemCount: cartData!.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                final data = cartData[index];
                                return GestureDetector(
                                  onTap: () {
                                    cartProvider.setProductIndex = index;
                                    cartProvider.checkout.insert(0, data);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.14,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade500,
                                                  spreadRadius: 5,
                                                  blurRadius: 0.3,
                                                  offset: const Offset(0, 1)),
                                            ]),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl: data.cartItem
                                                            .imageUrl[0],
                                                        width: 70,
                                                        height: 70,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    Positioned(
                                                        top: -2,
                                                        left: -8,
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            
                                                          },
                                                          child: SizedBox(
                                                            height: 30.h,
                                                            width: 30.w,
                                                            child: Icon(
                                                              cartProvider.productIndex == index ? Feather.check_square : Feather.square,
                                                              size: 15,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        )),
                                                    Positioned(
                                                        bottom: -2,
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            await CartHelper()
                                                                .deleteItem(
                                                                    data.id)
                                                                .then(
                                                                    (response) {
                                                              if (response ==
                                                                  true) {
                                                                Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const MainScreen()));
                                                              } else {
                                                                debugPrint(
                                                                    "failed to delete the item");
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 25,
                                                            height: 25,
                                                            decoration: const BoxDecoration(
                                                                color: Colors
                                                                    .black,
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            12))),
                                                            child: const Icon(
                                                              AntDesign.delete,
                                                              size: 15,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, left: 15),
                                                  child: Column(
                                                    // mainAxisAlignment:
                                                    //     MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data.cartItem.name,
                                                        style: appstyle(
                                                            15,
                                                            Colors.black,
                                                            FontWeight.bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        data.cartItem.category,
                                                        style: appstyle(
                                                            12,
                                                            Colors.grey,
                                                            FontWeight.w600),
                                                      ),
                                                      const SizedBox(
                                                        height: 3,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "\$${data.cartItem.price}",
                                                            style: appstyle(
                                                                16,
                                                                Colors.black,
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                          const SizedBox(
                                                            width: 40,
                                                          ),
                                                          // Text(
                                                          //   "Size   ${data['sizes']}",
                                                          //   style: appstyle(
                                                          //       16,
                                                          //       Colors.grey,
                                                          //       FontWeight.w600),
                                                          // ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    16))),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              cartProvider
                                                                  .decrement();
                                                            },
                                                            child: const Icon(
                                                              AntDesign
                                                                  .minussquare,
                                                              size: 20,
                                                              color:
                                                                  Colors.grey,
                                                            )),
                                                        Text(
                                                          // data['qty'].toString(),
                                                          cartProvider.counter
                                                              .toString(),
                                                          style: appstyle(
                                                            16,
                                                            Colors.black,
                                                            FontWeight.w600,
                                                          ),
                                                        ),
                                                        InkWell(
                                                            onTap: () {
                                                              cartProvider
                                                                  .increment();
                                                            },
                                                            child: const Icon(
                                                              AntDesign
                                                                  .plussquare,
                                                              size: 20,
                                                              color:
                                                                  Colors.black,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                      }),
                )
              ],
            ),
            cartProvider.checkout.isNotEmpty
                ? const Align(
                    alignment: Alignment.bottomCenter,
                    child: CheckoutButton(label: "Proceed to Checkout"),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
