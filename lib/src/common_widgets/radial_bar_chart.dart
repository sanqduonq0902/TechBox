import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Data cho từng vòng/bar
class RadialBarData {
  final double value; // Giá trị % hoặc số thực
  final Color color; // Màu bar
  final double radiusFactor; // Độ lớn vòng (0.5 - 1.0)
  final String? label; // Hiển thị ở giữa (nếu cần)

  RadialBarData({
    required this.value,
    required this.color,
    required this.radiusFactor,
    this.label,
  });
}

/// Widget Radial Bar Chart nhiều vòng, có thể custom trung tâm
class RadialBarChart extends StatelessWidget {
  final List<RadialBarData> bars; // List bar
  final Widget? centerContent; // Widget ở giữa (vd: % tổng, text...)

  const RadialBarChart({Key? key, required this.bars, this.centerContent})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        // Lặp qua từng bar để build từng vòng riêng
        for (final bar in bars)
          RadialAxis(
            minimum: 0,
            maximum: 100,
            radiusFactor: bar.radiusFactor,
            showTicks: false,
            showLabels: false,
            startAngle: 270,
            endAngle: 270,
            interval: 5,
            axisLineStyle: AxisLineStyle(
              thickness: 0.13,
              thicknessUnit: GaugeSizeUnit.factor,
              color: Colors.grey.withOpacity(0.12),
            ),
            pointers: [
              RangePointer(
                value: bar.value,
                color: bar.color,
                cornerStyle: CornerStyle.bothCurve,
                width: 0.13,
                sizeUnit: GaugeSizeUnit.factor,
                enableAnimation: true,
                animationDuration: 600,
              ),
            ],
            // Nếu là vòng trong cùng thì show center widget (ví dụ: text % ở giữa)
            annotations:
                bars.indexOf(bar) == 0 && centerContent != null
                    ? [
                      GaugeAnnotation(
                        angle: 90,
                        positionFactor: 0.0,
                        widget: centerContent!,
                      ),
                    ]
                    : [],
          ),
      ],
    );
  }
}
