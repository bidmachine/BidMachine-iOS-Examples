import UIKit
import BidMachine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        _setupParams()
        _initialize()
        
        return true
    }
}

private extension AppDelegate {
    
    func _setupParams() {
        BidMachineSdk.shared.populate { $0
            .withTestMode(true)
            .withLoggingMode(true)
            .withBidLoggingMode(true)
            .withEventLoggingMode(true)
        }
        
        BidMachineSdk.shared.targetingInfo.populate { $0
            .withStoreId("1")
        }
        
        BidMachineSdk.shared.regulationInfo.populate { $0
            .withCOPPA(false)
        }
    }
    
    func _initialize() {
        BidMachineSdk.shared.initializeSdk("1")
    }
}

