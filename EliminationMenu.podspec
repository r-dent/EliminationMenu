Pod::Spec.new do |s|
  s.name         = 'EliminationMenu'
  s.version      = '1.0.1'

  s.summary      = 'A menu that eliminates all values which were not selected.'
  s.author       = { 'Roman Gille' => 'developer@romangille.com' }
  s.homepage     = 'https://github.com/r-dent/EliminationMenu'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.source       = { :git => 'https://github.com/r-dent/EliminationMenu.git', :tag => "v#{s.version}" }
  s.source_files = 'Sources/*.swift'

  s.requires_arc = true
  s.frameworks = 'UIKit'

  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8'
end