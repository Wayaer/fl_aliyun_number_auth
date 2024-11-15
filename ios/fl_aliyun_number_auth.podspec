#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint fl_aliyun_number_auth.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'fl_aliyun_number_auth'
  s.version          = '0.0.1'
  s.summary          = 'aliyun number auth for flutter'
  s.description      = <<-DESC
aliyun number auth for flutter
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'SDWebImage'
  s.dependency 'MJExtension'
  s.dependency 'MBProgressHUD'
  s.platform = :ios, '13.0'
  s.vendored_frameworks = 'Frameworks/*.framework'
  s.resource = 'Frameworks/ATAuthSDK.framework/ATAuthSDK.bundle'
#   s.framework = 'Network'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'fl_aliyun_number_auth_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
