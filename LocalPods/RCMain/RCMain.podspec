Pod::Spec.new do |s|
  s.name             = 'RCMain'
  s.version          = '0.1.0'
  s.summary          = 'A short description of RCMain.'
  s.homepage         = 'https://github.com/rccrx/RCMain'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rccrx' => 'rccrx@qq.com' }
  s.source           = { :git => 'https://github.com/rccrx/RCMain.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'Classes/**/*'
  s.resource_bundles = { 'RCMain' => ['Assets/**/*'] }
  s.prefix_header_file = 'Classes/RCMain-prefix.pch'
  s.public_header_files = 'Classes/Public/**/*.h'
  
  s.dependency 'RCUtility'
end
