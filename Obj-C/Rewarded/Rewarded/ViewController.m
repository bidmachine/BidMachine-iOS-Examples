#import "ViewController.h"
#import <BidMachine/BidMachine.h>

@interface ViewController ()<BidMachineAdDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *rewardedTypeSegmentedControl;

@property (strong, nonatomic, nullable) BidMachineRewarded *rewarded;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)loadRewarded:(id)sender {
    NSError *error = nil;
    id<BidMachineRequestConfigurationProtocol> configuration = [BidMachineSdk.shared requestConfiguration: self.format error:&error];
    if (error != nil) {
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    [BidMachineSdk.shared rewarded:configuration :^(BidMachineRewarded *ad, NSError *error) {
        if (ad == nil) {
            return;
        }
        
        weakSelf.rewarded = ad;
        weakSelf.rewarded.controller = weakSelf;
        weakSelf.rewarded.delegate = weakSelf;
        [weakSelf.rewarded loadAd];
    }];
}

- (IBAction)presentRewarded:(id)sender {
    if (self.rewarded.canShow) {
        [self.rewarded presentAd];
    }
}

- (BidMachinePlacementFormat)format {
    switch (self.rewardedTypeSegmentedControl.selectedSegmentIndex) {
        case 0: return BidMachinePlacementFormatRewarded;
        case 1: return BidMachinePlacementFormatRewardedStatic;
        case 2: return BidMachinePlacementFormatRewardedVideo;
        default: return BidMachinePlacementFormatRewarded;
    }
}

#pragma mark - BidMachineAdDelegate

- (void)didLoadAd:(id<BidMachineAdProtocol> _Nonnull)ad {
    
}

- (void)didFailLoadAd:(id<BidMachineAdProtocol> _Nonnull)ad :(NSError * _Nonnull)error {
    
}

@end
