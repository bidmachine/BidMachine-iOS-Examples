#import "ViewController.h"
#import <BidMachine/BidMachine.h>
#import <BidMachineApiCore/BidMachineApiCore.h>

@interface ViewController ()<BidMachineAdDelegate>

@property (strong, nonatomic, nullable) BidMachineMedia *mediaView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)place:(BidMachineMedia *)banner onView:(UIView*)view withSize:(CGSize)size {
    [banner setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view addSubview:banner];
    
    NSMutableArray <NSLayoutConstraint *> *constraints = NSMutableArray.new;
    [constraints addObject: [banner.centerXAnchor constraintEqualToAnchor:view.centerXAnchor]];
    [constraints addObject: [banner.widthAnchor constraintEqualToConstant:size.width]];
    [constraints addObject: [banner.heightAnchor constraintEqualToConstant:size.height]];
    [constraints addObject: [banner.bottomAnchor constraintEqualToAnchor:view.bottomAnchor constant:-50]];
    
    
    [NSLayoutConstraint activateConstraints:constraints];
}

- (IBAction)loadMedia:(id)sender {
    NSError *error = nil;
    id<BidMachineRequestConfigurationProtocol> configuration = [BidMachineSdk.shared requestConfiguration: BidMachinePlacementFormatMedia error:&error];
    if (error != nil) {
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    [BidMachineSdk.shared media:configuration :^(BidMachineMedia *ad, NSError *error) {
        if (ad == nil) {
            return;
        }
        [weakSelf.mediaView removeFromSuperview];
        weakSelf.mediaView = ad;
        weakSelf.mediaView.controller = weakSelf;
        weakSelf.mediaView.delegate = weakSelf;
        [weakSelf.mediaView loadAd];
    }];
}
- (IBAction)removeMedia:(id)sender {
    [self.mediaView removeFromSuperview];
}

- (IBAction)playAction:(id)sender {
    [self.mediaView resume];
}

- (IBAction)pauseAction:(id)sender {
    [self.mediaView pause];
}

- (IBAction)muteAction:(id)sender {
    [self.mediaView mute];
}

- (IBAction)unmuteAction:(id)sender {
    [self.mediaView unmute];
}

#pragma mark - BidMachineAdDelegate

- (void)didLoadAd:(id<BidMachineAdProtocol> _Nonnull)ad {
    [self place:self.mediaView onView:self.view withSize:(CGSize){.width = 300, .height = 250}];
}

- (void)didFailLoadAd:(id<BidMachineAdProtocol> _Nonnull)ad :(NSError * _Nonnull)error {
    
}

@end
