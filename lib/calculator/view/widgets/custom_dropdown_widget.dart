import 'package:calculator/app/utils/constants.dart';
import 'package:calculator/app/utils/neumorphism_extension.dart';
import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu({
    super.key,
    required this.icons,
    required this.borderRadius,
    required this.backgroundColor,
    this.onChange,
  });
  final List<Icon> icons;
  final BorderRadius? borderRadius;
  final Color backgroundColor;
  final ValueChanged<int>? onChange;

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu>
    with SingleTickerProviderStateMixin {
  GlobalKey? _key;
  bool isMenuOpen = false;
  late Offset buttonPosition;
  late Size buttonSize;
  late OverlayEntry _overlayEntry;
  BorderRadius? _borderRadius;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _borderRadius = widget.borderRadius ?? BorderRadius.circular(4);
    _key = LabeledGlobalKey('button_icon');
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  findButton() {
    final renderBox = _key!.currentContext!.findRenderObject() as RenderBox;
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void closeMenu() {
    _overlayEntry.remove();
    _animationController.reverse();
    isMenuOpen = !isMenuOpen;
  }

  void openMenu() {
    findButton();
    _animationController.forward();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context)!.insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      key: _key,
      decoration: BoxDecoration(borderRadius: _borderRadius),
      // Consumer provides playMenuClose() & playMenuOpen()
      // from SoundProvider
      child: IconButton(
        splashRadius: 1,
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animationController,
        ),
        iconSize: 35,
        onPressed: () {
          if (isMenuOpen) {
            // soundProvider.playMenuClose();
            closeMenu();
          } else {
            // soundProvider.playMenuOpen();
            openMenu();
          }
        },
      ),
    );
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy + buttonSize.height - 13.0,
          left: buttonPosition.dx,
          width: buttonSize.width,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4, right: 10),
                child: Material(
                  elevation: 10,
                  color: Colors.transparent,
                  shadowColor: Theme.of(context).shadowColor,
                  child: Container(
                    height: widget.icons.length * buttonSize.height,
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      borderRadius: _borderRadius,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        widget.icons.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              onSelected(context, index);
                              //widget.onChange!(index);
                              closeMenu();
                            },
                            child: SizedBox(
                              width: buttonSize.width,
                              height: buttonSize.height,
                              child: widget.icons[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ).addNeumorphism(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      print('kkkk');
      // Navigator.of(context).push(
      //   // CupertinoPageRoute(
      //   //   builder: (context) => const HistoryPage(),
      //   // ),
      // );

      break;

    case 1:
      aboutApp(context);
      break;
  }
}
