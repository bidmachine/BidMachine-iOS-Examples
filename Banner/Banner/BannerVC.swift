import UIKit
import BidMachine
import BidMachineApiCore

class BannerVC: UIViewController {
    
    @IBOutlet weak var bannerSegmentSize: UISegmentedControl!
    
    private var bannerView: BidMachineBanner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loadBanner(_ sender: UIButton) {
        let configuration = try? BidMachineSdk.shared.requestConfiguration(bannerSegmentSize.format)
        BidMachineSdk.shared.banner (configuration) { [weak self] ad, error in
            guard let self = self, let ad = ad else {
                return
            }
            self.bannerView?.removeFromSuperview()
            self.bannerView = ad
            ad.controller = self
            ad.delegate = self
            ad.loadAd()
        }
    }
    
    @IBAction func removeBanner(_ sender: UIButton) {
        bannerView?.removeFromSuperview()
    }
}

extension BannerVC: BidMachineAdDelegate {
    
    func didLoadAd(_ ad: BidMachine.BidMachineAdProtocol) {
        guard let ad = ad as? BidMachineBanner else {
            return
        }
        ad.place(on: self.view, ad.requestInfo.placement.placement.size)
    }
    
    func didFailLoadAd(_ ad: BidMachine.BidMachineAdProtocol, _ error: Error) {
        
    }
}

fileprivate extension UISegmentedControl {
    
    var format: PlacementFormat {
        return self.selectedSegmentIndex == 0 ? .banner : .banner300x250
    }
}

fileprivate extension UIView {
    
    func place(on view: UIView, _ size: CGSize) {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        NSLayoutConstraint.activate([self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     self.widthAnchor.constraint(equalToConstant: size.width),
                                     self.heightAnchor.constraint(equalToConstant: size.height),
                                     self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)])
        
    }
}
