import 'package:condo_app/src/gate_button/gate_button_controller.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class GateButton extends StatelessWidget {
  const GateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Builder(builder: (context) {
        final GateButtonController controller =
            context.watch<GateButtonController>();
        return ElevatedButton(
          onPressed: controller.loading ? null : controller.onPressed,
          child: controller.loading
              ? const CircularProgressIndicator()
              : const Text('Acionar portão'),
        );
      });
}
