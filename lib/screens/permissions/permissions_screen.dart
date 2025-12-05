import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/alerts/state_alert.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Permissions'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingLG),
        children: [
          const StateAlert(
            type: AlertType.info,
            message: 'These permissions are required for the app to function properly',
          ),
          const SizedBox(height: AppTheme.spacingXL),
          Card(
            child: ListTile(
              leading: const Icon(Icons.location_on, color: AppTheme.accentColor),
              title: const Text('Location Access'),
              subtitle: const Text('Required for navigation and ride matching'),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.camera_alt, color: AppTheme.accentColor),
              title: const Text('Camera Access'),
              subtitle: const Text('Required for document upload'),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.folder, color: AppTheme.accentColor),
              title: const Text('Storage Access'),
              subtitle: const Text('Required for saving documents'),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.phone, color: AppTheme.accentColor),
              title: const Text('Phone Access'),
              subtitle: const Text('Required for calling riders'),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
