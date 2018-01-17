Pod::Spec.new do |s|
  s.name         = "OLEContainerScrollView"
  s.version      = "0.0.1"
  s.summary      = "A UIScrollView subclass that intelligently handles multiple child scroll views and does not interfere with UIKitʼs cell reuse functionality."
  s.homepage     = "http://oleb.net/blog/2014/05/scrollviews-inside-scrollviews/"
  s.license      = "MIT"
  s.author       = { "Ole Begemann" => "ole@oleb.net" }
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/eyeem/OLEContainerScrollView", :branch => "eyeem-modifications" }
	s.source_files  = "OLEContainerScrollView/**/*.{h,m}"
	s.frameworks = 'UIKit'
end
