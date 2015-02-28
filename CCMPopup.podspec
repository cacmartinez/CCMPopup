#
# Be sure to run `pod lib lint CCMPopup.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CCMPopup"
  s.version          = "1.0.0"
  s.summary          = "The CCMPopup is a nice controller transition animation that makes the view pop from the middle of the screen"
  s.description      = <<-DESC
                        The CCMPopup is a nice controller transition animation that makes the view pop from the middle of the screen. It can be easily used with a segue right from storyboard, or with apples `presentViewController:animated:completion:` method, and dismissed just as easily with the `dismissViewControllerAnimated:completion:` method.

                       * Markdown format.
                       DESC
  s.homepage         = "https://github.com/cacmartinez/CCMPopup"
  s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'APACHE 2.0'
  s.author           = { "Carlos Compean" => "ccompean@icalialabs.com" }
  s.source           = { :git => "https://github.com/cacmartinez/CCMPopup.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'CCMPopup' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
