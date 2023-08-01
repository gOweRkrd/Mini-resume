import UIKit

final class ResumeListViewController: UIViewController, UICollectionViewDelegate, NewCollectionViewCellDelegate, SkillsCollectionViewCellDelegate {
    
    private var skillsItems: [ResumeModel] = []
    private let skillsView = SkillsView()
    private let resumeView = ResumeView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTitle()
        setupCollectionView()
        fetchSkillsItems()
        setupConstrains()
    }
    
    // MARK: - Public methods
    
    func didAddNewSkills(skill: String) {
        let newSkill = ResumeModel(skills: skill)
        skillsItems.append(newSkill)
        skillsView.collectionView.reloadData()
    }
    
    func didDeleteSkill(at index: Int) {
        skillsItems.remove(at: index)
        skillsView.collectionView.reloadData()
    }
    
    // MARK: - Private methods
    
    private func fetchSkillsItems() {
        skillsItems = []
        NetworkService.shared.fetchSkillsItems { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let skillsItems):
                    self?.skillsItems = skillsItems
                    self?.skillsView.collectionView.reloadData()
                case .failure(let error):
                    print("Error fetching skills items: \(error)")
                }
            }
        }
    }
    
    private func setupCollectionView() {
        skillsView.collectionView.dataSource = self
        skillsView.collectionView.delegate = self
        skillsView.collectionView.register(SkillsCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        skillsView.collectionView.register(NewCollectionViewCell.self, forCellWithReuseIdentifier: "NewCell")
        skillsView.setupPencilButtonTarget()
        
        skillsView.collectionView.visibleCells.compactMap { $0 as? NewCollectionViewCell }.forEach {
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
        titleLabel.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        navigationItem.titleView = titleLabel
    }
}

// MARK: - CollectionViewDataSource

extension ResumeListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let additionalCell = skillsView.showNewCell() ? 1 : 0
        return skillsItems.count + additionalCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == skillsItems.count && skillsView.showNewCell() {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCell", for: indexPath) as? NewCollectionViewCell {
                cell.delegate = self
                return cell
            }
            
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? SkillsCollectionViewCell {
                cell.delegate = self
                cell.tag = indexPath.item
                let skills = skillsItems[arrayIndexForRow(indexPath.item)]
                let shouldShowDeleteButton = !skillsView.showNewCell()
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
        
        let skillsText = skillsItems[arrayIndexForRow(indexPath.row)].skills
        let label = UILabel()
        label.text = skillsText
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.sizeToFit()
        
        let deleteButtonWidth: CGFloat = 24
        let totalCellWidth = label.frame.width + deleteButtonWidth + 48
        
        return CGSize(width: totalCellWidth, height: collectionView.frame.width / 8)
    }
}

// MARK: - Setup constrains

extension ResumeListViewController {
    
    private func setupConstrains() {
        view.addSubview(resumeView)
        view.addSubview(skillsView)
        resumeView.translatesAutoresizingMaskIntoConstraints = false
        skillsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resumeView.topAnchor.constraint(equalTo: view.topAnchor),
            resumeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resumeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resumeView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            
            skillsView.topAnchor.constraint(equalTo: resumeView.bottomAnchor),
            skillsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            skillsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            skillsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55),
            skillsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
