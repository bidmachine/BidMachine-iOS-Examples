#import "BDMContentTableViewCell.h"

@interface BDMContentTableViewCell()

@end

@implementation BDMContentTableViewCell

+ (NSString *)reuseIdentifier {
    return @"ContentTableViewCellReuseID";
}

+ (UINib *)nib {
    return [UINib nibWithNibName:@"ContentTableViewCell" bundle:[NSBundle bundleForClass:self]];
}

@end
