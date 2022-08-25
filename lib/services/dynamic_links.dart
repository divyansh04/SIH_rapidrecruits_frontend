import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:package_info/package_info.dart';

class DynamicLinkService {
  Future<Uri> createDynamicLink(int vacId) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print(packageInfo.packageName);
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://rapidrecruits.page.link',
      link: Uri.parse('https://rapidrecruits.page.link/?vacId=$vacId'),
      androidParameters: AndroidParameters(
        fallbackUrl: Uri.parse('https://www.google.com/'),
        packageName: packageInfo.packageName,
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'your_ios_bundle_identifier',
        minimumVersion: '1',
        appStoreId: 'your_app_store_id',
      ),
    );
    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    final Uri shortUrl = shortDynamicLink.shortUrl;
    return shortUrl;
  }
}
