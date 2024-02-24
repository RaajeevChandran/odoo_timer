import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// An equivalent to [GestureDetector] but with animation on each tap
/// When [enableFeedback] is true, generates haptic feedback on Android/iOS
class TapAnimatable extends StatefulWidget {
  final Function()? onPressed;
  final Function()? onLongPress;
  final Function(LongPressEndDetails)? onLongPressEnd;
  final Widget? child;
  final Duration? duration;
  final bool enableFeedback, enableTranslucentTapBehaviour;

  const TapAnimatable({
    super.key,
    this.enableFeedback = false,
    this.enableTranslucentTapBehaviour = false,
    this.onPressed,
    this.onLongPress,
    this.onLongPressEnd,
    required this.child,
    this.duration,
  });

  @override
  State<TapAnimatable> createState() => _TapAnimatableState();
}

class _TapAnimatableState extends State<TapAnimatable>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  double scaleMinCurve = 0.95;
  double minOpacityValue = 0.90;
  final Curve scaleCurve = _CurveSpring();
  Curve opacityCurve = Curves.ease;
  Duration duration = const Duration(milliseconds: 150);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);
    _scale = Tween<double>(begin: 1.0, end: 1.0).animate(_animationController);
    _opacity =
        Tween<double>(begin: 1.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> anim({double? scale, double? opacity, Duration? duration}) {
    _animationController.stop();
    _animationController.duration = duration ?? Duration.zero;

    _scale = Tween<double>(
      begin: _scale.value,
      end: scale,
    ).animate(CurvedAnimation(
      curve: scaleCurve,
      parent: _animationController,
    ));
    _opacity = Tween<double>(
      begin: _opacity.value,
      end: opacity,
    ).animate(CurvedAnimation(
      curve: opacityCurve,
      parent: _animationController,
    ));
    _animationController.reset();
    return _animationController.forward();
  }

  Future<void> _onTapDown(_) {
    return anim(
      scale: scaleMinCurve,
      opacity: minOpacityValue,
      duration: widget.duration ?? duration,
    );
  }

  Future<void> _onTapUp(_) {
    return anim(
      scale: 1.0,
      opacity: 1.0,
      duration: widget.duration ?? duration,
    );
  }

  Future<void> _onTapCancel(_) {
    return _onTapUp(_);
  }

  @override
  Widget build(BuildContext context) {
    final bool isTapEnabled =
        widget.onPressed != null || widget.onLongPress != null;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, Widget? child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.scale(
            alignment: Alignment.center,
            scale: _scale.value,
            child: child,
          ),
        );
      },
      child: Listener(
        onPointerDown: isTapEnabled ? _onTapDown : null,
        onPointerCancel: _onTapCancel,
        onPointerUp: _onTapUp,
        child: GestureDetector(
          behavior: widget.enableTranslucentTapBehaviour
              ? HitTestBehavior.translucent
              : null,
          onTap: isTapEnabled
              ? () {
                  if (widget.enableFeedback) {
                    SystemSound.play(SystemSoundType.click);
                  }
                  widget.onPressed?.call();
                }
              : null,
          onLongPress: isTapEnabled ? widget.onLongPress : null,
          onLongPressEnd: (e) {
            if (isTapEnabled && widget.onLongPressEnd != null) {
              widget.onLongPressEnd!(e);
            }
          },
          child: widget.child,
        ),
      ),
    );
  }
}

class _CurveSpring extends Curve {
  final SpringSimulation sim;

  _CurveSpring() : sim = _sim(70, 20);

  @override
  double transform(double t) => sim.x(t) + t * (1 - sim.x(1.0));
}

_sim(double stiffness, double damping) => SpringSimulation(
      SpringDescription.withDampingRatio(
        mass: 1,
        stiffness: stiffness,
        ratio: 0.7,
      ),
      0.0,
      1.0,
      0.0,
    );
