platform :ios, '9.0'
workspace 'BidMachine-iOS-Examples.xcworkspace'

install! 'cocoapods', :deterministic_uuids => false
use_frameworks!

def bidmachine 
    pod "BidMachine", "1.3.1"
end

def header_bidding 
    pod "BidMachine/FacebookAdapter"
    pod "BidMachine/MyTargetAdapter"
    pod "BidMachine/VungleAdapter"
    pod "BidMachine/TapjoyAdapter"
    pod "BidMachine/AdColonyAdapter"
    pod "BidMachine/MintegralAdapter"
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
    bidmachine
    header_bidding
end
