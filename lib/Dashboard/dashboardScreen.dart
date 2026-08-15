import 'package:cabbooking_frontend/Auth/LoginScreen.dart';
import 'package:cabbooking_frontend/Auth/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<Authcontroller>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              await authController.logout();
              Get.offAll(() => const LoginScreen());
            },
            icon: const Icon(Icons.logout, color: Colors.black),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 64,
                    color: Colors.green.shade600,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Text(
                      authController.userName.value.isNotEmpty
                          ? 'Hello, ${authController.userName.value}'
                          : 'You are logged in successfully',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Obx(
                    () => authController.userEmail.value.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              authController.userEmail.value,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            _DashboardTile(
              icon: Icons.local_taxi,
              title: 'Book a Cab',
              subtitle: 'Find and book your next ride',
              onTap: () {
                Get.snackbar(
                  'Coming Soon',
                  'Cab booking will be available here',
                );
              },
            ),
            const SizedBox(height: 12),
            _DashboardTile(
              icon: Icons.history,
              title: 'Ride History',
              subtitle: 'View your past bookings',
              onTap: () {
                Get.snackbar(
                  'Coming Soon',
                  'Ride history will be available here',
                );
              },
            ),
            const SizedBox(height: 12),
            _DashboardTile(
              icon: Icons.person,
              title: 'Profile',
              subtitle: 'Manage your account details',
              onTap: () {
                Get.snackbar(
                  'Coming Soon',
                  'Profile settings will be available here',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  const _DashboardTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.green.shade700),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade500),
            ],
          ),
        ),
      ),
    );
  }
}
