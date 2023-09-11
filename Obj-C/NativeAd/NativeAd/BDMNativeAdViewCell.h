#import <UIKit/UIKit.h>
#import <BidMachine/BidMachine.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDMNativeAdViewCell : UITableViewCell <BidMachineNativeAdRendering>

@property (class, nonatomic, readonly) NSString *reuseIdentifier;

@property (class, nonatomic, readonly) UINib *nib;

@end

NS_ASSUME_NONNULL_END
