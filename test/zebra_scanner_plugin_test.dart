import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebra_scanner_plugin/zebra_scanner_plugin.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channelName = 'zebra_scanner_plugin';
  const MethodChannel channel = MethodChannel(channelName);

  setUp(() {
    // Intercept the method channel call and provide a mock response
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        if (methodCall.method == 'getPlatformVersion') {
          return '42';
        }
        return null;
      },
    );
  });

  tearDown(() {
    // Remove the mock method call handler
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      null,
    );
  });

  test('getPlatformVersion', () async {
    expect(await ZebraScannerPlugin.platformVersion, '42');
  });
}
