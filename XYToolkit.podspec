#
# Be sure to run `pod lib lint XYToolkit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XYToolkit'
  s.version          = '1.0.0'
  s.summary          = 'XYToolkit工具集合库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                       工具集合库，开发中使用的一些扩展、自定义控件的工具集合库。
                       DESC

  s.homepage         = 'https://github.com/MWTsao/XYToolkit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MWTsao' => '545663610@qq.com' }
  s.source           = { :git => 'https://github.com/MWTsao/XYToolkit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'XYToolkit/Classes/*.{h,m}'
#  s.subspec 'Tools' do |ss|
#        ss.source_files = "XYToolkit", 'XYToolkit/Classes/Tools/*.{h,m}'
#    end
  
  # s.resource_bundles = {
  #   'XYToolkit' => ['XYToolkit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
