class L10n {
  L10n(this.language);
  final String language;
  String get greeting => language == 'hi' ? 'नमस्ते, रमेश' : 'Hello, Ramesh';
  String get question => language == 'hi'
      ? 'आज आप क्या बना रहे हैं?'
      : 'What are you making today?';
  String get addProduct => language == 'hi' ? 'उत्पाद जोड़ें' : 'Add product';
  String get photoVoice => language == 'hi' ? 'फोटो + आवाज़' : 'Photo + Voice';
  String get upToDate => language == 'hi' ? 'सब अपडेट है' : 'Up to date';
}
