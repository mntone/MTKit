Pod::Spec.new do |spec|
	spec.name          = "MTKit"
	spec.version       = "0.9.2"
	spec.summary       = "MTKit (UIKit add-ons)"
	spec.description   = "UIKit extensions"
	spec.homepage      = "https://github.com/mntone/MTKit"
	spec.license       = "MIT license"
	spec.author        = { "mntone" => "mntone@outlook.jp" }
	spec.source        = { :git => "https://github.com/mntone/MTKit.git", :tag => "#{spec.version}" }
	spec.source_files  = "Sources/**/*.{h,c,m}"

	spec.frameworks             = 'Foundation', 'CoreGraphics'

	spec.ios.deployment_target  = '8.0'
	spec.ios.frameworks         = 'UIKit'

	spec.tvos.deployment_target = '9.0'
	spec.tvos.frameworks        = 'UIKit'
end
