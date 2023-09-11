#import "AppDelegate.h"
#import <BidMachine/BidMachine.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupParams];
    [self initialize];
    
    return YES;
}

- (void)setupParams {
    
    [BidMachineSdk.shared populate:^(id<BidMachineInfoBuilderProtocol> builder) {
            [builder withTestMode:YES];
            [builder withLoggingMode:YES];
            [builder withBidLoggingMode:YES];
            [builder withEventLoggingMode:YES];
    }];
    
    [BidMachineSdk.shared.targetingInfo populate:^(id<BidMachineTargetingInfoBuilderProtocol> builder) {
            [builder withStoreId:@"1"];
    }];
    
    [BidMachineSdk.shared.regulationInfo populate:^(id<BidMachineRegulationInfoBuilderProtocol> builder) {
            [builder withCOPPA:NO];
    }];
}

- (void)initialize {
    [BidMachineSdk.shared initializeSdk:@"1"];
}


@end
