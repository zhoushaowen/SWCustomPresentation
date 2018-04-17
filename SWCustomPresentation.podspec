Pod::Spec.new do |s|

  s.name         = "SWCustomPresentation"

  s.version      = "0.0.4"

  s.homepage      = 'https://github.com/zhoushaowen/SWCustomPresentation'

  s.ios.deployment_target = '8.0'

  s.summary      = "封装modal转场动画."

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "Zhoushaowen" => "348345883@qq.com" }

  s.source       = { :git => "https://github.com/zhoushaowen/SWCustomPresentation.git", :tag => s.version }
  
  s.source_files  = "SWCustomPresentation/SWCustomPresentation/*.{h,m}"
  
  s.requires_arc = true



end