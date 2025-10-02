// import 'dart:convert';
// import 'dart:developer';
// import 'package:ethnoshop/config/currency_converter.dart';
// import 'package:ethnoshop/config/shared_prefs.dart';
// import 'package:ethnoshop/provider/cart_provider.dart';
// import 'package:ethnoshop/provider/currency_provider.dart';
// import 'package:ethnoshop/screen/auth/login_screen.dart';
// import 'package:ethnoshop/screen/cart/checkout_webview.dart';
// import 'package:ethnoshop/utils/helper/ui_helper.dart';
// import 'package:ethnoshop/utils/my_app_theme.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shopify_flutter/models/src/cart/cart.dart';
// import 'package:shopify_flutter/models/src/cart/inputs/cart_buyer_identity_input/cart_buyer_identity_input.dart';
// import 'package:shopify_flutter/models/src/cart/inputs/cart_input/cart_input.dart';
// import 'package:shopify_flutter/models/src/cart/inputs/cart_line_input/cart_line_input.dart';
// import 'package:shopify_flutter/models/src/shopify_user/address/address.dart';
// import 'package:shopify_flutter/shopify/src/shopify_cart.dart';
//
// class CartScreen extends StatefulWidget {
//   final bool bottom;
//
//   const CartScreen({super.key, required this.bottom});
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   List cartList = [];
//   String? cartId;
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     getCartId();
//     super.initState();
//   }
//
//   getCartId() async {
//     final email = await SharedPrefs.getEmail();
//     if (email.isNotEmpty) {
//       Map<String, String>? retrievedEntry =
//       await SharedPrefs().getEntryByEmail(email.trim());
//
//       if (retrievedEntry != null) {
//         setState(() => cartId = retrievedEntry['id']);
//         fetchCartDetails(cartId!);
//       } else {
//         await SharedPrefs.getCartId().then((value) {
//           setState(() => cartId = value);
//           fetchCartDetails(cartId!);
//         });
//       }
//     } else {
//       await SharedPrefs.getCartId().then((value) {
//         setState(() => cartId = value);
//         fetchCartDetails(cartId!);
//       });
//     }
//   }
//
//   Future<void> fetchCartDetails(String cartId) async {
//     _isLoading = true;
//     setState(() {});
//     try {
//       final ShopifyCart shopifyCart = ShopifyCart.instance;
//       final cart = await shopifyCart.getCartById(cartId);
//       cartList = cart.lines.map((line) => line.toJson()).toList();
//     } catch (e) {
//       log("Fetch Cart Error: $e");
//     }
//     _isLoading = false;
//     setState(() {});
//   }
//
//   Future<void> testCheckoutProcess() async {
//     final ShopifyCart shopifyCart = ShopifyCart.instance;
//     final email = await SharedPrefs.getEmail();
//     final password = await SharedPrefs.getPassword();
//
//     _showLoadingDialog(context);
//
//     try {
//       // Serialize cart lines
//       final List<CartLineInput> lines = cartList.map((cartItem) {
//         return CartLineInput(
//           merchandiseId: cartItem['node']['merchandise']['id'],
//           quantity: cartItem['node']['quantity'],
//         );
//       }).toList();
//
//       // If cart exists, get it; else create a new cart
//       Cart? cart;
//       if (cartId != null) {
//         cart = await shopifyCart.getCartById(cartId!);
//         cart = await shopifyCart.addLineItemsToCart(
//             cartId: cart.id, cartLineInputs: lines);
//       } else {
//         final cartInput = CartInput(
//           buyerIdentity: CartBuyerIdentityInput(email: email),
//           lines: lines,
//         );
//         cart = await shopifyCart.createCart(cartInput);
//         cartId = cart.id;
//         await SharedPrefs().setCartId(cartId!);
//       }
//
//       // Update buyer identity (optional)
//       await shopifyCart.updateBuyerIdentityInCart(
//         cartId: cart.id,
//         buyerIdentity: CartBuyerIdentityInput(
//           email: email,
//           firstName: 'Demo',
//           lastName: 'User',
//           phone: '1234567890',
//         ),
//       );
//
//       // Navigate to WebView checkout
//       if (!mounted) return;
//       Navigator.of(context).pop();
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => WebViewCheckout(checkoutUrl: cart.checkoutUrl),
//         ),
//       );
//     } catch (e, stackTrace) {
//       log('Checkout Error: $e');
//       log('Stack Trace: $stackTrace');
//       if (mounted) {
//         Navigator.of(context).pop();
//         ScaffoldMessenger.of(context)
//           ..clearSnackBars()
//           ..showSnackBar(SnackBar(content: Text('Error: $e')));
//       }
//     }
//   }
//
//   Future<double> calculateTotalPrice(BuildContext context) async {
//     double total = 0.0;
//     for (var i = 0; i < cartList.length; i++) {
//       double price = double.parse(cartList[i]['node']['merchandise']['priceV2']['amount']);
//       int quantity = cartList[i]['node']['quantity'];
//
//       double convertedPrice = await CurrencyHelper.currencyConverter(
//           price, Provider.of<CurrencyProvider>(context, listen: false).selectedCurrency);
//
//       total += convertedPrice * quantity;
//     }
//     return total;
//   }
//
//   void _showLoadingDialog(BuildContext context) {
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (_) => const Dialog(
//         backgroundColor: Colors.white,
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CircularProgressIndicator(color: Colors.green),
//               SizedBox(height: 10),
//               Text('Please wait...')
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60.h),
//         child: AppBar(
//           centerTitle: true,
//           leading: widget.bottom
//               ? Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: GestureDetector(
//               onTap: () => Navigator.of(context).pop(),
//               child: Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.r),
//                     color: const Color(0xFF318D6E)),
//                 child: Padding(
//                   padding: EdgeInsets.all(8.w),
//                   child: const Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           )
//               : const SizedBox(),
//           title: Text('Cart',
//               style: GoogleFonts.poppins(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600)),
//           flexibleSpace: const Image(
//               image: AssetImage('assets/images/appbar.png'), fit: BoxFit.cover),
//           backgroundColor: Colors.transparent,
//         ),
//       ),
//       bottomNavigationBar: (cartList.isNotEmpty)
//           ? Container(
//         color: MyAppTheme.mainColor,
//         child: Padding(
//           padding: EdgeInsets.all(12.w),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Total',
//                       style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400)),
//                   Consumer<CurrencyProvider>(
//                     builder: (context, currencyProvider, child) {
//                       return FutureBuilder<double>(
//                         future: calculateTotalPrice(context),
//                         builder: (context, snapshot) {
//                           if (snapshot.hasData) {
//                             return Text(
//                                 '${snapshot.data?.toStringAsFixed(2)} ${currencyProvider.selectedCurrencySymbol}',
//                                 style: GoogleFonts.poppins(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600));
//                           } else {
//                             return Text(
//                               'Calculating... ${currencyProvider.selectedCurrencySymbol}',
//                               style: GoogleFonts.poppins(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400),
//                             );
//                           }
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//               GestureDetector(
//                 onTap: () async {
//                   final token = await SharedPrefs.getAccessToken();
//                   if (token.isEmpty) {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (_) => const LogInScreen()));
//                   } else {
//                     testCheckoutProcess();
//                   }
//                 },
//                 child: Container(
//                   height: 50,
//                   width: 150.w,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: const Color(0xFFEECCB1)),
//                   child: Center(
//                     child: Text('Check Out',
//                         style: GoogleFonts.poppins(
//                             color: const Color(0XffA26031),
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//           : null,
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : cartList.isNotEmpty
//           ? ListView.builder(
//         itemCount: cartList.length,
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           final item = cartList[index]['node'];
//           return Padding(
//             padding: EdgeInsets.all(10.w),
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(10.0)),
//               child: Padding(
//                 padding: EdgeInsets.all(8.w),
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 100.w,
//                       height: 100.h,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: item["merchandise"]["product"]
//                         ["images"]["edges"]
//                             .length >
//                             0
//                             ? Image.network(
//                           item["merchandise"]["product"]["images"]
//                           ["edges"][0]["node"]["originalSrc"],
//                           fit: BoxFit.cover,
//                         )
//                             : Image.asset("assets/images/dryNuts.png"),
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: EdgeInsets.all(8.w),
//                         child: Column(
//                           crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                           children: [
//                             Text(item["merchandise"]["product"]["title"],
//                                 style: GoogleFonts.poppins(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 15)),
//                             Text(item["merchandise"]["title"],
//                                 style: GoogleFonts.poppins(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 14)),
//                             Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Consumer<CurrencyProvider>(
//                                     builder: (context, provider, child) {
//                                       return FutureBuilder<double>(
//                                         future: CurrencyHelper.currencyConverter(
//                                             double.parse(item["merchandise"]
//                                             ["priceV2"]["amount"]),
//                                             provider.selectedCurrency),
//                                         builder: (context, snapshot) {
//                                           final priceText = snapshot.hasData
//                                               ? '${snapshot.data} ${provider.selectedCurrencySymbol}'
//                                               : '${item["merchandise"]["priceV2"]["amount"]} ${item["merchandise"]["priceV2"]["currencyCode"]}';
//                                           return Text(priceText,
//                                               style: GoogleFonts.poppins(
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.w400));
//                                         },
//                                       );
//                                     }),
//                                 Row(
//                                   children: [
//                                     GestureDetector(
//                                         onTap: () {
//                                           if (item["quantity"] > 1) {
//                                             item["quantity"]--;
//                                             setState(() {});
//                                           }
//                                         },
//                                         child: const Icon(CupertinoIcons.minus_circle)),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                                       child: Text(item["quantity"].toString()),
//                                     ),
//                                     GestureDetector(
//                                         onTap: () {
//                                           if (item["quantity"] <
//                                               item["merchandise"]
//                                               ["quantityAvailable"]) {
//                                             item["quantity"]++;
//                                             setState(() {});
//                                           }
//                                         },
//                                         child: const Icon(CupertinoIcons.add_circled)),
//                                   ],
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       )
//           : const Center(child: Text('Your cart is empty')),
//     );
//   }
// }
