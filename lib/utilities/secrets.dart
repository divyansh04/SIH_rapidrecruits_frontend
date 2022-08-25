
class Secret {
  static const ANDROID_CLIENT_ID =
      "1022063620007-04941n0vfec7gbh9str6jl6pqldf3k7v.apps.googleusercontent.com";
  static const IOS_CLIENT_ID = "<enter your iOS client secret>";

  static String getId() => Secret.ANDROID_CLIENT_ID;
  // Platform.isAndroid ? Secret.ANDROID_CLIENT_ID : Secret.IOS_CLIENT_ID;
}
