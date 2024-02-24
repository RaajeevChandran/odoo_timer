import 'package:flutter/material.dart';
import 'package:odoo_timer/models/models.dart';
import 'package:odoo_timer/utils/utils.dart';

// A custom dropdown that matches the design system
class CustomDropdown<T> extends StatefulWidget {
  final String hintText;
  final List<CustomDropdownItem<T>> items;
  final Function(CustomDropdownItem<T>) onChanged;

  const CustomDropdown(
      {required this.hintText,
      required this.items,
      required this.onChanged,
      super.key});

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  /// for simplicity, [setState] has been used within this widget
  CustomDropdownItem<T>? _selectedItem;

  final GlobalKey _key = GlobalKey();
  
  bool _isDropdownOpen = false;
  
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
            onTap: _toggleDropdown,
            child: Container(
              key: _key,
              padding: EdgeInsets.symmetric(
                  horizontal: 15, vertical: _selectedItem == null ? 15 : 10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 2.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.hintText, overflow: TextOverflow.ellipsis,),
                      if (_selectedItem != null)
                        Text(_selectedItem!.label.toString(), style: context.textTheme.bodyLarge,)
                    ],
                  ),
                  Icon(_isDropdownOpen
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);
    double screenWidth = context.getMaxContentWidth() ?? MediaQuery.of(context).size.width;

    return OverlayEntry(
        builder: (context) => Positioned(
              left: position.dx,
              top: position.dy + renderBox.size.height + 10,
              width: screenWidth - 30,
              child: Material(
                color: context.colorScheme.secondary,
                type: MaterialType.card,
                borderRadius: BorderRadius.circular(15),
                elevation: 0,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: context.colorScheme.secondary,
                  ),
                  child: SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemBuilder: (_, index) => ListTile(
                                    title: Text(
                                      widget.items[index].label,
                                      style: context.textTheme.bodyMedium,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _selectedItem = widget.items[index];
                                        _isDropdownOpen = false;
                                        widget.onChanged(_selectedItem!);
                                      });
                                      _overlayEntry?.remove();
                                    },
                                  ),
                              separatorBuilder: (_, __) => Divider(
                                    color: context.colorScheme.primary,
                                    thickness: 0.3,
                                  ),
                              itemCount: widget.items.length),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _overlayEntry?.remove();
    } else {
      _overlayEntry = _createOverlayEntry();

      Overlay.of(context).insert(_overlayEntry!);
    }
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  @override
  void dispose() {
    super.dispose();
    try {
      _overlayEntry?.remove();
    }catch(e) {}
  }
}

