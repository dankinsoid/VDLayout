#
# Be sure to run `pod lib lint VDUIExtensions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VDLayout'
  s.version          = '1.0.2'
  s.summary          = 'A short description of VDLayout.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/dankinsoid/VDLayout'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Voidilov' => 'voidilov@gmail.com' }
  s.source           = { :git => 'https://github.com/dankinsoid/VDLayout.git', :tag => s.version.to_s }

  s.platform = :ios, '11.0'
  s.ios.deployment_target = '11.0'
  s.swift_versions = '5.1'
  s.source_files = 'Sources/VDLayout/*'
  s.frameworks = 'UIKit'
  s.dependency 'ConstraintsOperators'
  s.dependency 'VD'
  s.dependency 'RxSwift', '~> 5.0'
  s.dependency 'RxCocoa', '~> 5.0'
end
