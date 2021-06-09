Pod::Spec.new do |s|
    s.name             = 'BGENetworking'
    s.version          = '1.0.4'
    s.summary          = 'AFNetworking二次封装，抽取公共的uri、path、param、encrypt、return data、error code等内容；'
    s.description      = <<-DESC
        AFNetworking二次封装，抽取公共的uri、path、param、encrypt、return data、error code等内容；
    DESC
    s.homepage         = 'https://github.com/MiniCamel/BGENetworking'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Bge' => 'tiandiwuji1223@163.com' }
    s.source           = { :git => 'https://github.com/MiniCamel/BGENetworking.git', :tag => s.version.to_s }
    s.platform = :ios, '9.0'
    s.ios.deployment_target = '9.0'
    s.source_files = 'BGENetworking/Classes/**/*'
    s.dependency 'AFNetworking', '~> 4.0'
    s.dependency 'JSONModel'
    s.resources = 'BGENetworking/Assets/**/*'
    s.requires_arc = true
end
