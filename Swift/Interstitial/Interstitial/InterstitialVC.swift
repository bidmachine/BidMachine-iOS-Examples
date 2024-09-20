import UIKit
import BidMachine

class InterstitialVC: UIViewController {

    @IBOutlet weak var interstitialTypeSegmentedControl: UISegmentedControl!
    
    private var interstitial: BidMachineInterstitial?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loadInterstitial(_ sender: Any) {
        let configuration = try? BidMachineSdk.shared.requestConfiguration(interstitialTypeSegmentedControl.format)
        BidMachineSdk.shared.interstitial (configuration) { [weak self] ad, error in
            guard let self = self, let ad = ad else {
                return
            }

            self.interstitial = ad
            ad.controller = self
            ad.delegate = self
            ad.loadAd()
        }
    }
    
    @IBAction func presentInterstitial(_ sender: UIButton) {
        guard let interstitial = interstitial, interstitial.canShow else {
            return
        }
        interstitial.presentAd()
    }
}

extension InterstitialVC: BidMachineAdDelegate {
    
    func didLoadAd(_ ad: BidMachine.BidMachineAdProtocol) {
        
    }
    
    func didFailLoadAd(_ ad: BidMachine.BidMachineAdProtocol, _ error: Error) {
        
    }
}

fileprivate extension UISegmentedControl {
    
    var format: PlacementFormat {
        switch self.selectedSegmentIndex {
        case 0: return .interstitial
        case 1: return .interstitialStatic
        case 2: return .interstitialVideo
        default: return .interstitial
        }
    }
}
