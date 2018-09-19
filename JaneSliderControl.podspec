Pod::Spec.new do |s|
  s.name          = "JaneSliderControl"
  s.version       = "2.0.0"
  s.summary       = "The Jane Slider Control is a simple subclass of UIControl similar to slide to unlock"
  s.homepage      = "https://github.com/jane/JaneSliderControl"
  s.license       = 'MIT'
  s.author        = { "Jane" => "ios@jane.com" }
  s.platform      = :ios, "11.0"
  s.swift_version = "4.2"
  s.source        = { :git => "https://github.com/jane/JaneSliderControl.git", :tag => "2.0.0" }
  s.source_files  = "JaneSliderControl/SliderControl/*.swift"
end
