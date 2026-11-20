import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/education.dart';
import 'package:myportofolio_mobile/utils/validators.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/summary_dialog.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _qualificationController = TextEditingController();
  final _institutionController = TextEditingController();
  final _startYearController = TextEditingController();
  final _endYearController = TextEditingController();

  bool _isOngoing = false;

  @override
  void dispose() {
    _qualificationController.dispose();
    _institutionController.dispose();
    _startYearController.dispose();
    _endYearController.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      counterText: '',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
    );
  }

  void _setOngoing(bool value) {
    setState(() {
      _isOngoing = value;
      if (value) {
        _endYearController.clear();
      }
    });
  }

  String? _validateEndYear(String? value) {
    if (_isOngoing) {
      return null;
    }
    final error = Validators.year(value, 'Tahun selesai');
    if (error != null) {
      return error;
    }
    final startYear = int.tryParse(_startYearController.text.trim());
    final endYear = int.parse(value!.trim());
    if (startYear != null && endYear < startYear) {
      return 'Tahun selesai tidak boleh sebelum tahun mulai!';
    }
    return null;
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _qualificationController.clear();
    _institutionController.clear();
    _startYearController.clear();
    _endYearController.clear();
    setState(() {
      _isOngoing = false;
    });
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final education = Education(
      qualification: _qualificationController.text.trim(),
      institution: _institutionController.text.trim(),
      startYear: int.parse(_startYearController.text.trim()),
      endYear: _isOngoing ? null : int.parse(_endYearController.text.trim()),
    );

    await showSummaryDialog(
      context: context,
      title: 'Edukasi berhasil disimpan!',
      entries: {
        'Kualifikasi': education.qualification,
        'Institusi': education.institution,
        'Periode': education.period,
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
          'Add Education Form',
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
                      controller: _qualificationController,
                      decoration: _decoration(
                        'Kualifikasi',
                        hint: 'Contoh: S1 Ilmu Komputer',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) => Validators.required(
                        value,
                        'Kualifikasi',
                        maxLength: Education.qualificationMaxLength,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _institutionController,
                      decoration: _decoration(
                        'Institusi',
                        hint: 'Contoh: Universitas Indonesia',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) => Validators.required(
                        value,
                        'Institusi',
                        maxLength: Education.institutionMaxLength,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _startYearController,
                      decoration: _decoration('Tahun Mulai', hint: '2025'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 4,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          Validators.year(value, 'Tahun mulai'),
                    ),
                    const SizedBox(height: 8.0),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Masih berlangsung'),
                      subtitle: const Text(
                        'Aktifkan jika pendidikan ini belum selesai',
                      ),
                      value: _isOngoing,
                      onChanged: _setOngoing,
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _endYearController,
                      enabled: !_isOngoing,
                      decoration: _decoration(
                        'Tahun Selesai',
                        hint: _isOngoing ? 'Present' : '2029',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 4,
                      validator: _validateEndYear,
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
