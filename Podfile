# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

def main_pods
  use_frameworks!

  pod 'R.swift'
  pod 'XCGLogger'
  pod 'KeychainAccess'
  pod 'APIKit'
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'SVProgressHUD'
  pod 'DZNEmptyDataSet'
  pod 'SDCAlertView'
  pod 'SwiftyUserDefaults'
  pod 'ObjectMapper'
  pod 'FontAwesome.swift', :git => 'https://github.com/thii/FontAwesome.swift.git'
  pod 'MGSwipeTableCell'
  pod 'Toaster'
  pod 'Kingfisher'
  pod 'OAuthSwift'
  pod 'XLActionController/Twitter'
  pod 'PullToRefreshSwift'
  pod 'NSDate+TimeAgo'
end

target 'pi-chan2' do
  main_pods

end

post_install do |installer|
  puts("Update debug pod settings to speed up build time")
  Dir.glob(File.join("Pods", "**", "Pods*{debug,Private}.xcconfig")).each do |file|
    File.open(file, 'a') { |f| f.puts "\nDEBUG_INFORMATION_FORMAT = dwarf" }
  end
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end

