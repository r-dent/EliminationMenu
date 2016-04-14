Pod::Spec.new do |spec|
  spec.name         = 'RGEliminationMenu'
  spec.version      = '0.1.0'
  spec.license      = 'MIT'
  spec.summary      = 'An Objective-C client for the Pusher.com service'
  spec.homepage     = 'https://github.com/r-dent/RGEliminationMenu'
  spec.author       = 'Roman Gille'
  spec.source       = { :git => 'https://github.com/r-dent/RGEliminationMenu.git', :tag => "v#{s.version}" }
  spec.source_files = 'Sources/*.swift'
  spec.requires_arc = true
end