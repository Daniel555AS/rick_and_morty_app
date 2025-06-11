import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/theme/text_styles.dart';

class RickAndMortyLoading extends StatelessWidget {
  const RickAndMortyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/loading.gif", width: 350),
          SizedBox(height: 20.0),
          Text("Loading...", style: TextStyles.loadingStyle),
        ],
      ),
    );
  }
}
