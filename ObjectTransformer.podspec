Pod::Spec.new do |s|
  s.name               = "ObjectTransformer"
  s.version            = "0.1"
  s.summary            = "A Swift library for transforming objects however you would like."
  s.homepage           = "https://github.com/mpiccinato/ObjectTransformer"
  s.license            = "MIT"
  s.author             = { "Mathew Piccinato" => "mpiccinato@gmail.com" }
  s.social_media_url   = "http://twitter.com/mpiccinato"
  s.platform           = :ios
  s.platform           = :ios, "8.0"
  s.source             = { :git => "https://github.com/mpiccinato/ObjectTransformer.git", :tag => "0.1" }
  s.source_files       = "Source/**/*.swift"
end
