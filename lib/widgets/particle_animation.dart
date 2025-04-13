import 'dart:math';
import 'package:flutter/material.dart';

class ParticleNetwork extends StatefulWidget {
  final int numParticles;
  final double speed;

  const ParticleNetwork({
    super.key,
    required this.numParticles,
    required this.speed,
  });

  @override
  State<ParticleNetwork> createState() => _ParticleNetworkState();
}

class _ParticleNetworkState extends State<ParticleNetwork>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Particle>? particles;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(hours: 1))
          ..addListener(_updateParticles)
          ..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final rand = Random();
    final size = MediaQuery.of(context).size;

    particles = List.generate(
      widget.numParticles,
      (_) => Particle(
        position: Offset(
          rand.nextDouble() * size.width,
          rand.nextDouble() * size.height,
        ),
        velocity: Offset(
          (rand.nextDouble() - 0.5) * widget.speed,
          (rand.nextDouble() - 0.5) * widget.speed,
        ),
      ),
    );
  }

  void _updateParticles() {
    final size = MediaQuery.of(context).size;
    for (var particle in particles!) {
      particle.position += particle.velocity;

      // Bounce off walls
      if (particle.position.dx <= 0 || particle.position.dx >= size.width) {
        particle.velocity = Offset(-particle.velocity.dx, particle.velocity.dy);
      }
      if (particle.position.dy <= 0 || particle.position.dy >= size.height) {
        particle.velocity = Offset(particle.velocity.dx, -particle.velocity.dy);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (particles == null) {
      return const SizedBox(); // prevent null error on first build
    }
    return CustomPaint(
      size: Size.infinite,
      painter: ParticlePainter(particles!),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Particle {
  Offset position;
  Offset velocity;

  Particle({required this.position, required this.velocity});
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      final circlePaint =
          Paint()
            ..color = Colors.white
            ..strokeWidth = 1;

      canvas.drawCircle(p.position, 2, circlePaint);

      for (var other in particles) {
        final distance = (p.position - other.position).distance;
        if (distance < 100) {
          final opacity = (1 - distance / 100).clamp(0.0, 1.0);
          final linePaint =
              Paint()
                ..color = Colors.white.withValues(alpha: opacity)
                ..strokeWidth = 10 / distance;
          canvas.drawLine(p.position, other.position, linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
