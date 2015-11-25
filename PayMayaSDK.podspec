Pod::Spec.new do |s|
  s.name             = "PayMayaSDK"
  s.version          = "0.1.0"
  s.summary          = "A short description of PayMayaSDK."

  s.description      = <<-DESC
                       A detailed description of PayMayaSDK.
                       DESC

  s.homepage         = "http://www.voyagerinnovation.com"
  s.license          = {
               :type => 'Commercial',
               :text => <<-LICENSE
                        All text and design is copyright © Voyager Innovations, Inc.
                        All rights reserved.
                        LICENSE
  }
  s.author           = { "Patrick Medina" => "pdmedina@voyagerinnovation.com" }
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
