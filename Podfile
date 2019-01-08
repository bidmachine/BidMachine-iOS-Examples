platform :ios, '9.0'
workspace 'BidMachine-iOS-Examples.xcworkspace'
use_frameworks!

def bidmachine 
    pod "BidMachine", "~> 1.0"
end

target 'Banner' do 
    project 'Banner/Banner.xcodeproj' 
    bidmachine
end

target 'Interstitial' do 
    project 'Interstitial/Interstitial.xcodeproj' 
    bidmachine
end

target 'Rewarded' do 
    project 'Rewarded/Rewarded.xcodeproj' 
    bidmachine
end
