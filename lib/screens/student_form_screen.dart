// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

class StudentFormScreen extends StatefulWidget {
  const StudentFormScreen({super.key});

  @override
  State<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  // Key for the Form
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();

  // State Variables
  bool agreeToTerms = false;
  String? gender;
  bool notificationsEnabled = false;
  double experience = 5.0;
  RangeValues ageRange = const RangeValues(18, 30);
  String? city;
  String? language;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    specializationController.dispose();
    super.dispose();
  }

  // Handle Form Submission
  void _submitForm() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _showSuccessDialog();
    }
  }

  // Show Success Alert Dialog
  void _showSuccessDialog() {
    final String fullName = nameController.text.trim().isEmpty
        ? 'لم يتم إدخاله'
        : nameController.text.trim();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'تم إرسال البيانات بنجاح',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Text(
                    'ملخص البيانات المدخلة:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const Divider(height: 20),
                  _buildSummaryRow(Icons.person, 'الاسم:', fullName),
                  _buildSummaryRow(Icons.email, 'البريد الإلكتروني:', emailController.text),
                  _buildSummaryRow(Icons.phone, 'رقم الهاتف:', phoneController.text),
                  _buildSummaryRow(Icons.school, 'التخصص:', specializationController.text),
                  _buildSummaryRow(
                    Icons.rule,
                    'الموافقة على الشروط:',
                    agreeToTerms ? 'تمت الموافقة' : 'غير موافق',
                  ),
                  _buildSummaryRow(Icons.person_outline, 'الجنس:', gender ?? 'غير محدد'),
                  _buildSummaryRow(
                    Icons.notifications,
                    'الإشعارات:',
                    notificationsEnabled ? 'مفعلة' : 'غير مفعلة',
                  ),
                  _buildSummaryRow(
                    Icons.work,
                    'سنوات الخبرة:',
                    '${experience.toInt()} سنوات',
                  ),
                  _buildSummaryRow(
                    Icons.cake,
                    'الفئة العمرية:',
                    '${ageRange.start.round()} - ${ageRange.end.round()}',
                  ),
                  _buildSummaryRow(Icons.location_city, 'المدينة:', city ?? 'غير محددة'),
                  _buildSummaryRow(Icons.language, 'اللغة:', language ?? 'غير محددة'),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('إغلاق'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Handle Form Reset
  void _resetForm() {
    setState(() {
      nameController.clear();
      emailController.clear();
      phoneController.clear();
      specializationController.clear();
      agreeToTerms = false;
      gender = null;
      notificationsEnabled = false;
      experience = 5.0;
      ageRange = const RangeValues(18, 30);
      city = null;
      language = null;
    });

    _formKey.currentState?.reset();

    nameController.clear();
    emailController.clear();
    phoneController.clear();
    specializationController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تمت إعادة تعيين النموذج بنجاح'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'نموذج بيانات الطالب',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 2,
          backgroundColor: theme.colorScheme.primaryContainer,
          foregroundColor: theme.colorScheme.onPrimaryContainer,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Card(
                  elevation: 6,
                  shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header Banner
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  theme.colorScheme.primary,
                                  theme.colorScheme.tertiary,
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'نموذج إدخال البيانات',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'تطبيق عملي على أدوات الإدخال والتحقق في Flutter',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withValues(alpha: 0.9),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // 1. TextField - الاسم الكامل
                          _buildSectionTitle('1. البيانات الشخصية'),
                          const SizedBox(height: 12),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'الاسم الكامل',
                              hintText: 'أدخل اسمك الكامل',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: theme.colorScheme.surfaceContainerLow,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // 2. TextFormField - البريد الإلكتروني
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'البريد الإلكتروني',
                              hintText: 'example@domain.com',
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: theme.colorScheme.surfaceContainerLow,
                            ),
                            validator: (value) {
                              return value!.contains('@') ? null : 'بريد غير صحيح';
                            },
                          ),
                          const SizedBox(height: 16),

                          // 3. TextFormField - رقم الهاتف
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'رقم الهاتف',
                              hintText: 'مكون من 10 أرقام (مثال: 7771234567)',
                              prefixIcon: const Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: theme.colorScheme.surfaceContainerLow,
                            ),
                            validator: (value) {
                              return value!.length == 10 ? null : 'رقم غير صحيح';
                            },
                          ),
                          const SizedBox(height: 16),

                          // 4. TextFormField - التخصص
                          TextFormField(
                            controller: specializationController,
                            decoration: InputDecoration(
                              labelText: 'التخصص',
                              hintText: 'أدخل تخصصك الأكاديمي',
                              prefixIcon: const Icon(Icons.school),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: theme.colorScheme.surfaceContainerLow,
                            ),
                            validator: (value) {
                              return value!.isEmpty ? 'مطلوب' : null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // 5. Checkbox - أوافق على الشروط والأحكام
                          _buildSectionTitle('2. الشروط والأحكام والجنس'),
                          const SizedBox(height: 12),
                          FormField<bool>(
                            initialValue: agreeToTerms,
                            validator: (value) {
                              return value == true ? null : 'وافق على الشروط';
                            },
                            builder: (FormFieldState<bool> state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.surfaceContainerLow,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: state.hasError
                                            ? theme.colorScheme.error
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    child: CheckboxListTile(
                                      title: const Text(
                                        'أوافق على الشروط والأحكام',
                                        style: TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                      value: state.value,
                                      onChanged: (val) {
                                        state.didChange(val);
                                        setState(() {
                                          agreeToTerms = val ?? false;
                                        });
                                      },
                                      activeColor: theme.colorScheme.primary,
                                      controlAffinity: ListTileControlAffinity.leading,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  if (state.hasError)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12.0, top: 6.0),
                                      child: Text(
                                        state.errorText!,
                                        style: TextStyle(
                                          color: theme.colorScheme.error,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // 6. Radio - الجنس
                          FormField<String>(
                            initialValue: gender,
                            validator: (value) {
                              return value != null ? null : 'اختر الجنس';
                            },
                            builder: (FormFieldState<String> state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.surfaceContainerLow,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: state.hasError
                                            ? theme.colorScheme.error
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.people_outline, size: 20),
                                            SizedBox(width: 8),
                                            Text(
                                              'الجنس',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: RadioListTile<String>(
                                                title: const Text('ذكر'),
                                                value: 'ذكر',
                                                groupValue: state.value,
                                                onChanged: (val) {
                                                  state.didChange(val);
                                                  setState(() {
                                                    gender = val;
                                                  });
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: RadioListTile<String>(
                                                title: const Text('أنثى'),
                                                value: 'أنثى',
                                                groupValue: state.value,
                                                onChanged: (val) {
                                                  state.didChange(val);
                                                  setState(() {
                                                    gender = val;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (state.hasError)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12.0, top: 6.0),
                                      child: Text(
                                        state.errorText!,
                                        style: TextStyle(
                                          color: theme.colorScheme.error,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 24),

                          // 7. Switch - تفعيل الإشعارات
                          _buildSectionTitle('3. التفضيلات الإضافية'),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: SwitchListTile(
                              title: const Text(
                                'تفعيل الإشعارات',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                notificationsEnabled ? 'مفعلة' : 'غير مفعلة',
                                style: TextStyle(
                                  color: notificationsEnabled
                                      ? Colors.green.shade700
                                      : Colors.red.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              secondary: const Icon(Icons.notifications_active_outlined),
                              value: notificationsEnabled,
                              onChanged: (val) {
                                setState(() {
                                  notificationsEnabled = val;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 16),

                          // 8. Slider - سنوات الخبرة
                          FormField<double>(
                            initialValue: experience,
                            validator: (value) {
                              final val = value ?? 0;
                              return val >= 0 && val <= 10 ? null : 'خارج النطاق';
                            },
                            builder: (FormFieldState<double> state) {
                              final val = state.value ?? 5.0;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.surfaceContainerLow,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: state.hasError
                                            ? theme.colorScheme.error
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Row(
                                              children: [
                                                Icon(Icons.work_history_outlined, size: 20),
                                                SizedBox(width: 8),
                                                Text(
                                                  'سنوات الخبرة',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: theme.colorScheme.primaryContainer,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                'سنوات الخبرة: ${val.toInt()}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: theme.colorScheme.onPrimaryContainer,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Slider(
                                          value: val,
                                          min: 0,
                                          max: 10,
                                          divisions: 10,
                                          label: '${val.toInt()}',
                                          onChanged: (newValue) {
                                            state.didChange(newValue);
                                            setState(() {
                                              experience = newValue;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (state.hasError)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12.0, top: 6.0),
                                      child: Text(
                                        state.errorText!,
                                        style: TextStyle(
                                          color: theme.colorScheme.error,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // 9. RangeSlider - الفئة العمرية
                          FormField<RangeValues>(
                            initialValue: ageRange,
                            validator: (value) {
                              if (value == null) return 'نطاق غير صحيح';
                              return value.start < value.end ? null : 'نطاق غير صحيح';
                            },
                            builder: (FormFieldState<RangeValues> state) {
                              final range = state.value ?? const RangeValues(18, 30);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.surfaceContainerLow,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: state.hasError
                                            ? theme.colorScheme.error
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Row(
                                              children: [
                                                Icon(Icons.cake_outlined, size: 20),
                                                SizedBox(width: 8),
                                                Text(
                                                  'الفئة العمرية',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: theme.colorScheme.secondaryContainer,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                'العمر: ${range.start.round()} - ${range.end.round()}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: theme.colorScheme.onSecondaryContainer,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        RangeSlider(
                                          values: range,
                                          min: 0,
                                          max: 100,
                                          divisions: 100,
                                          labels: RangeLabels(
                                            '${range.start.round()}',
                                            '${range.end.round()}',
                                          ),
                                          onChanged: (newRange) {
                                            state.didChange(newRange);
                                            setState(() {
                                              ageRange = newRange;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (state.hasError)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12.0, top: 6.0),
                                      child: Text(
                                        state.errorText!,
                                        style: TextStyle(
                                          color: theme.colorScheme.error,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 24),

                          // 10. DropdownButton - المدينة
                          _buildSectionTitle('4. الموقع واللغة'),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            initialValue: city,
                            decoration: InputDecoration(
                              labelText: 'المدينة',
                              prefixIcon: const Icon(Icons.location_city),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: theme.colorScheme.surfaceContainerLow,
                            ),
                            hint: const Text('اختر مدينة'),
                            items: const [
                              DropdownMenuItem(value: 'صنعاء', child: Text('صنعاء')),
                              DropdownMenuItem(value: 'عدن', child: Text('عدن')),
                              DropdownMenuItem(value: 'تعز', child: Text('تعز')),
                              DropdownMenuItem(value: 'إب', child: Text('إب')),
                              DropdownMenuItem(value: 'الحديدة', child: Text('الحديدة')),
                              DropdownMenuItem(value: 'حضرموت', child: Text('حضرموت')),
                            ],
                            validator: (value) {
                              return value != null ? null : 'اختر مدينة';
                            },
                            onChanged: (val) {
                              setState(() {
                                city = val;
                              });
                            },
                          ),
                          const SizedBox(height: 16),

                          // 11. PopupMenuButton - اللغة
                          FormField<String>(
                            initialValue: language,
                            validator: (value) {
                              return value != null ? null : 'اختر لغة';
                            },
                            builder: (FormFieldState<String> state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'اللغة',
                                      prefixIcon: const Icon(Icons.language),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: theme.colorScheme.surfaceContainerLow,
                                      errorText: state.errorText,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          state.value ?? 'اختر اللغة من القائمة',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: state.value == null
                                                ? theme.hintColor
                                                : theme.textTheme.bodyLarge?.color,
                                          ),
                                        ),
                                        PopupMenuButton<String>(
                                          icon: const Icon(Icons.arrow_drop_down_circle),
                                          tooltip: 'اختر اللغة',
                                          onSelected: (val) {
                                            state.didChange(val);
                                            setState(() {
                                              language = val;
                                            });
                                          },
                                          itemBuilder: (context) => const [
                                            PopupMenuItem(
                                              value: 'العربية',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.check_circle_outline, size: 18),
                                                  SizedBox(width: 8),
                                                  Text('العربية'),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 'English',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.language, size: 18),
                                                  SizedBox(width: 8),
                                                  Text('English'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 32),

                          // Action Buttons: 12. ElevatedButton (إرسال) & 13. TextButton (إعادة تعيين)
                          Row(
                            children: [
                              // 12. ElevatedButton - إرسال
                              Expanded(
                                flex: 2,
                                child: ElevatedButton.icon(
                                  onPressed: _submitForm,
                                  icon: const Icon(Icons.send),
                                  label: const Text(
                                    'إرسال',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.primary,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 3,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // 13. TextButton - إعادة تعيين
                              Expanded(
                                flex: 1,
                                child: TextButton.icon(
                                  onPressed: _resetForm,
                                  icon: const Icon(Icons.refresh),
                                  label: const Text(
                                    'إعادة تعيين',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    foregroundColor: theme.colorScheme.error,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                        color: theme.colorScheme.error.withValues(alpha: 0.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 4,
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
