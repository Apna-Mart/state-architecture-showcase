import 'package:flutter/material.dart';

IconData categoryIcon(String categoryId) => switch (categoryId) {
      'electricity' => Icons.bolt,
      'water' => Icons.water_drop,
      'piped-gas' => Icons.local_fire_department,
      'lpg' => Icons.propane_tank,
      'mobile-postpaid' => Icons.smartphone,
      'mobile-prepaid' => Icons.sim_card,
      'dth' => Icons.satellite_alt,
      'broadband' => Icons.wifi,
      'landline' => Icons.phone,
      'fastag' => Icons.toll,
      'credit-card' => Icons.credit_card,
      'insurance' => Icons.health_and_safety,
      'loan-emi' => Icons.account_balance,
      'education' => Icons.school,
      'municipal-tax' => Icons.location_city,
      _ => Icons.receipt_long,
    };
