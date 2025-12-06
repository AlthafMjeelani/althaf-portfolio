import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../common/section_title.dart';
import '../common/project_card.dart';
import '../hero/animated_background.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      Project(
        title: 'Vanforces — Van Sales & Inventory App',
        tech: 'Flutter · SQLite · REST API',
        period: 'Jan 2024 – Present',
        points: [
          'Offline-capable app with two-way sync using SQLite.',
          'Google Maps routing for delivery optimization.',
          'Complete inventory management with live stock tracking.',
          'Real-time location tracking optimized for battery.',
        ],
        description:
            'A comprehensive van sales and inventory management solution designed for field sales teams.',
        detailedDescription:
            'Vanforces is a powerful mobile application built for van sales teams to manage their inventory, track deliveries, and optimize routes. The app works seamlessly offline and syncs data when connectivity is available, ensuring sales teams never lose critical information.',
        tasks: [
          'Developed offline-first architecture with SQLite database',
          'Implemented two-way data synchronization with REST API',
          'Integrated Google Maps for route optimization and delivery tracking',
          'Built real-time inventory management with live stock updates',
          'Optimized location tracking for battery efficiency',
          'Created intuitive UI/UX for field sales teams',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.vanforces.salesman.app',
        appStoreUrl: 'https://apps.apple.com/in/app/vanforces/id6741518174',
        thumbnailImagePath: 'assets/images/vanforces_tump.png',
        fullImagePath: 'assets/images/vanforces.png',
        screenshots: [
          'assets/images/vanforces.png',
          // Add more screenshots: 'assets/images/vanforces_screen1.png', etc.
        ],
      ),
      Project(
        title: 'DHG Car Wash — Car Wash Management Suite',
        tech: 'Flutter · REST API · Apple Pay · Telr Payment',
        period: 'Jun 2025 – Aug 2025',
        points: [
          'Three connected apps (Customer, Shop, Operator).',
          'Integrated Apple Pay, Telr & Wallet system.',
          'Commission management & booking tracking modules.',
        ],
        description:
            'A complete car wash management ecosystem with three interconnected applications for customers, shop owners, and operators.',
        detailedDescription:
            'DHG Car Wash is a comprehensive suite of mobile applications designed to streamline car wash operations. The system includes separate apps for customers to book services, shop owners to manage operations, and operators to process bookings. Features include multiple payment gateways, commission tracking, and real-time booking management.',
        tasks: [
          'Developed three interconnected Flutter applications',
          'Integrated Apple Pay, Telr payment gateway, and custom wallet system',
          'Built commission calculation and management system',
          'Implemented real-time booking and tracking modules',
          'Created role-based access control for different user types',
          'Designed intuitive UI for each app variant',
        ],
        playStoreUrl: '',
        thumbnailImagePath: 'assets/images/dhg_tump.png',
        fullImagePath: 'assets/images/carwash.jpeg',
        screenshots: [
          'assets/images/carwash.jpeg',
          // Add more screenshots: 'assets/images/dhg_screen1.png', etc.
        ],
      ),
      Project(
        title: 'Speak Order — Voice-Based Ordering Platform',
        tech: 'Flutter · REST API',
        period: 'Dec 2024 – Mar 2025',
        points: [
          'AI voice-ordering supporting multiple languages.',
          'Auto-translation and real-time cross-language chat.',
          'Geo-based business discovery and integrated payments.',
        ],
        description:
            'An innovative voice-based ordering platform that breaks language barriers using AI-powered voice recognition and translation.',
        detailedDescription:
            'Speak Order revolutionizes the ordering experience by allowing users to place orders using voice commands in their native language. The app features advanced AI voice recognition, automatic translation for cross-language communication, and geo-based business discovery. Users can discover nearby restaurants and businesses, place orders via voice, and complete payments seamlessly.',
        tasks: [
          'Implemented AI-powered voice recognition for multiple languages',
          'Built real-time translation system for cross-language communication',
          'Developed geo-based business discovery and mapping features',
          'Integrated payment gateway for seamless transactions',
          'Created voice-to-text and text-to-voice conversion systems',
          'Designed intuitive UI for voice interactions',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.texol.stocksnap',
        appStoreUrl: 'https://apps.apple.com/in/app/speak-order/id6738990670',
        thumbnailImagePath: 'assets/images/speakorder_tump.png',
        fullImagePath: 'assets/images/speakorder.png',
        screenshots: [
          'assets/images/speakorder.png',
          // Add more screenshots: 'assets/images/speakorder_screen1.png', etc.
        ],
      ),
      Project(
        title: 'Taskforces — ERP & Business Management System',
        tech: 'Flutter · REST API · Cloud Sync',
        period: 'Apr 2024 – Present',
        points: [
          'ERP mobile suite: inventory, sales, invoicing, orders, collections.',
          'Real-time data sync for offline operations.',
          'Role-based access, multi-warehouse tracking, analytics dashboards.',
        ],
        description:
            'A comprehensive ERP mobile solution for managing all aspects of business operations from inventory to analytics.',
        detailedDescription:
            'Taskforces is a full-featured ERP mobile application that provides businesses with complete control over their operations. The app includes modules for inventory management, sales tracking, invoicing, order processing, collections, and comprehensive analytics. With real-time cloud synchronization and offline capabilities, businesses can manage operations from anywhere.',
        tasks: [
          'Developed complete ERP mobile suite with multiple modules',
          'Implemented real-time cloud synchronization with offline support',
          'Built role-based access control system',
          'Created multi-warehouse inventory tracking',
          'Designed comprehensive analytics and reporting dashboards',
          'Integrated payment and collection management systems',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.texol.taskforces',
        appStoreUrl:
            'https://apps.apple.com/in/app/taskforces-erp/id6475192934',
        thumbnailImagePath: 'assets/images/taskforce_tump.png',
        fullImagePath: 'assets/images/taskforce.jpeg',
        screenshots: [
          'assets/images/taskforce.jpeg',
          // Add more screenshots: 'assets/images/taskforce_screen1.png', etc.
        ],
      ),
      Project(
        title: 'WorkForceTime — Attendance & HR Management System',
        tech: 'Flutter · REST API',
        period: 'Mar 2024 – Present',
        points: [
          'QR & GPS-based attendance, shift management, leave tracking.',
          'Real-time payroll and productivity reports.',
          'Clean architecture with efficient background sync.',
        ],
        description:
            'A modern HR management system for tracking attendance, managing shifts, and generating comprehensive workforce reports.',
        detailedDescription:
            'WorkForceTime is a comprehensive HR management solution that simplifies attendance tracking, shift management, and workforce analytics. The app uses QR codes and GPS for accurate attendance marking, manages employee shifts and leave requests, and generates real-time payroll and productivity reports. Built with clean architecture principles for optimal performance.',
        tasks: [
          'Implemented QR code and GPS-based attendance tracking',
          'Built shift management and scheduling system',
          'Developed leave request and approval workflow',
          'Created real-time payroll calculation and reporting',
          'Designed productivity analytics and dashboards',
          'Optimized background synchronization for efficiency',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.texol.taskforces',
        appStoreUrl: 'https://apps.apple.com/in/app/workforcetime/id1378828558',
        thumbnailImagePath: 'assets/images/workforcetime_tump.png',
        fullImagePath: 'assets/images/workforcetime.png',
        screenshots: [
          'assets/images/workforcetime.png',
          // Add more screenshots: 'assets/images/workforcetime_screen1.png', etc.
        ],
      ),
      Project(
        title: 'AGSKart — Recharge & Bill Payment App',
        tech: 'Flutter · REST API · UPI',
        period: 'Jun 2023 – Dec 2023',
        points: [
          'Multi-platform recharge & bill payment app.',
          'PhonePe gateway with biometric authentication.',
          'Push notifications for transactions and offers.',
        ],
        description:
            'A comprehensive mobile application for mobile recharges, bill payments, and financial transactions.',
        detailedDescription:
            'AGSKart is a feature-rich mobile application that enables users to recharge mobile phones, pay utility bills, and perform various financial transactions. The app integrates with PhonePe payment gateway and includes biometric authentication for secure transactions. Users receive real-time push notifications for transaction updates and promotional offers.',
        tasks: [
          'Developed mobile recharge and bill payment modules',
          'Integrated PhonePe payment gateway',
          'Implemented biometric authentication (fingerprint/face ID)',
          'Built push notification system for transactions and offers',
          'Created user wallet and transaction history features',
          'Designed secure payment flow with multiple verification steps',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/developer?id=AGSKART+PRIVATE+LIMITED',
        appStoreUrl: 'https://apps.apple.com/in/app/agskart/id6503183690',
        thumbnailImagePath: 'assets/images/stocksnap_tump.png',
        fullImagePath: 'assets/images/stocksnap.png',
        screenshots: [
          'assets/images/stocksnap.png',
          // Add more screenshots: 'assets/images/agskart_screen1.png', etc.
        ],
      ),
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 800;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 600),
      child: Stack(
        children: [
          // Animated background (same as home)
          const AnimatedBackground(),

          // Content - Centered
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 60 : 24,
                  vertical: 80,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sectionTitle(context, 'Projects', icon: Icons.work_outline),
                    const SizedBox(height: 20),
                    Text(
                      'Showcasing my best work',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: isWide ? 16 : 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 60),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final maxW = constraints.maxWidth;
                        int columns;
                        if (screenWidth >= 1200) {
                          columns = 3;
                        } else if (screenWidth >= 800) {
                          columns = 2;
                        } else {
                          columns = 1;
                        }
                        const gap = 24.0;
                        final cardWidth =
                            (maxW - (gap * (columns - 1))) / columns;
                        return Wrap(
                          spacing: gap,
                          runSpacing: gap,
                          alignment: WrapAlignment.center,
                          children: [
                            for (final p in projects)
                              SizedBox(
                                width: cardWidth,
                                child: ProjectCard(project: p),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
