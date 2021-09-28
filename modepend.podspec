#
# Be sure to run `pod lib lint modepend.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'modepend'
  s.version          = '0.1.0'
  s.summary          = 'A short description of modepend.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/zhuxietong@me.com/modepend'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhuxietong@me.com' => 'zhuxietong@me.com' }
  s.source           = { :git => 'https://github.com/zhuxietong@me.com/modepend.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.3' }
  s.swift_versions = '5.3'

  s.subspec 'Base' do |lib|
      lib.name = 'Base'
      lib.source_files = [
      'modepend/Classes/**.{swift,h,m}',
      ]


  end
  
  s.subspec 'Kingfisher' do |lib|
      lib.ios.deployment_target = '12.0'
      lib.name = 'Kingfisher'
      lib.source_files = [
      'modepend/Classes/Kingfisher/**.{swift,h,m}',
      'modepend/Classes/Kingfisher/**/*.{swift,h,m}',
      ]
      lib.dependency 'modepend/Base'
      lib.dependency 'Kingfisher'

  end
  
  s.subspec 'SDWebImage' do |lib|
      lib.ios.deployment_target = '10.0'
      lib.name = 'SDWebImage'
      lib.source_files = [
      'modepend/Classes/SDWebImage/**.{swift,h,m}',
      'modepend/Classes/SDWebImage/**/*.{swift,h,m}',
      ]
      lib.dependency 'modepend/Base'
      lib.dependency 'SDWebImage'
  end
  s.default_subspec = 'Base'
end
