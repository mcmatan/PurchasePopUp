
Pod::Spec.new do |s|

s.name              = 'PurchasePopUp'
s.version           = '0.0.1'
s.summary           = 'PurchasePopUp'
s.homepage          = 'https://github.com/mcmatan/PurchasePopUp'
s.ios.deployment_target = '8.0'
s.platform = :ios, '8.0'
s.license           = {
:type => 'MIT',
:file => 'LICENSE'
}
s.author            = {
'YOURNAME' => 'Matan'
}
s.source            = {
:git => 'https://github.com/mcmatan/PurchasePopUp.git',
:tag => "#{s.version}" }

s.framework = "UIKit"
s.source_files      = 'PurchasePopUp/*' , 'Vendor/*', 'Resource/*', 'PurchasePopUp/PurchasePopUp/*'
s.requires_arc      = true

end