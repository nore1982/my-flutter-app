class Country {
  final String name;
  final String code;
  final String dialCode;
  final List<String> cities;

  Country({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.cities,
  });
}

final List<Country> arabCountries = [
  Country(
    name: 'ليبيا',
    code: 'LY',
    dialCode: '+218',
    cities: [
      'طرابلس', 'بنغازي', 'المرج', 'مصراتة', 'الزاوية', 'سبها', 'البيضاء', 'زليتن',
      'درنة', 'طبرق', 'غريان', 'سرت', 'الخمس', 'أجدابيا', 'صرمان', 'زوارة', 'نالوت',
      'غدامس', 'مرزق', 'أوباري', 'غات', 'الكفرة', 'بني وليد', 'ترهونة', 'مسلاتة',
      'الجفرة', 'الشاطئ', 'القبة', 'شحات'
    ],
  ),
  Country(
    name: 'مصر',
    code: 'EG',
    dialCode: '+20',
    cities: ['القاهرة', 'الإسكندرية', 'الجيزة', 'المنصورة', 'طنطا', 'بورسعيد', 'أسيوط', 'أسوان'],
  ),
  Country(
    name: 'تونس',
    code: 'TN',
    dialCode: '+216',
    cities: ['تونس العاصمة', 'سوسة', 'صفاقس', 'بنزرت', 'القيروان', 'قابس', 'المنستير'],
  ),
  Country(
    name: 'السعودية',
    code: 'SA',
    dialCode: '+966',
    cities: ['الرياض', 'جدة', 'مكة المكرمة', 'المدينة المنورة', 'الدمام', 'الخبر', 'أبها', 'تبوك'],
  ),
  Country(
    name: 'الإمارات',
    code: 'AE',
    dialCode: '+971',
    cities: ['دبي', 'أبوظبي', 'الشارقة', 'العين', 'عجمان', 'رأس الخيمة'],
  ),
  Country(
    name: 'الجزائر',
    code: 'DZ',
    dialCode: '+213',
    cities: ['الجزائر العاصمة', 'وهران', 'قسنطينة', 'عنابة', 'سطيف'],
  ),
  Country(
    name: 'المغرب',
    code: 'MA',
    dialCode: '+212',
    cities: ['الدار البيضاء', 'الرباط', 'مراكش', 'طنجة', 'فاس', 'أكادير'],
  ),
  Country(
    name: 'الأردن',
    code: 'JO',
    dialCode: '+962',
    cities: ['عمان', 'إربد', 'الزرقاء', 'العقبة', 'السلط'],
  ),
  Country(
    name: 'العراق',
    code: 'IQ',
    dialCode: '+964',
    cities: ['بغداد', 'البصرة', 'أربيل', 'الموصل', 'النجف', 'كربلاء'],
  ),
];