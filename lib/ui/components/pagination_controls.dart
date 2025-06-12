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
      }

      for (int i = 0; i < pages.length; i++) {
        buttonsList.add(
          _createFloatingActionButton(
            _getFloatingActionButtonChild(i, pages.length, pages[i]),
            () => onPageChanged(pages[i]),
            pages[i] == currentPage,
            i == pages.length - 1,
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
    bool isLast,
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
        width: isLast ? 50.0 : 40.0,
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: isCurrent ? AppColors.currentButtonBackgroundColor : AppColors.buttonBackgroundColor,
          foregroundColor: AppColors.buttonForegroundColor,
          child: child,
        ),
      ),
    );
  }

  Widget _getFloatingActionButtonChild(
    int iterationValue,
    int length,
    int page,
  ) {
    if (iterationValue > 2 && iterationValue == length - 1) {
      return Text("... $page");
    }
    return Text(page.toString());
  }
}
