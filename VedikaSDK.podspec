# CocoaPods spec for the Vedika Swift SDK (the VedikaSDK product).
#
# It ships VedikaSDK only: the API client, the Vastu service and the AR view. VedikaRoomCapture is a second
# SwiftPM module that imports VedikaSDK; CocoaPods merges a pod into one module, so that import cannot resolve
# and room capture stays SwiftPM only.
#
# The version is the git tag on github.com/vedika-io/vedika-sdk-swift. `pod lib lint` and `pod trunk push` need
# macOS and Xcode (see the PR that added this file for the exact commands).
Pod::Spec.new do |s|
  s.name         = 'VedikaSDK'
  s.version      = '1.4.2'
  s.summary      = 'Native Swift client for the Vedika astrology API: Vastu reviews, saved scans and the AR view.'
  s.description  = <<-DESC
    URLSession-only Swift client for the Vedika API, covering the Vastu surface and the offline AR view.
    No external dependencies. Room capture (VedikaRoomCapture) is available through Swift Package Manager.
  DESC
  s.homepage     = 'https://vedika.io/sdks'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Vedika Intelligence' => 'support@vedika.io' }
  s.source       = { :git => 'https://github.com/vedika-io/vedika-sdk-swift.git', :tag => s.version.to_s }
  s.documentation_url = 'https://vedika.io/guides/vastu-native/'

  s.swift_versions = ['5.9']
  s.ios.deployment_target = '15.0'
  s.osx.deployment_target = '12.0'

  s.source_files = 'Sources/VedikaSDK/**/*.swift'
  # A folder reference, not a glob, so the files stay inside `VastuRuntime/`.
  s.resource_bundles = { 'VedikaSDKResources' => ['Sources/VedikaSDK/Resources/VastuRuntime'] }
end
