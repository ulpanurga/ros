import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final controller = PageController(viewportFraction: 0.92);
  int current = 0;

  final banners = const [
    ['Новая коллекция', 'Осень 2026', Color(0xFFE50010)],
    ['Скидки до 30%', 'Только на этой неделе', Color(0xFF222222)],
    ['Детская одежда', 'Тепло и удобно', Color(0xFF3B6EA5)],
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 170,
          child: PageView.builder(
            controller: controller,
            itemCount: banners.length,
            onPageChanged: (i) => setState(() => current = i),
            itemBuilder: (context, i) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: banners[i][2] as Color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      banners[i][0] as String,
                      style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      banners[i][1] as String,
                      style: const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (i) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == current ? 18 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: i == current ? Colors.black : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}