import UIKit

final class ResumeListViewController: UIViewController, UICollectionViewDelegate {
    
    private let resumeView = ResumeView()
    
    var skillsItems: [ResumeModel] = [
        ResumeModel(skills: "MMVM"),
        ResumeModel(skills: "MVC"),
        ResumeModel(skills: "Swift Package Manager"),
        ResumeModel(skills: "URLSession"),
        ResumeModel(skills: "Grand Central Dispatch"),
        ResumeModel(skills: "UIKit"),
        ResumeModel(skills: "SnapKit+"),
        ResumeModel(skills: "CoreData"),
        ResumeModel(skills: "SOLID"),
        ResumeModel(skills: "Storyboard")
    ]
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = resumeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTitle()
        setupCollectionView()
        
    }
    
    private func setupCollectionView() {
        resumeView.collectionView.dataSource = self
        resumeView.collectionView.delegate = self
        resumeView.collectionView.register(SkillCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    private func arrayIndexForRow(_ row: Int) -> Int {
        
        return row % skillsItems.count
    }
    
    private func customTitle() {
        let titleLabel = UILabel()
        titleLabel.text = R.ResumeListViewController.titleLabel
        titleLabel.textColor = R.Colors.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        navigationItem.titleView = titleLabel
    }
}

// MARK: - CollectionViewDataSource

extension ResumeListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skillsItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? SkillCollectionViewCell {
            let skills = skillsItems[indexPath.item]
            cell.configure(with: skills)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

// MARK: - CollectionViewDelegateFlowLayout

extension ResumeListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel(frame: CGRect.zero)
        label.text = skillsItems[arrayIndexForRow(indexPath.row)].skills
        label.sizeToFit()
        
        return CGSize(width: label.frame.width + 30,
                      height: collectionView.frame.width / 9)
    }
}
