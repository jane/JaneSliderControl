Pod::Spec.new do |s|
  s.name          = "JaneSliderControl"
  s.version       = "2.1.3"
  s.summary       = "The Jane Slider Control is a simple subclass of UIControl similar to slide to unlock"
  s.homepage      = "https://github.com/jane/JaneSliderControl"
  s.license       = 'MIT'
  s.author        = { "Jane" => "ios@jane.com" }
  s.platform      = :ios, "11.0"
  s.swift_version = "5.0"
  s.source        = { :git => "https://github.com/jane/JaneSliderControl.git", :tag => "2.1.2" }
  s.source_files  = "JaneSliderControl/SliderControl/*.swift"
end
