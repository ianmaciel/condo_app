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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_base_fields/field/material/forme_datetime_field.dart';
import 'package:forme_base_fields/field/material/forme_text_field.dart';

import 'virtual_key_model.dart';

class CreateKeyView extends StatelessWidget {
  const CreateKeyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // TODO: translate
          title: const Text('Criar Chave Virtual'),
        ),
        body: _VirtualKeyForm(),
      );
}

class _VirtualKeyForm extends StatelessWidget {
  _VirtualKeyForm({Key? key}) : super(key: key);

  final FormeKey formeKey = FormeKey();
  @override
  Widget build(BuildContext context) => Forme(
        key: formeKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autovalidateByOrder: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              FormeTextField(
                name: 'name',
                // TODO: translate
                decoration: const InputDecoration(labelText: 'Nome da Chave'),
                validator: FormeValidates.notNull(),
                updateValueWhenComposing: true,
              ),
              FormeDateTimeField(
                name: 'validThru',
                // TODO: translate
                decoration: const InputDecoration(labelText: 'Valida até'),
                validator: FormeValidates.notNull(),
                initialDatePickerMode: DatePickerMode.day,
                initialValue: DateUtils.addDaysToDate(
                    DateUtils.dateOnly(DateTime.now()), 1),
              ),
              const SizedBox(height: 16),
              FormeValidationListener(
                builder: (context, validation, child) => _SubmitButton(
                  formeKey: formeKey,
                  enabled: validation.isValid,
                ),
              ),
            ],
          ),
        ),
      );
}

class _SubmitButton extends StatefulWidget {
  const _SubmitButton({required this.formeKey, required this.enabled, Key? key})
      : super(key: key);
  final FormeKey formeKey;
  final bool enabled;

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: widget.enabled ? () => submitForm(context) : null,
        // TODO: translate
        child: const Text('Criar chave virtual'),
      );

  void submitForm(BuildContext context) async {
    String name = widget.formeKey.field<FormeFieldState<String>>('name').value;
    DateTime validThru = widget.formeKey.field('validThru').value as DateTime;
    VirtualKey virtuaKey = VirtualKey(
      name: name,
      owner: FirebaseAuth.instance.currentUser!.uid,
      validThru: validThru,
      enable: true,
    );
    await virtualKeysRef.add(virtuaKey);
    if (!mounted) return;
    Navigator.of(context).pop();
  }
}
