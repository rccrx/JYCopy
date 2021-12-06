Pod::Spec.new do |s|
  s.name             = 'RCNetwork'
  s.version          = '0.1.0'
  s.summary          = 'A short description of RCNetwork.'
  s.homepage         = 'https://github.com/rccrx/RCNetwork'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rccrx' => 'rccrx@qq.com' }
  s.source           = { :git => 'https://github.com/rccrx/RCNetwork.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'Classes/**/*'
  
  s.dependency 'AFNetworking', '~> 4.0.1'
end
