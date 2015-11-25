Pod::Spec.new do |s|
  s.name             = "PayMayaSDK"
  s.version          = "0.1.1"
  s.summary          = "Easily enable your iOS app to accept credit and debit card payments"

  s.description      = <<-DESC
                       The PayMaya iOS SDK is a library that allows you to easily add credit and debit card as payment options to your mobile application.
                       DESC

  s.homepage         = "https://github.com/PayMaya/Checkout-SDK-iOS"
  s.license = {
                :type => 'Commercial',
                :text => <<-LICENSE
                        All text and design is copyright © Voyager Innovations, Inc.
                        All rights reserved.
                LICENSE
        }
  s.author           = { "PayMaya Engineering" => "paymayadevs@voyager.ph" }
  s.source           = { :git => "https://github.com/PayMaya/Checkout-SDK-iOS.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.frameworks = 'UIKit'

  # If using static library
  s.source_files = '**/*.{h,m}'
  s.public_header_files = '**/*.h'
  s.vendored_library = '**/*.a'
  # If using framework
  #s.source_files = '**/*.{h,m}'
  #s.vendored_frameworks = '**/*.framework'
end
