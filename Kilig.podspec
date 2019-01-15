Pod::Spec.new do |s|
  s.name             = 'Kilig'
  s.version          = '0.2.0'
  s.summary          = '一个轻量的简化UITableView数据驱动的库'
  s.description      = <<-DESC
Kilig是一个轻量的简化UITableView数据驱动的库
                       DESC

  s.homepage         = 'https://github.com/cnchenys/Kilig'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'TechSen' => 'cnchenys@qq.com' }
  s.source           = { :git => 'https://github.com/cnchenys/Kilig.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Kilig/Classes/*.h'

    s.subspec 'Tools' do |ss|
      ss.source_files = 'Kilig/Classes/Tools/*.{h,m}'
    end

    s.subspec 'TableView' do |ss|
      ss.source_files = 'Kilig/Classes/TableView/*.{h,m}'
      ss.dependency 'Kilig/Tools'
    end
    
    s.subspec 'Chaining' do |ss|
        ss.source_files = 'Kilig/Classes/Chaining/*.{h,m}'
        ss.dependency 'Kilig/TableView'
    end
end
