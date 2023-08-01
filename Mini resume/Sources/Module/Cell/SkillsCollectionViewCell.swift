import UIKit

protocol SkillsCollectionViewCellDelegate: AnyObject {
    func didDeleteSkill(at index: Int)
}

final class SkillsCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: SkillsCollectionViewCellDelegate?
    
    // MARK: - Ui
    
    private let skillsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = R.Colors.black
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "delete"), for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        setupConstraints()
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func configure(with resume: ResumeModel, shouldShowDeleteButton: Bool) {
        skillsLabel.text = resume.skills
        self.shouldShowDeleteButton = shouldShowDeleteButton
    }
    
    // MARK: - Action
    
    @objc private func deleteButtonTapped() {
        delegate?.didDeleteSkill(at: self.tag)
    }
    
    // MARK: - Private Methods
    
    private var shouldShowDeleteButton: Bool = true {
        didSet {
            deleteButton.isHidden = shouldShowDeleteButton
        }
    }
    
    private func setupCell () {
        contentView.backgroundColor = R.Colors.lightGray
        contentView.layer.cornerRadius = 12
    }
}

// MARK: - Setup Constrains

private extension SkillsCollectionViewCell {
    
    func addSubView() {
        contentView.addSubview(skillsLabel)
        contentView.addSubview(deleteButton)
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            skillsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            skillsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            deleteButton.leadingAnchor.constraint(equalTo: skillsLabel.trailingAnchor, constant: 10)
            
        ])
    }
}
