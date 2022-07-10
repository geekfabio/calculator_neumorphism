import 'package:flutter/material.dart';

// About App
void aboutApp(BuildContext context) => showAboutDialog(
      context: context,
      applicationIcon: const Icon(Icons.calculate, size: 70),
      applicationName: 'Calculator Neu',
      applicationVersion: '1.0.0',
      applicationLegalese: '©2022, Armando Trindade || @trindadecode',
      children: const [
        Text(
          '\nThank you for test this Calculator.',
          textAlign: TextAlign.center,
        ),
      ],
    );
