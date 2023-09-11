#import "BDMNativeAdViewCell.h"

@interface BDMNativeAdViewCell()

@property (nonatomic, weak) IBOutlet UILabel *titleLab;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLab;
@property (nonatomic, weak) IBOutlet UIImageView *icon;
@property (nonatomic, weak) IBOutlet UIView *mediaContainer;
@property (nonatomic, weak) IBOutlet UILabel *callToActionLab;

@end

@implementation BDMNativeAdViewCell

- (UILabel *)titleLabel {
    return self.titleLab;
}

- (UILabel *)callToActionLabel {
    return self.callToActionLab;
}

- (UILabel *)descriptionLabel {
    return self.descriptionLab;
}

- (UIImageView *)iconView {
    return self.icon;
}

- (UIView *)mediaContainerView {
    return self.mediaContainer;
}

-(UIView *)adChoiceView {
    return nil;
}

+ (NSString *)reuseIdentifier {
    return @"NativeAdViewCellReuseID";
}

+ (UINib *)nib {
    return [UINib nibWithNibName:@"NativeAdViewCell" bundle:nil];
}

@end
