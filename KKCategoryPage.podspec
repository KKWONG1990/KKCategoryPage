#
# Be sure to run `pod lib lint KKCategoryPage.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KKCategoryPage'
  s.version          = '1.0.0'
  s.summary          = 'KKCategoryPage是一个分类列表页'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  KKCategoryPage是一个基于添加子控制器达到分类效果的页面
                       DESC

  s.homepage         = 'https://github.com/KKWONG1990/KKCategoryPage'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kkwong90' => 'kkwong90@163.com' }
  s.source           = { :git => 'https://github.com/KKWONG1990/KKCategoryPage.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'KKCategoryPage/Classes/**/*'
  
  #是否支持ARC
  s.requires_arc = true
  
  # s.resource_bundles = {
  #   'KKCategoryPage' => ['KKCategoryPage/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
