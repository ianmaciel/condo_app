// MIT License
//
// Copyright (c) 2022 Ian Koerich Maciel
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:condo_app/src/gate_button/ewelink_button_controller.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class EwelinkButton extends StatefulWidget {
  const EwelinkButton({Key? key}) : super(key: key);

  @override
  State<EwelinkButton> createState() => _EwelinkButtonState();
}

class _EwelinkButtonState extends State<EwelinkButton> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    EwelinkButtonController controller =
        Provider.of<EwelinkButtonController>(context, listen: false);
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EwelinkButtonController>(
        builder: (context, controller, child) {
      return ElevatedButton(
        onPressed: controller.loading ? null : controller.onPressed,
        child: controller.loading
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: CircularProgressIndicator(),
              )
            : const Text('Acionar portão'),
      );
    });
  }
}
