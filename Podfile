platform :ios, '9.0'
workspace 'BidMachine-iOS-Examples.xcworkspace'

install! 'cocoapods', :deterministic_uuids => false
use_frameworks!

def bidmachine 
    pod "BidMachine", "1.3.0"
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

target 'HeaderBiddingSample' do
    project 'HeaderBiddingSample/HeaderBiddingSample.xcodeproj'
    pod "BidMachine/FacebookAdapter", "1.3.0"
    pod "BidMachine/MyTargetAdapter", "1.3.0"
    pod "BidMachine/VungleAdapter", "1.3.0"
    pod "BidMachine/TapjoyAdapter", "1.3.0"
    pod "BidMachine/AdColonyAdapter", "1.3.0"
    bidmachine
end
