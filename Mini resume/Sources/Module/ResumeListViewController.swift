import UIKit

final class ResumeListViewController: UIViewController {
    
    private let resumeView = ResumeView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = resumeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTitle()
    }
    
    func customTitle() {
        let titleLabel = UILabel()
        titleLabel.text = R.ResumeListViewController.titleLabel
        titleLabel.textColor = R.Colors.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        navigationItem.titleView = titleLabel
    }
}
