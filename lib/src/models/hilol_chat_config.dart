/*

  Created by: Bakhromjon Polat
  Created on: Nov 28 2025 09:35:56

*/

import 'package:fcrm_chat_sdk/fcrm_chat_sdk.dart';
import 'package:flutter/material.dart';

class HilolChatConfig extends ChatConfig {
  final String? defaultEndpoint;

  /// Navigator key used to insert the notification overlay.
  /// Should be the same key passed to [MaterialApp.navigatorKey].
  final GlobalKey<NavigatorState>? navigatorKey;

  /// Called when the user taps the in-app notification banner.
  /// Use this to navigate to [HilolChatPage] with your app's router.
  final void Function()? onNotificationTap;

  HilolChatConfig({
    required super.baseUrl,
    required super.companyToken,
    required super.appKey,
    required super.appSecret,
    super.socketUrl,
    super.enableLogging,
    super.connectionTimeout,
    this.defaultEndpoint,
    this.navigatorKey,
    this.onNotificationTap,
  });
}
