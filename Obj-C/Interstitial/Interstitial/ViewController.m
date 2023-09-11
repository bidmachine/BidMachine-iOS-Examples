#import "ViewController.h"
#import <BidMachine/BidMachine.h>
#import <BidMachineApiCore/BidMachineApiCore.h>

@interface ViewController ()<BidMachineAdDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *interstitialTypeSegmentedControl;

@property (strong, nonatomic, nullable) BidMachineInterstitial *interstitial;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)loadInterstitial:(id)sender {
    NSError *error = nil;
    id<BidMachineRequestConfigurationProtocol> configuration = [BidMachineSdk.shared requestConfiguration: self.format error:&error];
    if (error != nil) {
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    [BidMachineSdk.shared interstitial:configuration :^(BidMachineInterstitial *ad, NSError *error) {
        if (ad == nil) {
            return;
        }
        
        weakSelf.interstitial = ad;
        weakSelf.interstitial.controller = weakSelf;
        weakSelf.interstitial.delegate = weakSelf;
        [weakSelf.interstitial loadAd];
    }];
}

- (IBAction)presentInterstitial:(id)sender {
    if (self.interstitial.canShow) {
        [self.interstitial presentAd];
    }
}

- (BidMachinePlacementFormat)format {
    switch (self.interstitialTypeSegmentedControl.selectedSegmentIndex) {
        case 0: return BidMachinePlacementFormatInterstitial;
        case 1: return BidMachinePlacementFormatInterstitialStatic;
        case 2: return BidMachinePlacementFormatInterstitialVideo;
        default: return BidMachinePlacementFormatInterstitial;
    }
}

#pragma mark - BidMachineAdDelegate

- (void)didLoadAd:(id<BidMachineAdProtocol> _Nonnull)ad {
    
}

- (void)didFailLoadAd:(id<BidMachineAdProtocol> _Nonnull)ad :(NSError * _Nonnull)error {
    
}

@end
