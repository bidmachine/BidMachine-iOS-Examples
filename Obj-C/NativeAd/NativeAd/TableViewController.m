#import "TableViewController.h"
#import "BDMContentTableViewCell.h"
#import "BDMNativeAdViewCell.h"

#import <BidMachine/BidMachine.h>

@interface RefreshControll : UIRefreshControl

@end

@implementation RefreshControll

- (instancetype)init {
    if (self = [super init]) {
        self.attributedTitle = [[NSAttributedString alloc] initWithString: @"Load ad"];
    }
    return self;
}

@end

@interface TableViewController ()<BidMachineAdDelegate>

@property (nonatomic, assign) NSInteger cellsCount;

@property (nonatomic, strong) BidMachineNative *nativeAd;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:BDMContentTableViewCell.nib forCellReuseIdentifier:BDMContentTableViewCell.reuseIdentifier];
    [self.tableView registerNib:BDMNativeAdViewCell.nib forCellReuseIdentifier:BDMNativeAdViewCell.reuseIdentifier];
    self.tableView.refreshControl = [RefreshControll new];
    [self.tableView.refreshControl addTarget:self action:@selector(updateData) forControlEvents:UIControlEventValueChanged];
}


- (void)updateData {
    NSError *error = nil;
    id<BidMachineRequestConfigurationProtocol> configuration = [BidMachineSdk.shared requestConfiguration: BidMachinePlacementFormatNative error:&error];
    if (error != nil) {
        [self.refreshControl endRefreshing];
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    [BidMachineSdk.shared native:configuration :^(BidMachineNative *ad, NSError *error) {
        if (ad == nil) {
            [self.refreshControl endRefreshing];
            return;
        }
        
        weakSelf.nativeAd = ad;
        weakSelf.nativeAd.controller = weakSelf;
        weakSelf.nativeAd.delegate = weakSelf;
        [weakSelf.nativeAd loadAd];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.row % 20) == 0) {
        BDMNativeAdViewCell *nativeAdViewCell = [tableView dequeueReusableCellWithIdentifier:BDMNativeAdViewCell.reuseIdentifier forIndexPath:indexPath];
        [self.nativeAd unregisterView];
        [self.nativeAd presentAd:nativeAdViewCell :nativeAdViewCell error:nil];
        return nativeAdViewCell;
    }
    
    BDMContentTableViewCell *fakeCell = [tableView dequeueReusableCellWithIdentifier:BDMContentTableViewCell.reuseIdentifier forIndexPath:indexPath];
    fakeCell.fakeTitle.text = @"Lorem ipsum";
    fakeCell.fakeDescription.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    UInt32 rand = arc4random_uniform(2);
    if ((rand % 2) == 0) {
        fakeCell.fakeIcon.image = [UIImage imageNamed:@"ManPic"];
    } else {
        fakeCell.fakeIcon.image = [UIImage imageNamed:@"KittyPic"];
    }
    
    return fakeCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellsCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.row % 20) == 0) {
        return 375;
    }
    return 86;
}

#pragma mark - BidMachineAdDelegate

- (void)didLoadAd:(id<BidMachineAdProtocol> _Nonnull)ad {
    [self.tableView.refreshControl endRefreshing];
    self.cellsCount = 100;
    [self.tableView reloadData];
}

- (void)didFailLoadAd:(id<BidMachineAdProtocol> _Nonnull)ad :(NSError * _Nonnull)error {
    [self.tableView.refreshControl endRefreshing];
    if (self.cellsCount == 0) {
        return;
    }
    self.cellsCount = 0;
    [self.tableView reloadData];
}

@end
