Pod::Spec.new do |s|
  s.name             = 'RCTemplate'
  s.version          = '0.1.0'
  s.summary          = 'A short description of RCTemplate.'
  s.homepage         = 'https://github.com/rccrx/RCTemplate'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rccrx' => 'rccrx@qq.com' }
  s.source           = { :git => 'https://github.com/rccrx/RCTemplate.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'Classes/**/*'
  s.prefix_header_file = 'Classes/RCTemplate-prefix.pch'
  s.resource_bundles = { 'RCTemplate' => ['Assets/**/*'] }
  
  s.dependency 'RCUtility'
  s.dependency 'RCNetwork'
  s.dependency 'RCCommonUI'
  
  s.dependency 'Masonry', '~> 1.1.0'
  s.dependency 'SDWebImage', '~> 5.12.0'
  s.dependency 'YYModel', '~> 1.0.4'
  s.dependency 'MJRefresh', '~> 3.7.2'
end
