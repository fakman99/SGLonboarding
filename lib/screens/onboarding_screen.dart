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
import 'package:OnboardingSgl2/util/styles.dart';

import 'articleListScreen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _nbrPages = 3; //nbr de pages = len(Widgets[Padding,...])
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  // Créer le widget en fonction de la page
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _nbrPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  //Créer le dot (currenge page = isActive else notActive)
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF4D4E4A),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: [
                //dégradé de sgl Color
                Color(0xFFa8d396),
                Color(0xFF8cca73),
                Color(0xFF6ec14e),
                Color(0xFF4BB81F),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => print('Skip'), //navigate to the next
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 600.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      buildStepScreen(
                          'assets/images/onboarding0.png',
                          'Create a plant\nand a Green LAB',
                          'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.'),
                      buildStepScreen(
                          'assets/images/onboarding1.png',
                          'Create a plant\nand a Green LAB',
                          'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.'),
                      buildStepScreen(
                          'assets/images/onboarding2.png',
                          'Create a plant\nand a Green LAB',
                          'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _nbrPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _nbrPages - 1
          ? Container(
              height: 100.0,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () =>
                        print('navigate to sgl app'), //navigate to the SGL app
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 0.0, left: 25),
                        child: Text(
                          'Get started',
                          style: TextStyle(
                            color: Color(0xFF3BB30B),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewStepperScreen()),
                    ), //navigate to the GuidePage
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 0.0, right: 25),
                        child: Text(
                          'Guide',
                          style: TextStyle(
                            color: Color(0xFF3BB30B),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Text(''), // "empty" widget
    );
  }

  //Build onBoarding pages
  Padding buildStepScreen(String image, String desc, String title) {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage(
                image,
              ),
              height: 300.0,
              width: 300.0,
            ),
          ),
          SizedBox(height: 30.0),
          Text(
            desc,
            style: kTitleStyle,
          ),
          SizedBox(height: 15.0),
          Text(
            desc,
            style: kSubtitleStyle,
          ),
        ],
      ),
    );
  }
}
