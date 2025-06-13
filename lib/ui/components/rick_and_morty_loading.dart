import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/theme/text_styles.dart';

class RickAndMortyLoading extends StatelessWidget {
  const RickAndMortyLoading({super.key});

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
                    Image.asset("assets/images/loading.gif", width: 250),
                    const SizedBox(height: 20.0),
                    Text("Loading...", style: TextStyles.loadingStyle),
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
