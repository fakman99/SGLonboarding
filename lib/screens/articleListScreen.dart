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

import 'package:OnboardingSgl2/screens/itemDescription.dart';
import 'package:OnboardingSgl2/screens/stepper_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewStepperScreen extends StatefulWidget {
  @override
  _NewStepperScreenState createState() => _NewStepperScreenState();
}

class _NewStepperScreenState extends State<NewStepperScreen> {
  PageController _pageController;
  ScrollController _listScrollController;
  ScrollController _activeScrollController;
  Drag _drag;
  bool checked = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _listScrollController = ScrollController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    if (_listScrollController.hasClients &&
        _listScrollController.position.context.storageContext != null) {
      final RenderBox renderBox = _listScrollController
          .position.context.storageContext
          .findRenderObject();
      if (renderBox.paintBounds
          .shift(renderBox.localToGlobal(Offset.zero))
          .contains(details.globalPosition)) {
        _activeScrollController = _listScrollController;
        _drag = _activeScrollController.position.drag(details, _disposeDrag);
        return;
      }
    }
    _activeScrollController = _pageController;
    _drag = _pageController.position.drag(details, _disposeDrag);
  }

  /*
   * If the listView is on Page 1, then change the condition as "details.primaryDelta < 0" and
   * "_activeScrollController.position.pixels ==  _activeScrollController.position.maxScrollExtent"
   */
  void _handleDragUpdate(DragUpdateDetails details) {
    if (_activeScrollController == _listScrollController &&
        details.primaryDelta > 0 &&
        _activeScrollController.position.pixels ==
            _activeScrollController.position.minScrollExtent) {
      _activeScrollController = _pageController;
      _drag?.cancel();
      _drag = _pageController.position.drag(
          DragStartDetails(
              globalPosition: details.globalPosition,
              localPosition: details.localPosition),
          _disposeDrag);
    }
    _drag?.update(details);
  }

  void _handleDragEnd(DragEndDetails details) {
    _drag?.end(details);
  }

  void _handleDragCancel() {
    _drag?.cancel();
  }

  void _disposeDrag() {
    _drag = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        VerticalDragGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer(),
                (VerticalDragGestureRecognizer instance) {
          instance
            ..onStart = _handleDragStart
            ..onUpdate = _handleDragUpdate
            ..onEnd = _handleDragEnd
            ..onCancel = _handleDragCancel;
        })
      },
      behavior: HitTestBehavior.opaque,
      child: PageView(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          StepperShopScreen(),
          PageView(children: [
            ListView(
              controller: _listScrollController,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                20,
                (int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ItemDescriptionScreen(
                                image: "assets/furniture.svg", brand: "Ikea"),
                          ),
                        );
                      },
                      child: Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white70,
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
                                    "TEST",
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
                              Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Expanded(
                                          child: SvgPicture.asset(
                                        "assets/furniture.svg",
                                        width: 220 / 1.5,
                                        height: 220 / 1.5,
                                      ))))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
        ],
      ),
    ));
  }
}
