import UIKit
import BidMachine

class MediaVC: UIViewController {
    
    private var mediaView: BidMachineMedia?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func playAction(_ sender: Any) {
        self.mediaView?.resume()
    }
    
    @IBAction func pauseAction(_ sender: Any) {
        self.mediaView?.pause()
    }
    
    @IBAction func muteAction(_ sender: Any) {
        self.mediaView?.mute()
    }
    
    @IBAction func unmuteAction(_ sender: Any) {
        self.mediaView?.unmute()
    }
    
    @IBAction func loadMedia(_ sender: Any) {
        BidMachineSdk.shared.media { [weak self] ad, error in
            guard let self = self, let ad = ad else {
                return
            }
            self.mediaView?.removeFromSuperview()
            self.mediaView = ad
            ad.controller = self
            ad.delegate = self
            ad.loadAd()
        }
    }
    
    @IBAction func removeMedia(_ sender: Any) {
        mediaView?.removeFromSuperview()
    }
}

extension MediaVC: BidMachineAdDelegate {
    
    func didLoadAd(_ ad: BidMachine.BidMachineAdProtocol) {
        guard let ad = ad as? BidMachineMedia else {
            return
        }
        ad.place(on: self.view)
    }
    
    func didFailLoadAd(_ ad: BidMachine.BidMachineAdProtocol, _ error: Error) {
        
    }
}

fileprivate extension UIView {
    
    func place(on view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        NSLayoutConstraint.activate([self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     self.widthAnchor.constraint(equalToConstant: 300),
                                     self.heightAnchor.constraint(equalToConstant: 250),
                                     self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)])
        
    }
}
