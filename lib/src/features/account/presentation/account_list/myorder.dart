import 'package:flutter/material.dart';
import 'package:techbox/src/common_widgets/radial_bar_chart.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Màu status order giống ảnh
    const red = Color(0xFFE80054);
    const yellow = Color(0xFFFFC300);
    const blue = Color(0xFF00D5FF);
    const darkPurple = Color(0xFF3B009A);
    const purple = Color(0xFFB5179E);
    const greyBg = Color(0xFFF8F8F8);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: greyBg,
        appBar: const AppBarComponent(
          title: 'Đơn hàng của tôi',
          showBackButton: true,
          showBottomBorder: false,
        ),
        body: Column(
          children: [
            const SizedBox(height: 18),
            // Biểu đồ tròn multi-ring
            Center(
              child: SizedBox(
                width: 320,
                height: 320,
                child: RadialBarChart(
                  bars: [
                    RadialBarData(
                      value: 85,
                      color: purple,
                      radiusFactor: 0.95,
                    ), // Đã huỷ
                    RadialBarData(
                      value: 85,
                      color: darkPurple,
                      radiusFactor: 0.82,
                    ), // Đã giao hàng
                    RadialBarData(
                      value: 85,
                      color: red,
                      radiusFactor: 0.70,
                    ), // Chờ xác nhận
                    RadialBarData(
                      value: 75,
                      color: yellow,
                      radiusFactor: 0.60,
                    ), // Đang xử lý
                    RadialBarData(
                      value: 65,
                      color: blue,
                      radiusFactor: 0.49,
                    ), // Đã gửi hàng
                  ],
                  centerContent: const Center(
                    child: Text(
                      '99%',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Legend: 2 dòng, căn giữa
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _OrderLegend(color: red, label: "Chờ xác nhận"),
                      SizedBox(width: 32),
                      _OrderLegend(color: yellow, label: "Đang xử lý"),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _OrderLegend(color: blue, label: "Đã gửi hàng"),
                      SizedBox(width: 12),
                      _OrderLegend(color: darkPurple, label: "Đã giao hàng"),
                      SizedBox(width: 12),
                      _OrderLegend(color: purple, label: "Đã huỷ"),
                    ],
                  ),
                ],
              ),
            ),
            // TabBar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: Color(0xFFE7E7E7), width: 1),
              ),
              child: TabBar(
                isScrollable: true,
                labelColor: Color(0xFF2490A8),
                unselectedLabelColor: Color(0xFFB7B7B7),
                indicatorColor: Color(0xFF2490A8),
                indicatorWeight: 2.5,
                indicatorPadding: EdgeInsets.zero,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.5,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.5,
                ),
                tabs: const [
                  Tab(text: "Chờ xác nhận"),
                  Tab(text: "Đang xử lý"),
                  Tab(text: "Đã gửi hàng"),
                  Tab(text: "Đã giao hàng"),
                  Tab(text: "Đã huỷ"),
                ],
              ),
            ),
            // TabBarView chứa từng danh sách đơn
            Expanded(
              child: TabBarView(
                children: [
                  _OrderList(statusColor: red, statusText: "Chờ xác nhận"),
                  _OrderList(statusColor: yellow, statusText: "Đang xử lý"),
                  _OrderList(statusColor: blue, statusText: "Đã gửi hàng"),
                  _OrderList(
                    statusColor: darkPurple,
                    statusText: "Đã giao hàng",
                  ),
                  _OrderList(statusColor: purple, statusText: "Đã huỷ"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Danh sách đơn hàng cho từng tab (dùng ListView, vuốt dọc được)
class _OrderList extends StatelessWidget {
  final Color statusColor;
  final String statusText;

  const _OrderList({required this.statusColor, required this.statusText});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      itemCount: 3,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder:
          (context, index) =>
              _OrderCard(statusColor: statusColor, statusText: statusText),
    );
  }
}

// Legend (Chú thích trạng thái)
class _OrderLegend extends StatelessWidget {
  final Color color;
  final String label;

  const _OrderLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 22,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 7),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF222222),
          ),
        ),
      ],
    );
  }
}

// Card Đơn hàng
class _OrderCard extends StatelessWidget {
  final Color statusColor;
  final String statusText;

  const _OrderCard({
    this.statusColor = const Color(0xFFE80054),
    this.statusText = "Chờ xác nhận",
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
        side: const BorderSide(color: Color(0xFFE7E7E7), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Đơn hàng: #67eea5e05764f7107a4700e5",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
                fontSize: 15.3,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  size: 18,
                  color: Color(0xFFB9B9B9),
                ),
                const SizedBox(width: 4),
                Text(
                  "8/7/2025",
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                ),
                const SizedBox(width: 14),
                Container(
                  width: 9,
                  height: 9,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              "Tổng tiền: 12.000.000đ",
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: Image.asset(
                      'assets/image/garbage.png',
                      color: statusColor,
                      width: 20,
                      height: 20,
                    ),
                    label: Text(
                      "Hủy đơn",
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: statusColor, width: 1.3),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.white,
                      foregroundColor: statusColor,
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Image.asset(
                      'assets/image/address.png',
                      color: Colors.white,
                      width: 20,
                      height: 20,
                    ),
                    label: const Text(
                      "Theo dõi đơn",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF314B52),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
