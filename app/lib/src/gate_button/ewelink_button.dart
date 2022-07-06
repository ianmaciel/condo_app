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

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:slidable_button/slidable_button.dart';

import 'ewelink_button_controller.dart';

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
        return _SlidableButton(
          enabled: controller.isNotloading,
          onPressed: controller.onPressed,
        );
      },
    );
  }
}

class _SlidableButton extends StatelessWidget {
  const _SlidableButton({this.enabled = true, this.onPressed, Key? key})
      : super(key: key);
  final bool enabled;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) => HorizontalSlidableButton(
        initialPosition: SlidableButtonPosition.start,
        buttonWidth: 65.0,
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        buttonColor: Theme.of(context).primaryColor,
        dismissible: true,
        isRestart: true,
        autoSlide: true,
        completeSlideAt: 1,
        // TODO: translate
        label: const Center(child: Text('Deslize')),
        onChanged: enabled ? _onChanged : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              // TODO: Translate
              Text('Acionar Portão'),
            ],
          ),
        ),
      );

  void _onChanged(SlidableButtonPosition position) {
    if (position == SlidableButtonPosition.end && onPressed != null) {
      onPressed!();
    }
  }
}
