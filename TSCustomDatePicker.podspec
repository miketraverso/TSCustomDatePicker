#
# Be sure to run `pod lib lint TSCustomDatePicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TSCustomDatePicker"
  s.version          = "1.0.0"
  s.summary          = "A customizable month/day/year picker."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC "Ever want to have a custom date picker where you can set the background color, font, font color, the start date and end date? OK, well I did so I created TSCustomDatePicker which allows you to create a custom date picker where you can set the background color, font, font color and start and end dates to select from."
                       DESC

  s.homepage         = "https://github.com/miketraverso/TSCustomDatePicker"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Michael Traverso" => "mike@traversoft.com" }
  s.source           = { :git => "https://github.com/miketraverso/TSCustomDatePicker.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/traversoft'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'TSCustomDatePicker' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
