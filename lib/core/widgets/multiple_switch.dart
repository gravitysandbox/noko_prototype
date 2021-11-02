import 'package:flutter/material.dart';

class MultipleSwitch extends StatefulWidget {
  final double height, width, border;
  final Set<String> switches;
  final Function(int) callback;
  final int activePosition;
  final Color activeColor, backgroundColor, borderColor, disabledColor;
  final bool isDisabled;

  const MultipleSwitch({
    Key? key,
    this.height = 50.0,
    required this.width,
    this.border = 2.0,
    required this.switches,
    required this.callback,
    required this.activePosition,
    this.activeColor = Colors.blue,
    this.backgroundColor = Colors.black12,
    this.borderColor = Colors.blue,
    this.disabledColor = Colors.blueGrey,
    this.isDisabled = false,
  })  : assert(switches.length > 1),
        assert(activePosition <= switches.length),
        super(key: key);

  @override
  _MultipleSwitchState createState() => _MultipleSwitchState();
}

class _MultipleSwitchState extends State<MultipleSwitch> {
  Widget _buildLeftSwitch(
      String label, double itemWidth, double itemBorderRadius) {
    return Positioned(
      top: widget.border,
      bottom: widget.border,
      left: widget.border,
      child: GestureDetector(
        onTap: () => widget.callback(0),
        child: Container(
          width: itemWidth,
          decoration: BoxDecoration(
            color: _getActiveColor(widget.activePosition == 0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(itemBorderRadius),
              bottomLeft: Radius.circular(itemBorderRadius),
            ),
          ),
          child: Center(
            child: Text(label),
          ),
        ),
      ),
    );
  }

  Widget _buildRightSwitch(
      String label, double itemWidth, double itemBorderRadius) {
    return Positioned(
      top: widget.border,
      bottom: widget.border,
      right: widget.border,
      child: GestureDetector(
        onTap: () => widget.callback(widget.switches.length - 1),
        child: Container(
          width: itemWidth,
          decoration: BoxDecoration(
            color: _getActiveColor(
                widget.activePosition == (widget.switches.length - 1)),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(itemBorderRadius),
              bottomRight: Radius.circular(itemBorderRadius),
            ),
          ),
          child: Center(
            child: Text(label),
          ),
        ),
      ),
    );
  }

  Widget _buildCenterSwitch(String label, double itemWidth, int position) {
    return Positioned(
      top: widget.border,
      bottom: widget.border,
      left: (widget.border * position) + (itemWidth * (position - 1)),
      child: GestureDetector(
        onTap: () => widget.callback(position - 1),
        child: Container(
          width: itemWidth,
          decoration: BoxDecoration(
            color: _getActiveColor(widget.activePosition == (position - 1)),
          ),
          child: Center(
            child: Text(label),
          ),
        ),
      ),
    );
  }

  Color _getActiveColor(bool isActive) {
    return isActive
        ? widget.isDisabled
            ? widget.disabledColor
            : widget.activeColor
        : widget.backgroundColor;
  }

  Widget _buildVerticalDivider(int position, double itemWidth) {
    return Positioned(
      top: widget.border,
      bottom: widget.border,
      left: ((widget.border + itemWidth) * position),
      child: VerticalDivider(
        width: widget.border,
        thickness: widget.border,
        color: widget.isDisabled ? widget.disabledColor : widget.borderColor,
      ),
    );
  }

  List<Widget> _buildMultipleSwitches(double itemWidth, double borderRadius) {
    final itemBorderRadius = borderRadius * 0.9;
    final List<Widget> widgetsToShow = [];

    for (var i = 0; i < widget.switches.length; i++) {
      if (i == 0) {
        widgetsToShow.add(_buildLeftSwitch(
          widget.switches.elementAt(i),
          itemWidth.toDouble(),
          itemBorderRadius,
        ));
        widgetsToShow.add(_buildVerticalDivider(
          i + 1,
          itemWidth.toDouble(),
        ));
      } else if (i == widget.switches.length - 1) {
        widgetsToShow.add(_buildRightSwitch(
          widget.switches.elementAt(i),
          itemWidth.toDouble(),
          itemBorderRadius,
        ));
      } else {
        widgetsToShow.add(_buildCenterSwitch(
          widget.switches.elementAt(i),
          itemWidth.toDouble(),
          i + 1,
        ));
        widgetsToShow.add(_buildVerticalDivider(
          i + 1,
          itemWidth.toDouble(),
        ));
      }
    }

    return widgetsToShow;
  }

  @override
  Widget build(BuildContext context) {
    final itemWidth =
        (widget.width - ((widget.switches.length + 1) * widget.border)) ~/
            widget.switches.length;
    final wrapperWidth = (itemWidth * widget.switches.length) +
        (widget.border * (widget.switches.length + 1));
    final borderRadius = widget.height * 0.2;

    return Container(
      height: widget.height,
      width: wrapperWidth,
      decoration: BoxDecoration(
        color: widget.isDisabled ? widget.disabledColor : widget.borderColor,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: Stack(
        children: _buildMultipleSwitches(itemWidth.toDouble(), borderRadius),
      ),
    );
  }
}
