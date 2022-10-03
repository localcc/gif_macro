//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import bitsdojo_window_macos
import hid_listener
import isar_flutter_libs
import package_info_plus_macos
import path_provider_macos
import screen_retriever
import sqflite
import window_manager

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  BitsdojoWindowPlugin.register(with: registry.registrar(forPlugin: "BitsdojoWindowPlugin"))
  HidListenerPlugin.register(with: registry.registrar(forPlugin: "HidListenerPlugin"))
  IsarFlutterLibsPlugin.register(with: registry.registrar(forPlugin: "IsarFlutterLibsPlugin"))
  FLTPackageInfoPlusPlugin.register(with: registry.registrar(forPlugin: "FLTPackageInfoPlusPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  ScreenRetrieverPlugin.register(with: registry.registrar(forPlugin: "ScreenRetrieverPlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
  WindowManagerPlugin.register(with: registry.registrar(forPlugin: "WindowManagerPlugin"))
}
