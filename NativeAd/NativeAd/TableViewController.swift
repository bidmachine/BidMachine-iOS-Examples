import UIKit
import BidMachine

class RefreshControll: UIRefreshControl {
    
    override init() {
        super.init()
        self.attributedTitle = NSAttributedString(string: "Load ad")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TableViewController: UITableViewController {
    
    struct TableViewContentEntity {
        var image: UIImage
        var title: String
        var description: String
    }
    
    private struct Constants {
        static let contentTitle = "Lorem ipsum"
        static let contentDescription = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
    
    private var cellsCount = 0
    
    private var nativeAd: BidMachineNative?
    
    private var fakeEntityArray: [TableViewContentEntity] = [
        TableViewContentEntity(image: UIImage(named: "ManPic")!, title: Constants.contentTitle, description: Constants.contentDescription),
        TableViewContentEntity(image: UIImage(named: "KittyPic")!, title: Constants.contentTitle, description: Constants.contentDescription),
        TableViewContentEntity(image: UIImage(named: "ManPic")!, title: Constants.contentTitle, description: Constants.contentDescription)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(ContentTableViewCell.nib, forCellReuseIdentifier: ContentTableViewCell.reuseIdentifier)
        self.tableView.register(NativeAdViewCell.nib, forCellReuseIdentifier: NativeAdViewCell.reuseIdentifier)
        self.tableView.refreshControl = RefreshControll()
        self.tableView.refreshControl?.addTarget(self, action: #selector(updataData(_:)), for: .valueChanged)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row.quotientAndRemainder(dividingBy: 20).remainder == 0 {
            let nativeAdViewCell = tableView.dequeueReusableCell(withIdentifier: NativeAdViewCell.reuseIdentifier, for: indexPath) as! NativeAdViewCell
            nativeAd?.unregisterView()
            try? nativeAd?.presentAd(nativeAdViewCell, nativeAdViewCell)
            return nativeAdViewCell
        }
        
        let fakeCell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.reuseIdentifier, for: indexPath) as! ContentTableViewCell
        
        let entity = fakeEntityArray[Int.random(in: 0...2)]
        
        fakeCell.fakeIcon.image = entity.image
        fakeCell.fakeTitle.text = entity.title
        fakeCell.fakeDescription.text = entity.description
        
        return fakeCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row.quotientAndRemainder(dividingBy: 20).remainder == 0 {
            return 375
        }
        return 86
    }
}

extension TableViewController: BidMachineAdDelegate {
    
    func didLoadAd(_ ad: BidMachine.BidMachineAdProtocol) {
        self.tableView.refreshControl?.endRefreshing()
        cellsCount = 100
        tableView.reloadData()
    }
    
    func didFailLoadAd(_ ad: BidMachine.BidMachineAdProtocol, _ error: Error) {
        self.tableView.refreshControl?.endRefreshing()
        guard cellsCount != 0 else {
            return
        }
        cellsCount = 0
        tableView.reloadData()
    }
}

extension TableViewController {
    
    @objc private func updataData(_ sender: Any) {
        BidMachineSdk.shared.native { [weak self] ad, error in
            guard let self = self, let ad = ad else {
                self?.refreshControl?.endRefreshing()
                return
            }
            self.nativeAd = ad
            ad.controller = self
            ad.delegate = self
            ad.loadAd()
        }
    }
    
}
 
