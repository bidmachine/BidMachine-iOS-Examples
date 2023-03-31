import UIKit
import BidMachine
import BidMachineApiCore

class RewardedVC: UIViewController {

    @IBOutlet weak var rewardedTypeSegmentedControl: UISegmentedControl!
    
    private var rewarded: BidMachineRewarded?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loadRewarded(_ sender: Any) {
        let configuration = try? BidMachineSdk.shared.requestConfiguration(rewardedTypeSegmentedControl.format)
        BidMachineSdk.shared.rewarded (configuration) { [weak self] ad, error in
            guard let self = self, let ad = ad else {
                return
            }

            self.rewarded = ad
            ad.controller = self
            ad.delegate = self
            ad.loadAd()
        }
    }
    
    @IBAction func presentRewarded(_ sender: Any) {
        guard let rewarded = rewarded, rewarded.canShow else {
            return
        }
        rewarded.presentAd()
    }
}

extension RewardedVC: BidMachineAdDelegate {
    
    func didLoadAd(_ ad: BidMachine.BidMachineAdProtocol) {
        
    }
    
    func didFailLoadAd(_ ad: BidMachine.BidMachineAdProtocol, _ error: Error) {
        
    }
}

fileprivate extension UISegmentedControl {
    
    var format: PlacementFormat {
        switch self.selectedSegmentIndex {
        case 0: return .rewarded
        case 1: return .rewardedStatic
        case 2: return .rewardedVideo
        default: return .rewarded
        }
    }
}

