import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/utils/date_format.dart';
import 'package:myportofolio_mobile/utils/validators.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/summary_dialog.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _organizationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _projectController = TextEditingController();
  final _technologiesController = TextEditingController();
  final _thumbnailController = TextEditingController();
  final _startedAtController = TextEditingController();
  final _endedAtController = TextEditingController();

  String _category = Experience.defaultCategory;
  DateTime? _startedAt;
  DateTime? _endedAt;
  bool _isOngoing = false;

  @override
  void dispose() {
    _titleController.dispose();
    _organizationController.dispose();
    _descriptionController.dispose();
    _projectController.dispose();
    _technologiesController.dispose();
    _thumbnailController.dispose();
    _startedAtController.dispose();
    _endedAtController.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String label, {String? hint, Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      suffixIcon: suffix,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
    );
  }

  Future<void> _pickStartedAt() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startedAt ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      helpText: 'Pilih tanggal mulai',
    );
    if (picked == null) {
      return;
    }
    setState(() {
      _startedAt = picked;
      _startedAtController.text = formatDate(picked);
    });
  }

  Future<void> _pickEndedAt() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endedAt ?? _startedAt ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      helpText: 'Pilih tanggal selesai',
    );
    if (picked == null) {
      return;
    }
    setState(() {
      _endedAt = picked;
      _endedAtController.text = formatDate(picked);
    });
  }

  void _setOngoing(bool value) {
    setState(() {
      _isOngoing = value;
      if (value) {
        _endedAt = null;
        _endedAtController.clear();
      }
    });
  }

  String? _validateStartedAt(String? _) {
    if (_startedAt == null) {
      return 'Tanggal mulai wajib dipilih!';
    }
    return null;
  }

  String? _validateEndedAt(String? _) {
    if (_isOngoing) {
      return null;
    }
    final startedAt = _startedAt;
    final endedAt = _endedAt;
    if (endedAt == null) {
      return 'Pilih tanggal selesai atau aktifkan "Masih berlangsung"!';
    }
    if (startedAt != null && endedAt.isBefore(startedAt)) {
      return 'Tanggal selesai tidak boleh sebelum tanggal mulai!';
    }
    return null;
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    for (final controller in [
      _titleController,
      _organizationController,
      _descriptionController,
      _projectController,
      _technologiesController,
      _thumbnailController,
      _startedAtController,
      _endedAtController,
    ]) {
      controller.clear();
    }
    setState(() {
      _category = Experience.defaultCategory;
      _startedAt = null;
      _endedAt = null;
      _isOngoing = false;
    });
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final experience = Experience(
      title: _titleController.text.trim(),
      organization: _organizationController.text.trim(),
      description: _descriptionController.text.trim(),
      project: _projectController.text.trim(),
      technologies: _technologiesController.text.trim(),
      category: _category,
      thumbnail: _thumbnailController.text.trim(),
      startedAt: _startedAt!,
      endedAt: _isOngoing ? null : _endedAt,
    );

    String orDash(String value) => value.isEmpty ? '-' : value;

    await showSummaryDialog(
      context: context,
      title: 'Pengalaman berhasil disimpan!',
      entries: {
        'Judul': experience.title,
        'Organisasi': experience.organization,
        'Kategori': experience.categoryLabel,
        'Deskripsi': experience.description,
        'Proyek': orDash(experience.project),
        'Teknologi': orDash(experience.tags.join(', ')),
        'Thumbnail': orDash(experience.thumbnail),
        'Periode': experience.period,
      },
    );

    if (mounted) {
      _resetForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Experience Form',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: _decoration(
                        'Judul / Posisi',
                        hint: 'Contoh: Software Engineer Intern',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) => Validators.required(
                        value,
                        'Judul',
                        maxLength: Experience.titleMaxLength,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _organizationController,
                      decoration: _decoration(
                        'Organisasi',
                        hint: 'Contoh: Fasilkom UI',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) => Validators.required(
                        value,
                        'Organisasi',
                        maxLength: Experience.organizationMaxLength,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      initialValue: _category,
                      decoration: _decoration('Kategori'),
                      items: Experience.categories.entries
                          .map(
                            (entry) => DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _category = value ?? Experience.defaultCategory;
                        });
                      },
                      validator: (value) =>
                          Experience.categories.containsKey(value)
                          ? null
                          : 'Kategori tidak valid!',
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: _decoration(
                        'Deskripsi',
                        hint: 'Ceritakan peran dan kontribusimu',
                      ),
                      minLines: 3,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      validator: (value) =>
                          Validators.required(value, 'Deskripsi'),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _projectController,
                      decoration: _decoration(
                        'Proyek (opsional)',
                        hint: 'Nama proyek yang dikerjakan',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) => Validators.maxLength(
                        value,
                        'Proyek',
                        Experience.projectMaxLength,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _technologiesController,
                      decoration: _decoration(
                        'Teknologi (opsional)',
                        hint: 'Contoh: Flutter, Django, PostgreSQL',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) => Validators.maxLength(
                        value,
                        'Teknologi',
                        Experience.technologiesMaxLength,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _thumbnailController,
                      decoration: _decoration(
                        'URL Thumbnail (opsional)',
                        hint: 'https://example.com/gambar.png',
                      ),
                      keyboardType: TextInputType.url,
                      autocorrect: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      validator: (value) => Validators.optionalUrl(
                        value,
                        'URL thumbnail',
                        max: Experience.thumbnailMaxLength,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _startedAtController,
                      readOnly: true,
                      decoration: _decoration(
                        'Tanggal Mulai',
                        hint: 'Pilih tanggal',
                        suffix: const Icon(Icons.calendar_today_outlined),
                      ),
                      onTap: _pickStartedAt,
                      validator: _validateStartedAt,
                    ),
                    const SizedBox(height: 8.0),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Masih berlangsung'),
                      subtitle: const Text(
                        'Aktifkan jika pengalaman ini belum selesai',
                      ),
                      value: _isOngoing,
                      onChanged: _setOngoing,
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _endedAtController,
                      readOnly: true,
                      enabled: !_isOngoing,
                      decoration: _decoration(
                        'Tanggal Selesai',
                        hint: _isOngoing ? 'Present' : 'Pilih tanggal',
                        suffix: const Icon(Icons.event_available_outlined),
                      ),
                      onTap: _pickEndedAt,
                      validator: _validateEndedAt,
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(48.0),
                      ),
                      onPressed: _submit,
                      child: const Text('Simpan'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
