class Session {
  static String? token;
  static Map<String, dynamic>? user;

  static bool get loggedIn => token != null;

  static void start({
    required String token,
    required Map<String, dynamic> user,
  }) {
    Session.token = token;
    Session.user = user;
  }

  static void clear() {
    token = null;
    user = null;
  }
}