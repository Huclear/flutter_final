import 'package:flutter/material.dart';

class PageSelectionRow extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  final Function(int) onPageClick;

  const PageSelectionRow({
    super.key,
    required this.totalPages,
    required this.currentPage,
    required this.onPageClick,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (currentPage - 1 > 1 || currentPage == totalPages)
            _buildPageButton(1, theme),
          if (currentPage > 3) const Text('...'),
          ..._buildMiddleButtons(theme),
          if (currentPage + 1 < totalPages) ...[
            if (totalPages - currentPage + 1 > 1) const Text('...'),
            _buildPageButton(totalPages, theme),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildMiddleButtons(ThemeData theme) {
    if (totalPages >= 7) {
      return List.generate(3, (index) {
        final pageNum = _getPageNumber(index);
        return _buildPageButton(
          pageNum,
          theme,
          isSelected: currentPage == pageNum,
        );
      });
    }
    return [];
  }

  int _getPageNumber(int index) {
    if (currentPage >= 2 && currentPage < totalPages) {
      return (currentPage + index - 1).abs();
    } else if (totalPages - currentPage <= 3) {
      return (totalPages - 2 + index).abs();
    } else {
      return (currentPage + index).abs();
    }
  }

  Widget _buildPageButton(int pageNum, ThemeData theme, {bool isSelected = false}) {
    return TextButton(
      onPressed: () => onPageClick(pageNum),
      style: TextButton.styleFrom(
        foregroundColor: isSelected 
            ? theme.colorScheme.onPrimaryContainer
            : theme.colorScheme.primary,
        backgroundColor: isSelected 
            ? theme.colorScheme.primaryContainer
            : Colors.transparent,
        shape: const RoundedRectangleBorder(),
        padding: EdgeInsets.zero,
      ),
      child: Text(pageNum.toString()),
    );
  }
}