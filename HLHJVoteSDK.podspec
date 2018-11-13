


Pod::Spec.new do |s|

  s.name         = "HLHJVoteSDK"
  s.version      = "1.0.3"

  s.summary      = "投票投票投票投票"
  s.description  = <<-DESC
                   "投票投票投票投票"
                   DESC

  s.platform =   :ios, "9.0"
  s.ios.deployment_target = "9.0"

  s.homepage     = "https://github.com/zaijianrumo/HLHJVoteSDK"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "zaijianrumo" => "2245190733@qq.com" }
  s.source       = { :git => "https://github.com/zaijianrumo/HLHJVoteSDK.git", :tag => "1.0.3"  }

  s.xcconfig = {'VALID_ARCHS' => 'arm64 x86_64'}

  s.dependency            "AFNetworking"
  s.dependency            "DZNEmptyDataSet"
  s.dependency            "IQKeyboardManager"
  s.dependency            "MBProgressHUD"
  s.dependency            "MJRefresh"
  s.dependency            "Masonry"
  s.dependency            "SDWebImage"
  s.dependency            "SVProgressHUD"
  s.dependency            "YYModel"
  s.dependency            "TMUserCenter"



 s.source_files           = "HLHJFramework/HLHJVoteSDK.framework/Headers/*.{h,m}"
 s.resources              =  "HLHJFramework/HLHJVoteResource.bundle"
 s.ios.vendored_frameworks = "HLHJFramework/HLHJVoteSDK.framework"



end
