Pod::Spec.new do |s|
  s.name             = 'NLab'
  s.version          = '0.1.9'
  s.summary          = 'Simple Networking framework in Swift.'
  s.homepage         = 'https://github.com/yasinkbas/NLab'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yasinkbas' => 'yasin.kbas12@gmail.com' }
  s.source           = { :git => 'https://github.com/yasinkbas/NLab.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'
  s.source_files = 'NLab/Classes/**/*'
end
