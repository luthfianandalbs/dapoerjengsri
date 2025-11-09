// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dapoerjengsri/pages/details.dart';
// import 'package:dapoerjengsri/widget/databaseFirebase.dart';
// import 'package:dapoerjengsri/widget/shared_pref.dart';
// import 'package:dapoerjengsri/widget/widget_support.dart';
// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   bool food = false, drink = false, sidedish = false;

//   Stream? fooditemStream;
//   String userName = "";

//   ontheLoad() async {
//     fooditemStream = await DatabaseMethods().getFoodItem("Food");
//     setState(() {});
//   }

//   Future<void> getUserName() async {
//     // Retrieve the user name from shared preferences
//     String? name = await SharedPreferenceHelper().getUserName();
//     setState(() {
//       userName = name ?? ""; // Set userName to the retrieved value
//     });
//   }

//   @override
//   void initState() {
//     ontheLoad();
//     getUserName();
//     super.initState();
//   }

//   Widget allItemsVertically() {
//     return StreamBuilder(
//         stream: fooditemStream,
//         builder: (context, AsyncSnapshot snapshot) {
//           return snapshot.hasData
//               ? ListView.builder(
//                   padding: EdgeInsets.zero,
//                   itemCount: snapshot.data.docs.length,
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     DocumentSnapshot ds = snapshot.data.docs[index];
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Details(
//                                       detail: ds["Detail"],
//                                       name: ds["Name"],
//                                       image: ds["Image"],
//                                       price: ds["Price"],
//                                     )));
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.all(5),
//                         child: Material(
//                           elevation: 5,
//                           borderRadius: BorderRadius.circular(20),
//                           child: Container(
//                             padding: const EdgeInsets.all(14),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(20),
//                                   child: Image.network(
//                                     ds["Image"],
//                                     height: 150,
//                                     width: 150,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   ds["Name"],
//                                   style: AppWidget.semiBoldTextFieldStyle(),
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   ds["Detail"],
//                                   style: AppWidget.LightTextFieldStyle(),
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   "\Rp" + ds["Price"],
//                                   style: AppWidget.semiBoldTextFieldStyle(),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   })
//               : CircularProgressIndicator();
//         });
//   }

//   Widget allItems() {
//     return StreamBuilder(
//         stream: fooditemStream,
//         builder: (context, AsyncSnapshot snapshot) {
//           return snapshot.hasData
//               ? ListView.builder(
//                   padding: EdgeInsets.zero,
//                   itemCount: snapshot.data.docs.length,
//                   shrinkWrap: true,
//                   scrollDirection: Axis.vertical,
//                   itemBuilder: (context, index) {
//                     DocumentSnapshot ds = snapshot.data.docs[index];
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Details(
//                                       detail: ds["Detail"],
//                                       name: ds["Name"],
//                                       image: ds["Image"],
//                                       price: ds["Price"],
//                                     )));
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.only(
//                             right: 20, bottom: 10, top: 10),
//                         child: Material(
//                           elevation: 5,
//                           borderRadius: BorderRadius.circular(20),
//                           child: Container(
//                             padding: const EdgeInsets.all(13),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(20),
//                                   child: Image.network(
//                                     ds["Image"],
//                                     height: 120,
//                                     width: 120,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 15,
//                                 ),
//                                 Column(
//                                   children: [
//                                     SizedBox(
//                                       width:
//                                           MediaQuery.of(context).size.width / 2,
//                                       child: Text(
//                                         ds["Name"],
//                                         style:
//                                             AppWidget.semiBoldTextFieldStyle(),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     SizedBox(
//                                       width:
//                                           MediaQuery.of(context).size.width / 2,
//                                       child: Text(
//                                         ds["Detail"],
//                                         style: AppWidget.LightTextFieldStyle(),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     SizedBox(
//                                       width:
//                                           MediaQuery.of(context).size.width / 2,
//                                       child: Text(
//                                         "\Rp" + ds["Price"],
//                                         style:
//                                             AppWidget.semiBoldTextFieldStyle(),
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   })
//               : CircularProgressIndicator();
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Container(
//             margin: const EdgeInsets.only(top: 50, left: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Hello " + userName,
//                         style: AppWidget.boldTextFieldStyle()),
//                     Container(
//                       margin: const EdgeInsets.only(right: 20),
//                       padding: const EdgeInsets.all(3),
//                       decoration: BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.circular(8)),
//                       child: const Icon(
//                         Icons.shopping_cart,
//                         color: Colors.white,
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Text("Delicious Food", style: AppWidget.HeadTextFieldStyle()),
//                 Text("Discover and Get Great Foods",
//                     style: AppWidget.LightTextFieldStyle()),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                     margin: const EdgeInsets.only(right: 20),
//                     child: showItem()),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Text(
//                   "Best Seller",
//                   style: AppWidget.boldTextFieldStyle(),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Container(height: 300, child: allItemsVertically()),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 Text(
//                   "All Foods Available",
//                   style: AppWidget.boldTextFieldStyle(),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 allItems()
//               ],
//             )),
//       ),
//     );
//   }

//   Widget showItem() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         GestureDetector(
//           onTap: () async {
//             food = true;
//             drink = false;
//             sidedish = false;
//             fooditemStream = await DatabaseMethods().getFoodItem("Food");
//             setState(() {});
//           },
//           child: Material(
//               elevation: 5.0,
//               borderRadius: BorderRadius.circular(10),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: food ? Colors.black : Colors.white,
//                     borderRadius: BorderRadius.circular(10)),
//                 padding: const EdgeInsets.all(10),
//                 child: Image.asset(
//                   "images/food.png",
//                   height: 40,
//                   width: 40,
//                   fit: BoxFit.cover,
//                   color: food ? Colors.white : Colors.black,
//                 ),
//               )),
//         ),
//         GestureDetector(
//           onTap: () async {
//             food = false;
//             drink = true;
//             sidedish = false;
//             fooditemStream = await DatabaseMethods().getFoodItem("Drink");
//             setState(() {});
//           },
//           child: Material(
//               elevation: 5.0,
//               borderRadius: BorderRadius.circular(10),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: drink ? Colors.black : Colors.white,
//                     borderRadius: BorderRadius.circular(10)),
//                 padding: const EdgeInsets.all(10),
//                 child: Image.asset(
//                   "images/drink.png",
//                   height: 40,
//                   width: 40,
//                   fit: BoxFit.cover,
//                   color: drink ? Colors.white : Colors.black,
//                 ),
//               )),
//         ),
//         GestureDetector(
//           onTap: () async {
//             food = false;
//             drink = false;
//             sidedish = true;
//             fooditemStream = await DatabaseMethods().getFoodItem("SideDish");
//             setState(() {});
//           },
//           child: Material(
//               elevation: 5.0,
//               borderRadius: BorderRadius.circular(10),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: sidedish ? Colors.black : Colors.white,
//                     borderRadius: BorderRadius.circular(10)),
//                 padding: const EdgeInsets.all(10),
//                 child: Image.asset(
//                   "images/sidedish.png",
//                   height: 40,
//                   width: 40,
//                   fit: BoxFit.cover,
//                   color: sidedish ? Colors.white : Colors.black,
//                 ),
//               )),
//         ),
//       ],
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dapoerjengsri/pages/details.dart';
import 'package:dapoerjengsri/widget/databaseFirebase.dart';
import 'package:dapoerjengsri/widget/shared_pref.dart';
import 'package:dapoerjengsri/widget/widget_support.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool food = false, drink = false, sidedish = false;

  Stream? fooditemStream;
  String userName = "";

  ontheLoad() async {
    fooditemStream = await DatabaseMethods().getFoodItem("Food");
    setState(() {});
  }

  Future<void> getUserName() async {
    String? name = await SharedPreferenceHelper().getUserName();
    setState(() {
      userName = name ?? "";
    });
  }

  Future<void> logCategorySelection(String category) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'select_category',
      parameters: {'category': category},
    );
  }

  Future<void> logItemTap(String itemName) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'tap_item',
      parameters: {'item_name': itemName},
    );
  }

  @override
  void initState() {
    ontheLoad();
    getUserName();
    super.initState();
  }

  Widget allItems() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                      detail: ds["Detail"],
                                      name: ds["Name"],
                                      image: ds["Image"],
                                      price: ds["Price"],
                                    )));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 20, bottom: 10, top: 10),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(13),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    ds["Image"],
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        ds["Name"],
                                        style:
                                            AppWidget.semiBoldTextFieldStyle(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        ds["Detail"],
                                        style: AppWidget.LightTextFieldStyle(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        "\Rp" + ds["Price"],
                                        style:
                                            AppWidget.semiBoldTextFieldStyle(),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        });
  }

  Widget allItemsVertically() {
    return StreamBuilder(
      stream: fooditemStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      logItemTap(ds["Name"]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(
                            detail: ds["Detail"],
                            name: ds["Name"],
                            image: ds["Image"],
                            price: ds["Price"],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  ds["Image"],
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(ds["Name"],
                                  style: AppWidget.semiBoldTextFieldStyle()),
                              const SizedBox(height: 5),
                              Text(ds["Detail"],
                                  style: AppWidget.LightTextFieldStyle()),
                              const SizedBox(height: 5),
                              Text("\Rp" + ds["Price"],
                                  style: AppWidget.semiBoldTextFieldStyle())
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.only(top: 50, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hello " + userName,
                      style: AppWidget.boldTextFieldStyle()),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.shopping_cart, color: Colors.white),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Text("Delicious Food", style: AppWidget.HeadTextFieldStyle()),
              Text("Discover and Get Great Foods",
                  style: AppWidget.LightTextFieldStyle()),
              const SizedBox(height: 20),
              Container(
                  margin: const EdgeInsets.only(right: 20), child: showItem()),
              const SizedBox(height: 15),
              Text("Best Seller", style: AppWidget.boldTextFieldStyle()),
              const SizedBox(height: 10),
              Container(height: 300, child: allItemsVertically()),
              const SizedBox(height: 16),
              Text("All Foods Available",
                  style: AppWidget.boldTextFieldStyle()),
              const SizedBox(height: 10),
              allItems(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () async {
            food = true;
            drink = false;
            sidedish = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Food");
            setState(() {});
          },
          child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                    color: food ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  "images/food.png",
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                  color: food ? Colors.white : Colors.black,
                ),
              )),
        ),
        GestureDetector(
          onTap: () async {
            food = false;
            drink = true;
            sidedish = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Drink");
            setState(() {});
          },
          child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                    color: drink ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  "images/drink.png",
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                  color: drink ? Colors.white : Colors.black,
                ),
              )),
        ),
        GestureDetector(
          onTap: () async {
            food = false;
            drink = false;
            sidedish = true;
            fooditemStream = await DatabaseMethods().getFoodItem("SideDish");
            setState(() {});
          },
          child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                    color: sidedish ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  "images/sidedish.png",
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                  color: sidedish ? Colors.white : Colors.black,
                ),
              )),
        ),
      ],
    );
  }
}
