import 'dart:ffi';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SpendItem extends StatelessWidget {
  final String name;
  final int price;
  final Color color;
  final IconData icon;
  final void Function(int, int) onPressed;

  const SpendItem(
      {super.key,
      required this.name,
      required this.price,
      required this.color,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ExpansionTileCard(
        elevation: 20,
        shadowColor: Colors.black,
        borderRadius: BorderRadius.circular(10),
        baseColor: Colors.grey[100],
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: color,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(
                              0.2), // Adjust opacity for desired shadow intensity
                          offset: Offset(0,
                              0), // Adjust offset for desired shadow position
                          blurRadius:
                              10, // Adjust blurRadius for desired shadow softness
                        )
                      ],
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style:
                            GoogleFonts.spaceMono(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "12-12-2024 12:12:12",
                        style: GoogleFonts.spaceMono(
                            color: Colors.black54, fontSize: 12),
                      )
                    ],
                  ),
                ],
              ),
              Text(
                "- \$ " + price.toString(),
                style: GoogleFonts.spaceMono(
                    fontWeight: FontWeight.bold, color: Colors.redAccent),
              )
            ],
          ),
        ),
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilledButton(
                    onPressed: () {
                      onPressed(
                          1, int.tryParse(textEditingController.text) ?? 0);
                    },
                    child: Icon(FontAwesomeIcons.plus)),
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
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
                FilledButton(
                    onPressed: () {
                      onPressed(
                          0, int.tryParse(textEditingController.text) ?? 0);
                    },
                    child: Icon(
                      FontAwesomeIcons.minus,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
