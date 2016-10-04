#
# Be sure to run `pod lib lint AGFlowRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AGFlowRouter'
  s.version          = '0.1.1'
  s.summary          = 'Library, that allows you to manage you screens without any pain =)'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC

Library, that allows you to manage you screens without any pain =)
Try it using
pod 'AGFlowRouter'

                       DESC

  s.homepage         = 'https://github.com/x401om/AGFlowRouter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Aleksey Goncharov' => 'x401om@gmail.com' }
  s.source           = { :git => 'https://github.com/x401om/AGFlowRouter.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AGFlowRouter/Classes/**/*'

  # s.resource_bundles = {
  #   'AGFlowRouter' => ['AGFlowRouter/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'PureLayout', '= 3.0.2'
end
