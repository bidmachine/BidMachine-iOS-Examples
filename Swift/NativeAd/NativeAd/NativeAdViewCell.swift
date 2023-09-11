import UIKit
import BidMachine

class NativeAdViewCell: UITableViewCell, BidMachineNativeAdRendering {
    
    var titleLabel: UILabel? { titleLab }
    
    var callToActionLabel: UILabel? { callToActionLab }
    
    var descriptionLabel: UILabel? { descriptionLab }
    
    var iconView: UIImageView? { icon }
    
    var mediaContainerView: UIView? { mediaContainer }
    
    var adChoiceView: UIView? { nil }
    
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var descriptionLab: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var mediaContainer: UIView!
    @IBOutlet weak var callToActionLab: UILabel!
}


extension NativeAdViewCell {
    static let reuseIdentifier: String = "NativeAdViewCellReuseID"

    static var nib: UINib {
        return UINib(nibName: "NativeAdViewCell", bundle: Bundle(for: self))
    }
}
