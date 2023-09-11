#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDMContentTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *fakeTitle;
@property (nonatomic, weak) IBOutlet UILabel *fakeDescription;
@property (nonatomic, weak) IBOutlet UIImageView *fakeIcon;

@property (class, nonatomic, readonly) NSString *reuseIdentifier;

@property (class, nonatomic, readonly) UINib *nib;

@end

NS_ASSUME_NONNULL_END
