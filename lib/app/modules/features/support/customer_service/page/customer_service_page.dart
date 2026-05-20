import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_scaffold.dart';
import '../widget/customer_service_card.dart';

class CustomerServicePage extends StatelessWidget {
  const CustomerServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Customer Service',
      showBackButton: true,
      body: CustomerServiceCard(),
    );
  }
}
