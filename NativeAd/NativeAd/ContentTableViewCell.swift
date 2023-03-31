import UIKit

class ContentTableViewCell: UITableViewCell {
    @IBOutlet weak var fakeIcon: UIImageView!
    @IBOutlet weak var fakeTitle: UILabel!
    @IBOutlet weak var fakeDescription: UILabel!
}

extension ContentTableViewCell {
    static let reuseIdentifier: String = "ContentTableViewCellReuseID"

    static var nib: UINib {
        return UINib(nibName: "ContentTableViewCell", bundle: Bundle(for: self))
    }    
}
