#import "ViewController.h"
#import <BidMachine/BidMachine.h>
#import <BidMachineApiCore/BidMachineApiCore.h>

@interface ViewController ()<BidMachineAdDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *bannerSegmentSize;

@property (strong, nonatomic, nullable) BidMachineBanner *bannerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)place:(BidMachineBanner *)banner onView:(UIView*)view withSize:(CGSize)size {
    [banner setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view addSubview:banner];
    
    NSMutableArray <NSLayoutConstraint *> *constraints = NSMutableArray.new;
    [constraints addObject: [banner.centerXAnchor constraintEqualToAnchor:view.centerXAnchor]];
    [constraints addObject: [banner.widthAnchor constraintEqualToConstant:size.width]];
    [constraints addObject: [banner.heightAnchor constraintEqualToConstant:size.height]];
    [constraints addObject: [banner.bottomAnchor constraintEqualToAnchor:view.bottomAnchor constant:-50]];
    
    
    [NSLayoutConstraint activateConstraints:constraints];
}

- (IBAction)loadBanner:(id)sender {
    NSError *error = nil;
    id<BidMachineRequestConfigurationProtocol> configuration = [BidMachineSdk.shared requestConfiguration: self.format error:&error];
    if (error != nil) {
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    [BidMachineSdk.shared banner:configuration :^(BidMachineBanner *ad, NSError *error) {
        if (ad == nil) {
            return;
        }
        [weakSelf.bannerView removeFromSuperview];
        weakSelf.bannerView = ad;
        weakSelf.bannerView.controller = weakSelf;
        weakSelf.bannerView.delegate = weakSelf;
        [weakSelf.bannerView loadAd];
    }];
}

- (IBAction)removeBanner:(id)sender {
    [self.bannerView removeFromSuperview];
}

- (BidMachinePlacementFormat)format {
    return self.bannerSegmentSize.selectedSegmentIndex == 0 ? BidMachinePlacementFormatBanner : BidMachinePlacementFormatBanner300x250;
}

#pragma mark - BidMachineAdDelegate

- (void)didLoadAd:(id<BidMachineAdProtocol> _Nonnull)ad {
    [self place:self.bannerView onView:self.view withSize:self.bannerView.frame.size];
}

- (void)didFailLoadAd:(id<BidMachineAdProtocol> _Nonnull)ad :(NSError * _Nonnull)error {
    
}

@end
