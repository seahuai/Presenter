

Pod::Spec.new do |s|

  s.name         = "Presenter"
  s.version      = "0.0.1"
  s.summary      = "自定义弹窗"
  s.description  = <<-DESC
  使用UIPresentationController自定义弹窗
                   DESC

  s.homepage     = "https://github.com/seahuai/Presenter.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "zhangsihuai" => "seahuai@foxmail.com" }
  s.platform     = :ios
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/seahuai/Presenter.git", :tag => "#{s.version}" }
  s.source_files  = "Presenter/Presenter/Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

end
