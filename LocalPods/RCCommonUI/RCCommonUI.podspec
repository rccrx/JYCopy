Pod::Spec.new do |s|
  s.name             = 'RCCommonUI'
  s.version          = '0.1.0'
  s.summary          = 'A short description of RCCommonUI.'
  s.homepage         = 'https://github.com/rccrx/RCCommonUI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rccrx' => 'rccrx@qq.com' }
  s.source           = { :git => 'https://github.com/rccrx/RCCommonUI.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'Classes/**/*'
  
  s.dependency 'MBProgressHUD', '~> 1.2.0'
end
