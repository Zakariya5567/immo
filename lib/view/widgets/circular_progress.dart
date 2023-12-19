import 'package:flutter/material.dart';
import 'package:immo/utils/colors.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: bluePrimary,
      ),
    );
  }
}
