import 'dart:math';

import 'package:flutter/material.dart';

class PlitkaGrid extends StatelessWidget {
  const PlitkaGrid({
    super.key,
    required this.dimension,
    required this.plitkaList,
    required this.onPlitkaItemTap,
  });

  final int dimension;
  final List<int> plitkaList;
  final void Function(int) onPlitkaItemTap;

  static const _itemsSpacing = 16.0;
  static const _horizontalPadding = 22.0;

  int get _realDimension => dimension + 1;
  int get _itemCount => pow(_realDimension, 2).toInt();

  Size _itemSize(BuildContext context) {
    final generalPaddings = _horizontalPadding * 2 + _itemsSpacing * dimension;
    final width = MediaQuery.of(context).size.width;
    final side = (width - generalPaddings) / 5;
    return Size(side, side);
  }

  @override
  Widget build(BuildContext context) {
    final itemSize = _itemSize(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _realDimension,
        crossAxisSpacing: _itemsSpacing,
        mainAxisSpacing: _itemsSpacing,
      ),
      itemCount: _itemCount,
      itemBuilder: (context, index) {
        if (index == 0) {
          return SizedBox.fromSize(size: itemSize);
        }

        if (index < _realDimension || index % _realDimension == 0) {
          return SizedBox.fromSize(
            size: itemSize,
            child: Image.asset(
              'assets/plitka_unclickable.png',
              fit: BoxFit.cover,
            ),
          );
        }

        final plitkaIndex = _getPlitkaIndex(index);
        final plikaValue = plitkaList[plitkaIndex];

        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => onPlitkaItemTap(plitkaIndex),
          child: SizedBox.fromSize(
            size: itemSize,
            child: Image.asset(
              'assets/plitka_$plikaValue.png',
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }

  int _getPlitkaIndex(int index) {
    final columnIndex = (index % _realDimension) - 1;
    final rowIndex = (index / _realDimension).floor() - 1;

    return rowIndex * dimension + columnIndex;
  }
}
