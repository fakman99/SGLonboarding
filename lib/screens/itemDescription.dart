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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemDescriptionScreen extends StatefulWidget {
  final String image;
  final String brand;
  // TODO : ADD MORE ARGS FOR ARTICLE

  ItemDescriptionScreen({Key key, this.image, this.brand}) : super(key: key);
  @override
  _ItemDescriptionScreenState createState() => _ItemDescriptionScreenState();
}

class _ItemDescriptionScreenState extends State<ItemDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                      top: 60.0,
                    ),
                    height: 520.0,
                    color: Colors.white10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.arrow_back,
                                size: 30.0,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Brand',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          widget.brand,
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Price',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          "30" + "€",
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Dimension',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          "34' x 42' ",
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 60.0),
                        RawMaterialButton(
                          padding: EdgeInsets.all(20.0),
                          shape: CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.green,
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          onPressed: () => {},
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 50.0,
                    bottom: 100.0,
                    child:
                        Hero(tag: "a", child: SvgPicture.asset(widget.image)),
                  ),
                ],
              ),
              Container(
                height: 400.0,
                transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: 30.0,
                        right: 30.0,
                        top: 40.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Description',
                            style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Inutile de vous compliquer la vie : voici un rangement simple pour commencer. Il comporte suffisamment d'espace pour que vous puissiez y ajouter des solutions ensuite si vous le voulez.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
