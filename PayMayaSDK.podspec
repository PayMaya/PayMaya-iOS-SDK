Pod::Spec.new do |s|
  s.name             = "PayMayaSDK"
  s.version          = "0.3.8"
  s.summary          = "Easily enable your iOS app to accept credit and debit card payments"

  s.description      = <<-DESC
                       The PayMaya iOS SDK is a library that allows you to easily add credit and debit card as payment options to your mobile application.
                       DESC

  s.homepage         = "https://github.com/PayMaya/PayMaya-iOS-SDK"
  s.license          = "MIT"
  s.author           = { "PayMaya Engineering" => "paymayadevs@voyager.ph" }
  s.source           = { :git => "https://github.com/PayMaya/PayMaya-iOS-SDK.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.frameworks = 'UIKit'

  s.source_files = 'Pod/Classes/**/*.{h,m}'
end
