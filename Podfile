 platform :osx, '10.12'

target 'Bitrise' do

  pod 'EasyMapping'
  pod 'SDWebImage', '~> 5.0.6'
  pod "NSPopover+MISSINGBackgroundView"

  pod 'Mixpanel-OSX-Community', :git => 'https://github.com/orta/mixpanel-osx-unofficial.git'

  target 'BitriseTests' do
    inherit! :search_paths
  
    pod 'OCMock', '~> 3.4.3'
    pod 'Expecta', '~> 1.0.6'
    
  end

end
