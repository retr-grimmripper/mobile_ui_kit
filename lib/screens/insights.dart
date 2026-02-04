import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/styles.dart';
import '../widgets/ui_kit.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.inputBackground,
      body: SafeArea(
        child: Column(
          children: [
            const SectionHeader(title: "Insights", rightText: ""),

            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(color: AppColors.primary, value: 70, radius: 20, showTitle: false),
                        PieChartSectionData(color: AppColors.inputBackground, value: 30, radius: 20, showTitle: false),
                      ],
                      centerSpaceRadius: 70,
                      sectionsSpace: 0,
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("\$32.01", style: AppText.header1),
                        Text("70% spent", style: AppText.body),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: 5,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(width: 10, height: 10, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                      const SizedBox(width: 16),
                      Text("Item ${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      const Spacer(),
                      const Text("\$12.00", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
