import 'package:flutter/material.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/pages/add_habit_page.dart';

class AnimationAdd extends StatefulWidget {
  const AnimationAdd({Key? key}) : super(key: key);

  @override
  State<AnimationAdd> createState() => _AnimationAddState();
}

class _AnimationAddState extends State<AnimationAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            child: TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end:1.0),
              duration: const Duration(milliseconds: 1500),
              child: const AddHabitPage(),
              builder: (context, value, child) {
                return ShaderMask(
                  blendMode: BlendMode.modulate,
                  shaderCallback: (rect){
                    return RadialGradient(
                      radius: value * 5,
                      colors: const [Colors.white, Colors.white, Colors.transparent, Colors.transparent],
                      stops: const [0.0, 0.55, 0.6, 1.0],
                      center: const FractionalOffset(0.95, 0.90),
                    ).createShader(rect);
                  },
                  child: child,
                );
              },
            ),
          );
        }
      ),
    );
  }
}