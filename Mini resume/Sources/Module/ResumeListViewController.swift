import UIKit

final class ResumeListViewController: UIViewController, UICollectionViewDelegate, NewCollectionViewCellDelegate, SkillsCollectionViewCellDelegate {
    
    private let resumeView = ResumeView()
    
    private var skillsItems: [ResumeModel] = []
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = resumeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTitle()
        setupCollectionView()
        fetchSkillsItems()
        
    }
    
    // MARK: - Public methods
    
    func didAddNewSkills(skill: String) {
        let newSkill = ResumeModel(skills: skill)
        skillsItems.append(newSkill)
        resumeView.collectionView.reloadData()
    }
    
    func didDeleteSkill(at index: Int) {
        skillsItems.remove(at: index)
        resumeView.collectionView.reloadData()
    }
    
    // MARK: - Private methods
    
    private func fetchSkillsItems() {
        skillsItems = []
        NetworkService.shared.fetchSkillsItems { [weak self] skillsItems in
            DispatchQueue.main.async {
                self?.skillsItems = skillsItems
                self?.resumeView.collectionView.reloadData()
            }
        }
    }
    
    private func setupCollectionView() {
        resumeView.collectionView.dataSource = self
        resumeView.collectionView.delegate = self
        resumeView.collectionView.register(SkillsCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        resumeView.collectionView.register(NewCollectionViewCell.self, forCellWithReuseIdentifier: "NewCell")
        resumeView.setupPencilButtonTarget()
        
        resumeView.collectionView.visibleCells.compactMap { $0 as? NewCollectionViewCell }.forEach {
            $0.delegate = self
        }
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
        let additionalCell = resumeView.showNewCell() ? 1 : 0
        return skillsItems.count + additionalCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == skillsItems.count && resumeView.showNewCell() {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCell", for: indexPath) as? NewCollectionViewCell {
                cell.delegate = self
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? SkillsCollectionViewCell {
                cell.delegate = self
                cell.tag = indexPath.item
                let skills = skillsItems[arrayIndexForRow(indexPath.item)]
                let shouldShowDeleteButton = !resumeView.showNewCell()
                cell.configure(with: skills, shouldShowDeleteButton: shouldShowDeleteButton)
                return cell
            }
        }
        
        return UICollectionViewCell()
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
