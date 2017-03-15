
Pod::Spec.new do |s|

  s.name         = "JHDynamicFont"
  s.version      = "0.0.1"
  s.summary      = "通过为UIFontDescriptor添加category方法实现动态改变指定控件（如UILabel UIButtonLabel等）的字体大小。"
  s.description  = <<-DESC
  通过为UIFontDescriptor添加category方法实现动态改变指定控件（如UILabel UIButtonLabel等）的字体大小!!!
                   DESC

  s.homepage     = "https://github.com/Shenjinghao/JHDynamicFont"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "shenjinghao" => "807880748@qq.com" }

  s.source       = { :git => "https://github.com/Shenjinghao/JHDynamicFont.git", :tag => "0.0.1" }

  s.source_files  = "Classes", "JHDynamicFont/Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.requires_arc = true
  s.platform     = :ios


end
