Pod::Spec.new do |s|
  s.name             = 'RCUtility'
  s.version          = '0.1.0'
  s.summary          = 'A short description of RCUtility.'
  s.homepage         = 'https://github.com/rccrx/RCUtility'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rccrx' => 'rccrx@qq.com' }
  s.source           = { :git => 'https://github.com/rccrx/RCUtility.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'Classes/**/*'
end
