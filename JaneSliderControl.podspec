Pod::Spec.new do |s|
  s.name          = "JaneSliderControl"
  s.version       = "1.0.2"
  s.summary       = "The Jane Slider Control is a simple subclass of UIControl similar to slide to unlock"
  s.homepage      = "https://github.com/jane/JaneSliderControl"
  s.license       = 'MIT'
  s.author        = { "Jane" => "barlow@jane.com" }
  s.platform      = :ios, "9.0"
  s.source        = { :git => "https://github.com/jane/JaneSliderControl.git", :tag => "1.0.2" }
  s.source_files  = "JaneSliderControl/SliderControl/*.swift"
end
