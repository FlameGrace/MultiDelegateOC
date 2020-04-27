#
#  Be sure to run `pod spec lint MultiDelegateOC.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "MultiDelegateOC"
  s.version      = "0.0.7"
  s.summary      = "It can provide a multi delegate model for iOS and OSX."
  s.homepage     = "https://github.com/FlameGrace/MultiDelegateOC"
  s.license      = "BSD"
  s.author             = { "FlameGrace" => "flamegrace@hotmail.com" }
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'
  s.source       = { :git => "https://github.com/FlameGrace/MultiDelegateOC.git", :tag => "0.0.7" }
  s.source_files  = "MultiDelegateOC", "MultiDelegateOC/**/*.{h,m}"
  s.public_header_files = "MultiDelegateOC/**/*.h"
end
