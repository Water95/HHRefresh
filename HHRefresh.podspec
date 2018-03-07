Pod::Spec.new do |s|

s.name         = "HHRefresh"
s.version      = "0.0.1"
s.summary      = "易于定制下拉刷新控件的模板控件"
s.homepage     = "https://github.com/Water95/HHRefresh.git"
s.license      = "MIT"
s.author       = { "haohaisheng" => "haohaisheng95@163.com" }
s.source       = { :git => "https://github.com/Water95/HHRefresh.git", :tag => s.version}
s.source_files = "HHRefresh/*.{h,m}"
s.source_files = "HHRefresh/HHRefreshCategory/*.{h,m}"
s.source_files = "HHRefresh/HHRefreshConst/*.{h,m}"
s.source_files = "HHRefresh/HHRefreshHeader/*.{h,m}"
s.platform     = :ios, "8.0"
s.requires_arc = true

end
