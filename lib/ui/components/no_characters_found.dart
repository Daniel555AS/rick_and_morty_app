import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/theme/text_styles.dart';

class NoCharactersFound extends StatelessWidget {
  const NoCharactersFound({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/rick_and_morty_icon.png",
                      width: 250,
                    ),
                    Text(
                      "No characters found...",
                      style: TextStyles.loadingStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
