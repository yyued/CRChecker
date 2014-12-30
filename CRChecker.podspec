
Pod::Spec.new do |s|

  s.name         = "CRChecker"
  s.version      = "1.0.2"
  s.summary      = "CRChecker is a debug tool, helps you find out circular reference problem."

  s.description  = <<-DESC
                      CRChecker is a debug tool, helps you find out circular reference problem.
                      Be Careful:Don't use this library under production environment.
                   DESC

  s.homepage     = "https://github.com/duowan/CRChecker"

  s.license      = "MIT"

  s.author       = { "PonyCui" => "cuiminghui@yy.com" }

  s.platform     = :ios, "5.0"

  s.source       = { :git => "https://github.com/duowan/CRChecker.git", :tag => "1.0.2" }

  s.source_files  = "CRChecker", "CRChecker/*.{h,m}"

  s.requires_arc = true

  s.public_header_files = "CRChecker/CRChecker.h"

end
