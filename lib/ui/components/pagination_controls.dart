import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/theme/app_colors.dart';

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> buttonsList = [];

    if (totalPages == 1) {
      buttonsList.add(
        _createFloatingActionButton(
          Text(totalPages.toString()),
          () => onPageChanged(currentPage),
          true,
          false,
        ),
      );
    } else if (totalPages >= 2) {
      List<int> pages = [];

      buttonsList.add(
        _createFloatingActionButton(
          Icon(Icons.navigate_before_rounded),
          () => onPageChanged(currentPage - 1),
          false,
          false,
        ),
      );

      if (totalPages - currentPage >= 3 && currentPage != 1) {
        pages = [currentPage - 1, currentPage, currentPage + 1, totalPages];
      } else if (totalPages - currentPage >= 3 && currentPage == 1) {
        pages = [currentPage, currentPage + 1, currentPage + 2, totalPages];
      } else {
        for (int i = currentPage; i <= totalPages; i++) {
          pages.add(i);
        }
        while (pages[0] > 1 && pages.length < 4) {
          pages.insert(0, pages[0] - 1);

          if (pages.length == 4 && totalPages - currentPage <= 2) {
            pages[0] = 1;
          }
        }
      }

      for (int i = 0; i < pages.length; i++) {
        Text child = _getFloatingActionButtonChild(i, pages) as Text;

        buttonsList.add(
          _createFloatingActionButton(
            child,
            () => onPageChanged(pages[i]),
            pages[i] == currentPage,
            child.data!.startsWith("...") || child.data!.endsWith("..."),
          ),
        );
      }

      buttonsList.add(
        _createFloatingActionButton(
          Icon(Icons.navigate_next_rounded),
          () => onPageChanged(currentPage + 1),
          false,
          false,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttonsList,
    );
  }

  Widget _createFloatingActionButton(
    Widget child,
    Function() onPressed,
    bool isCurrent,
    bool isAnExtreme,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20.0,
        top: 15.0,
        left: 7.5,
        right: 7.5,
      ),
      child: SizedBox(
        height: 40.0,
        width: isAnExtreme ? 50.0 : 40.0,
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor:
              isCurrent
                  ? AppColors.currentButtonBackgroundColor
                  : AppColors.buttonBackgroundColor,
          foregroundColor: AppColors.buttonForegroundColor,
          child: child,
        ),
      ),
    );
  }

  Widget _getFloatingActionButtonChild(int iterationValue, List<int> pages) {
    if (iterationValue == pages.length - 1 &&
        iterationValue > 1 &&
        pages[iterationValue] - pages[pages.length - 2] > 1) {
      return Text("...${pages[iterationValue]}");
    } else if (pages.length >= 2 &&
        pages[iterationValue] == 1 &&
        pages[iterationValue + 1] - 1 != 1) {
      return Text("${pages[iterationValue]}...");
    }
    return Text(pages[iterationValue].toString());
  }
}
