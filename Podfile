# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'TekoProduct' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'netfox'
  pod 'ObjectMapper'
  pod 'Networkable'
  pod 'RxCocoa'
  pod 'SwifterSwift'
  pod 'SVPullToRefresh'
  pod 'IQKeyboardManagerSwift'
  pod 'Nuke'
  pod 'Nuke-WebP-Plugin'
  pod 'NVActivityIndicatorView', '4.8.0'
  pod 'ActionSheetPicker-3.0'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
    end

    # Mark fix build xcode 13
    installer.pods_project.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end

end
