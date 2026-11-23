import 'package:material_ui/material_ui.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tentang Aplikasi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text(
              'MyPortfolio Mobile',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Aplikasi ini menampilkan identitas pemilik portofolio, kartu aksi, dan formulir untuk menambah proyek, pengalaman, serta edukasi. '
              'Data masih disimpan di dalam kode, jadi aplikasi bisa berjalan tanpa backend.',
            ),
            const SizedBox(height: 24.0),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pemilik',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    const _InfoRow(label: 'NPM', value: '2506656545'),
                    const SizedBox(height: 8.0),
                    const _InfoRow(label: 'Nama', value: 'Bagas Aulia Rezki'),
                    const SizedBox(height: 8.0),
                    const _InfoRow(label: 'Kelas', value: 'PBP E'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fitur',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    const _FeatureRow(
                      icon: Icons.badge_outlined,
                      text: 'Tiga kartu identitas untuk NPM, nama, dan kelas.',
                    ),
                    const _FeatureRow(
                      icon: Icons.dashboard_customize_outlined,
                      text: 'Lima kartu aksi dengan warna berbeda dan pesan SnackBar.',
                    ),
                    const _FeatureRow(
                      icon: Icons.menu,
                      text:
                          'Drawer untuk berpindah ke Home dan setiap formulir.',
                    ),
                    const _FeatureRow(
                      icon: Icons.edit_note,
                      text: 'Formulir Proyek, Pengalaman, dan Edukasi dengan validasi dan dialog ringkasan.',
                    ),
                    const _FeatureRow(
                      icon: Icons.info_outline,
                      text: 'Halaman Tentang untuk informasi aplikasi.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Dibuat dengan Flutter dan Dart untuk Individual Assignment 8 PBP.',
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 64.0,
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(child: Text(value)),
      ],
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20.0, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12.0),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
