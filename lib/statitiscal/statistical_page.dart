import 'package:d_chart/d_chart.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class StatisticalPage extends StatefulWidget {
  const StatisticalPage({super.key});

  @override
  State<StatisticalPage> createState() => _StatisticalPageState();
}

class _StatisticalPageState extends State<StatisticalPage> {
  List<double> data = [
    10.0,
    20.0,
    30.0,
    40.0,
    50.0,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 60,
          ),
          Center(
            child: Text("Balance",
                style: GoogleFonts.spaceMono(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Income: \$ 1231",
                  style: GoogleFonts.spaceMono(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent),
                ),
                Text(
                  "Expense: \$ 1231",
                  style: GoogleFonts.spaceMono(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent),
                )
              ],
            ),
            Container(
              width: 200,
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 30,
                      titleStyle: GoogleFonts.spaceMono(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      color: Colors.redAccent,
                      title: '30%',
                      radius: 80,
                    ),
                    PieChartSectionData(
                      value: 40,
                      titleStyle: GoogleFonts.spaceMono(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      color: Colors.greenAccent,
                      title: '40%',
                      radius: 80,
                    ),
                  ],
                ),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Statistical Month 🇻🇳",
                  style: GoogleFonts.spaceMono(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
                // Text(
                //   "12/12",
                //   style: GoogleFonts.spaceMono(
                //       fontSize: 15, fontWeight: FontWeight.w600),
                // )
                // Icon()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ExpansionTileCard(
              baseColor: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
              title: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "3/2024",
                      style: GoogleFonts.spaceMono(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Income: \$1231",
                              style: GoogleFonts.spaceMono(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.greenAccent),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Expense: \$1231",
                              style: GoogleFonts.spaceMono(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent),
                            )
                          ],
                        ),
                        Container(
                          width: 145,
                          height: 50,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                                child: DChartSingleBar(
                                  // forgroundColor: ,
                                  value: 80,
                                  ltr: true,
                                  radius: BorderRadius.circular(20),
                                  max: 100, foregroundColor: Colors.greenAccent,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 20,
                                child: DChartSingleBar(
                                  // forgroundColor: ,
                                  value: 20,
                                  ltr: false,
                                  radius: BorderRadius.circular(20),
                                  max: 100, foregroundColor: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Detail Chart",
                        style: GoogleFonts.spaceMono(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 25, horizontal: 5),
                        width: 400,
                        height: 300,
                        child: DChartBarCustom(
                          loadingDuration: const Duration(milliseconds: 500),
                          showLoading: true,
                          showDomainLine: true,
                          showDomainLabel: true,
                          showMeasureLine: true,
                          showMeasureLabel: true,
                          domainLineStyle:
                              BorderSide(width: 1, color: Colors.black54),
                          domainLabelStyle: GoogleFonts.spaceMono(),
                          spaceMeasureLabeltoChart: 5,
                          spaceMeasureLinetoChart: 5,
                          radiusBar: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          listData: [
                            DChartBarDataCustom(
                                value: 2323,
                                label: 'Food',
                                color: Colors.redAccent,
                                showValue: true,
                                valueStyle:
                                    GoogleFonts.spaceMono(color: Colors.white)
                                // elevation: 12,
                                // valueCustom: Text("haha")
                                ),
                            DChartBarDataCustom(
                                value: 300,
                                label: 'Going',
                                color: Colors.amberAccent,
                                showValue: true,
                                valueStyle:
                                    GoogleFonts.spaceMono(color: Colors.white)),
                            DChartBarDataCustom(
                                value: 400,
                                label: 'Study',
                                color: Colors.cyanAccent,
                                showValue: true,
                                valueStyle:
                                    GoogleFonts.spaceMono(color: Colors.white)),
                            DChartBarDataCustom(
                                value: 221,
                                label: 'Life',
                                color: Colors.blueAccent,
                                showValue: true,
                                valueStyle:
                                    GoogleFonts.spaceMono(color: Colors.white)),
                            DChartBarDataCustom(
                                value: 721,
                                label: 'Shopping',
                                color: Colors.deepOrange,
                                showValue: true,
                                valueStyle:
                                    GoogleFonts.spaceMono(color: Colors.white)),
                            DChartBarDataCustom(
                                value: 221,
                                label: 'Love',
                                color: Colors.pinkAccent,
                                showValue: true,
                                valueStyle:
                                    GoogleFonts.spaceMono(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}


  // DChartBarO(
  //                         animate: true,
  //                         animationDuration: Duration(seconds: 1),
  //                         vertical: true,
  //                         allowSliding: true,
  //                         groupList: [
  //                           OrdinalGroup(
  //                               id: "id",
  //                               data: [
  //                                 OrdinalData(
  //                                     domain: 'Food',
  //                                     measure: 1233,
  //                                     color: Colors.amberAccent),
  //                                 OrdinalData(
  //                                     domain: 'Going',
  //                                     measure: 223,
  //                                     color: Colors.redAccent),
  //                                 OrdinalData(
  //                                     domain: 'Love',
  //                                     measure: 233,
  //                                     color: Colors.blueAccent),
  //                                 OrdinalData(
  //                                     domain: 'Life',
  //                                     measure: 233,
  //                                     color: Colors.purple),
  //                                 OrdinalData(
  //                                     domain: 'Study',
  //                                     measure: 233,
  //                                     color: Colors.cyanAccent),
  //                                 OrdinalData(
  //                                     domain: 'Shopping',
  //                                     measure: 233,
  //                                     color: Colors.indigoAccent),
  //                               ],
  //                               chartType: ChartType.bar,
  //                               color: Colors.amber)
  //                         ],
  //                       ),