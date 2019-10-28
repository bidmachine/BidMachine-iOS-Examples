platform :ios, '9.0'
workspace 'BidMachine-iOS-Examples.xcworkspace'

source 'https://github.com/CocoaPods/Specs.git'

install! 'cocoapods', :deterministic_uuids => false, :warn_for_multiple_pod_sources => false
use_frameworks!

def bidmachine 
    pod "BidMachine", "1.3.3"
end

def header_bidding 
    pod "BidMachine/Adapters"
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
