import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3E2DF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF261E19),
        toolbarHeight: 100,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Color(0xFFE8E5E8),
          ),
        ),
        centerTitle: true, // Center the title
        automaticallyImplyLeading: false, // Remove the default back button
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
      ),
      body: ListView(
        children: [
          // Profile Card
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                // Profile Picture
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 16),
                // Name
                Text(
                  'Rayan Alloush',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Account Settings Section
          const SettingsSection(
            title: "Account Settings",
            items: [
              SettingsItem(
                text: "Edit profile",
                icon: Icons.edit,
              ),
              SettingsItem(
                text: "Change password",
                icon: Icons.lock,
              ),
              SettingsItem(
                text: "Add a payment method",
                icon: Icons.payment,
                trailing: Icon(Icons.add),
              ),
              SettingsSwitch(
                text: "Push notifications",
                value: true,
              ),
              SettingsSwitch(
                text: "Dark mode",
                value: false,
              ),
            ],
          ),
          const SizedBox(height: 8),
          // More Section
          const SettingsSection(
            title: "More",
            items: [
              SettingsItem(
                text: "About us",
                icon: Icons.info_outline,
              ),
              SettingsItem(
                text: "Privacy policy",
                icon: Icons.privacy_tip,
              ),
              SettingsItem(
                text: "Terms and conditions",
                icon: Icons.description,
              ),
              SettingsItem(
                text: "Rate us",
                icon: Icons.star_rate,
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Notification Preferences
          const SettingsSection(
            title: "Notification Preferences",
            items: [
              SettingsSwitch(
                text: "Email notifications",
                value: true,
              ),
              SettingsSwitch(
                text: "SMS notifications",
                value: false,
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// Reusable Components for Settings Page
class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const SettingsSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(children: items),
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Widget? trailing;

  const SettingsItem({
    super.key,
    required this.text,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: trailing ??
          const Icon(Icons.chevron_right, color: Colors.grey), // Default icon
    );
  }
}

class SettingsSwitch extends StatelessWidget {
  final String text;
  final bool value;

  const SettingsSwitch({
    super.key,
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      value: value,
      onChanged: (_) {},
      activeColor: const Color(0xFF261E19),
    );
  }
}





