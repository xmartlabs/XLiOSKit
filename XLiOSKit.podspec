Pod::Spec.new do |s|

  s.name         = "XLiOSKit"
  s.version      = "0.8.0"
  s.license      = {
    :type => 'Copyright',
    :text => <<-LICENSE
      Copyright 2014 Xmartlabs. All rights reserved.
      LICENSE
  }
  s.homepage     = "http://xmartlabs.com"
  s.summary      = "Xmarltabs iOS development kit."
  s.description  = <<-DESC
                  Xmarltabs iOS development kit.
                   DESC
  s.author       = { 'Martin Barreto' => 'martin@xmartlabs.com', 'Miguel Revetria' => 'miguel@xmartlabs.com' }

  s.platform     = :ios
  
  s.subspec 'arc' do |sp|
    sp.source_files = 'XLiOSKit/**/*.{m,h}'
    sp.requires_arc = true
  end

  s.subspec 'no-arc' do |sp|
    sp.source_files = 'XLiOSKit_noARC/**/*.{h,m}'
    sp.requires_arc = false
    sp.compiler_flags = '-fno-objc-arc'
  end
  
  s.header_dir = 'XLKit'
  s.requires_arc = true
  s.ios.deployment_target = '7.0'
  s.ios.frameworks = 'CoreFoundation', 'Foundation', 'MobileCoreServices', 'Security', 'SystemConfiguration', 'AssetsLibrary'
end
