Pod::Spec.new do |s|
  s.name             = 'petrovich'
  s.version          = '0.1.5'
  s.summary          = 'Simple iOS/macOS library for cyrillic names declension written in swift.'
  s.homepage         = 'https://github.com/SDanny/petrovich'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SDanny' => 'bluesbastards@gmail.com' }
  
  s.source           = { :git => 'https://github.com/SDanny/petrovich.git', :tag => s.version.to_s }
  s.source_files = 'src'

  s.resources = 'src/assets/*'
  s.resource_bundles = {
    'Petrovich' => [
        'src/assets/*'
    ]
  }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
end