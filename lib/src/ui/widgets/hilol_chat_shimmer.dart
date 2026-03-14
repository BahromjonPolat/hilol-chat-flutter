/*

  Created by: Bakhromjon Polat
  Created on: Nov 27 2025 09:45:00

*/

import 'package:flutter/material.dart';

class HilolChatShimmer extends StatefulWidget {
  const HilolChatShimmer({super.key});

  @override
  State<HilolChatShimmer> createState() => _HilolChatShimmerState();
}

class _HilolChatShimmerState extends State<HilolChatShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(
      begin: -2,
      end: 2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 7,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final isLeft = index % 2 == 0;
        return _ChatBubbleShimmer(animation: _animation, isLeft: isLeft);
      },
    );
  }
}

class _ChatBubbleShimmer extends StatelessWidget {
  final Animation<double> animation;
  final bool isLeft;

  const _ChatBubbleShimmer({required this.animation, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment:
              isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            if (isLeft) ...[
              _ShimmerCircle(gradientOffset: animation.value),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Container(
                margin: EdgeInsets.only(
                  left: isLeft ? 0 : 56,
                  right: isLeft ? 56 : 0,
                ),
                child: _ShimmerContainer(
                  gradientOffset: animation.value,
                  width: double.infinity,
                  height: 80,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ShimmerCircle extends StatelessWidget {
  final double gradientOffset;

  const _ShimmerCircle({required this.gradientOffset});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade300,
            Colors.grey.shade100,
            Colors.grey.shade300,
          ],
          stops: const [0.0, 0.5, 1.0],
          transform: GradientRotation(gradientOffset),
        ),
      ),
    );
  }
}

class _ShimmerContainer extends StatelessWidget {
  final double gradientOffset;
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const _ShimmerContainer({
    required this.gradientOffset,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade300,
            Colors.grey.shade100,
            Colors.grey.shade300,
          ],
          stops: const [0.0, 0.5, 1.0],
          transform: GradientRotation(gradientOffset),
        ),
      ),
    );
  }
}
