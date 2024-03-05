import 'dart:ffi';

import 'package:caculatefeebloc/model/spend.dart';
import 'package:caculatefeebloc/repository/spend_repository.dart';
import 'package:caculatefeebloc/spend/bloc/spend_bloc.dart';
import 'package:caculatefeebloc/spend/spend_item.dart';
import 'package:caculatefeebloc/statitiscal/statistical_page.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:neumorphic_button/neumorphic_button.dart';

class SpendPage extends StatefulWidget {
  const SpendPage({super.key});

  @override
  State<SpendPage> createState() => _SpendPageState();
}

class _SpendPageState extends State<SpendPage> {
  final spendBloc = SpendBloc(SpendRepository());
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spendBloc.add(SpendIntialEvent());
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  final TextEditingController textEditingController = TextEditingController();
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 5), // Độ tương phản của bóng
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: AssetImage("assets/images/nguyen1.jpg"),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Have a gud day! 🌄",
                      style: GoogleFonts.spaceMono(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "VNguyen 🏍 🚗",
                    style: GoogleFonts.spaceMono(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              SizedBox(width: 20),
              OutlinedButton(
                onPressed: () {
                  // Xử lý khi nút được nhấn
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StatisticalPage(spendBloc: spendBloc),
                      ));
                },
                style: OutlinedButton.styleFrom(
                  // backgroundColor: Colors.blue, // Màu chữ và đường viền của nút
                  side:
                      BorderSide(color: Colors.blue), // Màu đường viền của nút
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8.0), // Đặt độ cong của góc
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12), // Đặt kích thước của nút
                ),
                child: Text(
                  'Expense 📊',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          BlocConsumer<SpendBloc, SpendState>(
            bloc: spendBloc,
            listenWhen: (previous, current) => current is SpendActionState,
            buildWhen: (previous, current) => current is! SpendActionState,
            listener: (context, state) {
              switch (state.runtimeType) {
                case SpendUpdatePriceSuccessState:
                  final stateCurrent = state as SpendUpdatePriceSuccessState;
                  // String content = stateCurrent.content;
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(stateCurrent.content)));
                  // homeBloc.add(HomeGetListEvent());
                  spendBloc.add(SpendGetCurrentEvent());
                  break;
                case SpendUpdatePriceErrorState:
                  final stateCurrent = state as SpendUpdatePriceErrorState;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(stateCurrent.content),
                    backgroundColor: Colors.red,
                  ));
                  spendBloc.add(SpendGetCurrentEvent());
                  break;
                default:
              }
            },
            builder: (context, state) {
              // print("haha2");
              switch (state.runtimeType) {
                case SpendLoadingState:
                  // print("haha");
                  return Center(
                    child: Lottie.asset("assets/images/waiting.json"),
                  );
                  break;
                case SpendLoadedSuccessState:
                  // print("haha1");
                  final stateCurrent = state as SpendLoadedSuccessState;
                  return Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2.0,
                                  color: Colors.grey,
                                  offset: Offset(0, 2))
                            ]),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    "Total Income 📉",
                                    style: GoogleFonts.spaceMono(
                                        textStyle: TextStyle(
                                            color: Colors.green[300],
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Text(
                                    "💰 " + state.spend.incomePrice.toString(),
                                    style: GoogleFonts.spaceMono(
                                        textStyle: TextStyle(
                                            color: Colors.green[300],
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 2.0,
                              height: 50,
                              color: Colors.grey,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    "Total Expense 📈",
                                    style: GoogleFonts.spaceMono(
                                        textStyle: TextStyle(
                                            color: Colors.red[300],
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Text(
                                    " 💰 " +
                                        stateCurrent.spend.expensePrice
                                            .toString(),
                                    style: GoogleFonts.spaceMono(
                                        textStyle: TextStyle(
                                            color: Colors.red[300],
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                if (textEditingController.text != "") {
                                  spendBloc.add(AddPriceToSpendIncomeClick(
                                      spendPrice: stateCurrent.spend,
                                      price: int.parse(
                                          textEditingController.text)));
                                  textEditingController.text = "";
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.greenAccent.shade200
                                        .withOpacity(0.7),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.greenAccent.withOpacity(
                                          0.3), // Adjust opacity for desired shadow intensity
                                      offset: Offset(5,
                                          6), // Adjust offset for desired shadow position
                                      blurRadius:
                                          10, // Adjust blurRadius for desired shadow softness
                                    )
                                  ],
                                ),
                                child: Icon(
                                  FontAwesomeIcons.arrowUpLong,
                                  color:
                                      const Color.fromARGB(255, 96, 225, 101),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: 100,
                              height: 60,
                              child: TextField(
                                controller: textEditingController,
                                style: TextStyle(),
                                keyboardType: TextInputType.number,
                                // controller: textEditingController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (textEditingController.text != "") {
                                  spendBloc.add(AddPriceToSpendIncomeClick(
                                      spendPrice: stateCurrent.spend,
                                      price: int.parse(
                                          textEditingController.text)));
                                  textEditingController.text = "";
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.redAccent.shade200
                                        .withOpacity(0.7),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.redAccent.withOpacity(
                                          0.3), // Adjust opacity for desired shadow intensity
                                      offset: Offset(0,
                                          0), // Adjust offset for desired shadow position
                                      blurRadius:
                                          10, // Adjust blurRadius for desired shadow softness
                                    )
                                  ],
                                ),
                                child: Icon(
                                  FontAwesomeIcons.arrowDownLong,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Transacsions 🇻🇳",
                              style: GoogleFonts.spaceMono(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            Text(
                              stateCurrent.spend.dateTime,
                              style: GoogleFonts.spaceMono(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            )
                            // Icon()
                          ],
                        ),
                      ),
                      // personalWidget(),
                      ListView(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SpendItem(
                              name: "Food",
                              price: stateCurrent.spend.foodPrice,
                              color: Colors.amberAccent,
                              icon: FontAwesomeIcons.bowlFood,
                              onPressed: (operation, price) {
                                //1 là cộng
                                //0 là trừ
                                FocusScope.of(context).unfocus();
                                final spendPrice = stateCurrent.spend;
                                int priceCurrent = 0;
                                if (price != 0) {
                                  if (operation == 1) {
                                    priceCurrent = priceCurrent + price;
                                  } else {
                                    priceCurrent = priceCurrent - price;
                                  }
                                  spendPrice.foodPrice =
                                      spendPrice.foodPrice + priceCurrent;
                                  spendBloc.add(AddPriceToSpendClick(
                                      spendPrice: spendPrice,
                                      nameString: "Food",
                                      price: priceCurrent));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Vui lòng nhập số vào!"),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                                // _focusNode.requestFocus();
                              }),
                          SpendItem(
                              name: "Shopping",
                              price: stateCurrent.spend.shoppingPrice,
                              color: Colors.redAccent,
                              icon: FontAwesomeIcons.shoppingBag,
                              onPressed: (operation, price) {
                                //1 là cộng
                                //0 là trừ
                                FocusScope.of(context).unfocus();
                                final spendPrice = stateCurrent.spend;
                                int priceCurrent = 0;
                                if (price != 0) {
                                  if (operation == 1) {
                                    priceCurrent = priceCurrent + price;
                                  } else {
                                    priceCurrent = priceCurrent - price;
                                  }
                                  spendPrice.shoppingPrice =
                                      spendPrice.shoppingPrice + priceCurrent;
                                  spendBloc.add(AddPriceToSpendClick(
                                      spendPrice: spendPrice,
                                      nameString: "Shopping",
                                      price: priceCurrent));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Vui lòng nhập số vào!"),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              }),
                          SpendItem(
                              name: "Going",
                              price: stateCurrent.spend.goingPrice,
                              color: Colors.blueAccent,
                              icon: FontAwesomeIcons.motorcycle,
                              onPressed: (operation, price) {
                                FocusScope.of(context).unfocus();
                                final spendPrice = stateCurrent.spend;
                                int priceCurrent = 0;
                                if (price != 0) {
                                  if (operation == 1) {
                                    priceCurrent = priceCurrent + price;
                                  } else {
                                    priceCurrent = priceCurrent - price;
                                  }
                                  spendPrice.goingPrice =
                                      spendPrice.goingPrice + priceCurrent;
                                  spendBloc.add(AddPriceToSpendClick(
                                      spendPrice: spendPrice,
                                      nameString: "Going",
                                      price: priceCurrent));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Vui lòng nhập số vào!"),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              }),
                          SpendItem(
                              name: "Study",
                              price: stateCurrent.spend.studyPrice,
                              color: Colors.greenAccent,
                              icon: FontAwesomeIcons.graduationCap,
                              onPressed: (operation, price) {
                                FocusScope.of(context).unfocus();
                                final spendPrice = stateCurrent.spend;
                                int priceCurrent = 0;
                                if (price != 0) {
                                  if (operation == 1) {
                                    priceCurrent = priceCurrent + price;
                                  } else {
                                    priceCurrent = priceCurrent - price;
                                  }
                                  spendPrice.studyPrice =
                                      spendPrice.studyPrice + priceCurrent;
                                  spendBloc.add(AddPriceToSpendClick(
                                      spendPrice: spendPrice,
                                      nameString: "Study",
                                      price: priceCurrent));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Vui lòng nhập số vào!"),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              }),
                          SpendItem(
                              name: "Live",
                              price: stateCurrent.spend.livePrice,
                              color: Colors.purpleAccent,
                              icon: FontAwesomeIcons.personBooth,
                              onPressed: (operation, price) {
                                FocusScope.of(context).unfocus();
                                final spendPrice = stateCurrent.spend;
                                int priceCurrent = 0;
                                if (price != 0) {
                                  if (operation == 1) {
                                    priceCurrent = priceCurrent + price;
                                  } else {
                                    priceCurrent = priceCurrent - price;
                                  }
                                  spendPrice.livePrice =
                                      spendPrice.livePrice + priceCurrent;
                                  spendBloc.add(AddPriceToSpendClick(
                                      spendPrice: spendPrice,
                                      nameString: "Live",
                                      price: priceCurrent));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Vui lòng nhập số vào!"),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              }),
                          SpendItem(
                              name: "Love",
                              price: stateCurrent.spend.lovePrice,
                              color: Colors.orange,
                              icon: FontAwesomeIcons.heartCircleBolt,
                              onPressed: (operation, price) {
                                FocusScope.of(context).unfocus();
                                final spendPrice = stateCurrent.spend;
                                int priceCurrent = 0;
                                if (price != 0) {
                                  if (operation == 1) {
                                    priceCurrent = priceCurrent + price;
                                  } else {
                                    priceCurrent = priceCurrent - price;
                                  }
                                  spendPrice.lovePrice =
                                      spendPrice.lovePrice + priceCurrent;
                                  spendBloc.add(AddPriceToSpendClick(
                                      spendPrice: spendPrice,
                                      nameString: "Love",
                                      price: priceCurrent));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Vui lòng nhập số vào!"),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              }),
                        ],
                      ),
                    ],
                  );
                  break;
                case SpendErrorLoadState:
                  return Center(child: Text('Error'));
                default:
                  return Center(child: Text('Làm vậy chi :)'));
              }
            },
          )
        ]),
      ),
    );
  }

  Widget personalWidget() {
    return Container(
      child: Row(children: []),
    );
  }
}
