/*
 * Copyright (C) 2018  SuperGreenLab <towelie@supergreenlab.com>
 * Author: Fatih Akman <fatihakman1999@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:im_stepper/stepper.dart';

class StepperShopScreen extends StatefulWidget {
  @override
  _StepperShopScreenState createState() => _StepperShopScreenState();
}

class _StepperShopScreenState extends State<StepperShopScreen> {
  bool checked = false;

  //Product Data in json (all image are in assets folder)
  String jsonData =
      '{  "0" : {  "produit0": {  "productName": "Eket Cabinet",  "brand": "Ikea",  "imagePath": "assets/product/product0.jpg",  "link": "https://www.supergreenlab.com/product/eket-ikea-eket-cabinet-ikea_fr-fr"  },  "produit1": {  "productName": "Small Eket",  "brand": "Ikea",  "imagePath": "assets/product/product1.jpg",  "link": "https://www.supergreenlab.com/product/small-eket-ikiea-small-eket-ikea_fr-fr"  },  "produit2": {  "productName": "Rakkestad with 2 doors",  "brand": "Ikea",   "imagePath": "assets/product/product2.jpg",  "link": "https://www.supergreenlab.com/product/rakkestad-wardrobe-2-doors-ikea-rakkenstad-2-door-wardrobe-ikea_fr-fr"  },  "produit3": {  "productName": "Kleppstad with 2 doors",  "brand": "Ikea",   "imagePath": "assets/product/product3.jpg",  "link": "https://www.supergreenlab.com/product/kleppstad-3-doors-wardrobe-ikea-kleppstad-3-doors-wardrobe-ikea_de-de"  },  "produit4": {  "productName": "Kleppstad with 3 doors",  "brand": "Ikea",  "imagePath": "assets/product/product5.jpg",  "link": "assets/product/product1.jpg"  },  "produit5": {  "productName": "Pax wardrobe frame",  "brand": "Ikea",  "imagePath": "assets/product/product1.jpg",  "link": "https://www.supergreenlab.com/product/pax-wardrobe-20214566-ikea-pax-wardrobe-frame-20214566-ikea_fr-fr"  }  },  "1": {  "produit0": {  "productName": "SGL 36 lm301b",   "brand":"SGL",  "imagePath": "assets/product/sglProduct0.jpg",  "link": "https://www.supergreenlab.com/product/sgl-36-supergreenlab-sgl-36-lm301b-supergreenlab-world"  },  "produit1": {  "productName": "Temp & rH sensor",   "brand":"SGL",  "imagePath": "assets/product/sglProduct1.jpg",  "link": "https://www.supergreenlab.com/product/sgl-temperature-humidity-sensor-supergreenlab-temperature-&-humidity-sensor-supergreenlab-world"  },  "produit2": {  "productName": "SGL Blower",   "brand":"SGL",  "imagePath": "assets/product/sglProduct5.jpg",  "link": "https://www.supergreenlab.com/product/sgl-blower-supergreenlab-sgl-blower-supergreenlab-world"  },  "produit3": {  "productName": "SGL Controller",   "brand":"SGL",  "imagePath": "assets/product/sglProduct2.jpg",  "link": "https://www.supergreenlab.com/product/sgl-controller-supergreenlab-supergreencontroller-supergreenlab-world"  },  "produit4": {  "productName": "Power supply 24V 6.25A",   "brand":"SGL",  "imagePath": "assets/product/sglProduct3.jpg",  "link": "https://www.supergreenlab.com/product/power-supply-24v-6-25a-sgl-power-supply-24v-6-25a-supergreenlab-world"  },  "produit5": {  "productName": "Blower & Sensor Combo",   "brand":"SGL",  "imagePath": "assets/product/sglProduct4.jpg",  "link": "https://www.supergreenlab.com/product/sgl-blower-sensor-combo-supergreenlab-blower-sensor-combo-supergreenlab-world"  }},  "2": {  "produit0": {  "productName": "Light mix 50L",   "brand":"Biobizz",  "imagePath": "assets/product/growProduct0.jpg",  "link": "https://www.supergreenlab.com/product/light-mix-soil-biobizz-light-mix-50l-amazon_de-de"  },  "produit1": {  "productName": "Fabric pot",   "brand":"SimBoom",  "imagePath": "assets/product/growProduct1.jpg",  "link": "https://www.supergreenlab.com/product/fabric-pots-simboom-fabric-pot-amazon_de-de"  },  "produit2": {  "productName": "Clay pebbles",   "brand":"VitaLink",  "imagePath": "assets/product/growProduct2.jpg",  "link": "https://www.supergreenlab.com/product/clay-pebbles-vitalink-clay-pebbles-amazon_uk-uk"  },  "produit3": {  "productName": "Peat pellets",   "brand":"Jiffy",  "imagePath": "assets/product/growProduct3.jpg",  "link": "https://www.supergreenlab.com/product/peat-pellets-jiffy-peat-pellets-amazon_de-de"  },  "produit4": {  "productName": "Mega crop 3kg",   "brand":"GreenLeaf Nutrients",  "imagePath": "assets/product/growProduct4.jpg",  "link": "https://www.supergreenlab.com/product/mega-crop-greenleaf-nutrients-3kg-mega-crop-greenleaf_nutrients_eu-eu"  },  "produit5": {  "productName": "Starter Pack",   "brand":"BioTabs",  "imagePath": "assets/product/growProduct5.jpg",  "link": "https://www.supergreenlab.com/product/biotabs-starter-kit-biotabs-starter-pack-biotabs-world"  }   }  }';
  int activeStep = 0; // Initial step.

  int upperBound = 2; // nbr de steps -1

  //list of svg path
  List<String> asset = [
    "assets/furniture.svg",
    "assets/screw.svg",
    "assets/plant.svg"
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = jsonDecode(jsonData);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: Text("GUIDE",
              style: TextStyle(
                  color: Color(0xff3BB30B),
                  fontWeight: FontWeight.w300,
                  fontSize: 30)),
        ),
        body: PageView(children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                NumberStepper(
                  stepReachedAnimationDuration: Duration(seconds: 2),
                  lineColor: Color(0xff3BB30B),
                  activeStepColor: Color(0xff3BB30B),
                  activeStepBorderColor: Color(0xff3BB30B),
                  numberStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w300),
                  stepRadius: 28,
                  numbers: [
                    1,
                    2,
                    3,
                  ],

                  // activeStep property set to activeStep
                  activeStep: activeStep,

                  // updates the activeStep.
                  onStepReached: (index) {
                    setState(() {
                      activeStep = index;
                    });
                  },
                ),
                header(),
                Expanded(
                  child: SvgPicture.asset(
                    asset[activeStep],
                    width: 212,
                    height: 212,
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 8),
                        child: Text(
                          "Our recommendation",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
                //stepWidget(activeStep, map),
                Padding(padding: EdgeInsets.all(8))
              ],
            ),
          ),
        ]));
  }

  /// Returns the previous button.
  Widget stepWidget(activeStep, map) {
    return Expanded(
      child: SizedBox(
          child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: map[activeStep.toString()].length,
        itemExtent: 180.0,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  image: DecorationImage(
                    image: AssetImage(map[activeStep.toString()]
                        ["produit$index"]["imagePath"]),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                            child: Text(
                          " " +
                              map[activeStep.toString()]["produit$index"]
                                  ["productName"] +
                              " \n" +
                              " " +
                              map[activeStep.toString()]["produit$index"]
                                  ["brand"],
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ))),
                    Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Checkbox(
                            activeColor: Color(0xff3BB30B),
                            value: checked,
                            onChanged: (bool value) {
                              setState(() {
                                checked = value;
                              });
                            },
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      )),
    );
  }

  Widget nextButton() {
    return FlatButton(
      color: Color(0xff3BB30B),
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      padding: EdgeInsets.all(8.0),
      splashColor: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Text("NEXT",
          style: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 16.0)),
      onPressed: () {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
    );
  }

  /// Returns the previous button.
  Widget previousButton(activeStep) {
    if (activeStep == 0) {
      return Container();
    } else {
      return FlatButton(
        color: Color(0xff3BB30B),
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Text("PREVIOUS",
            style: new TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 16.0)),
        onPressed: () {
          // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.

          setState(() {
            activeStep--;
          });
        },
      );
    }
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: TextStyle(
                  color: Color(0xff3BB30B),
                  fontSize: 24,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Get a bundle';

      case 2:
        return 'Start growing';

      default:
        return 'Get any furniture';
    }
  }
}
