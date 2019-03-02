# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

##########主App和Widget共享的三方库##########
def share_pods
  pod 'SnapKit', '~> 4.2.0'
end

target 'MainApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MainApp
  share_pods

  target 'SecondWidget' do
    share_pods
  end

  target 'MainAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MainAppUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'MainWidget' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MainWidget

end
