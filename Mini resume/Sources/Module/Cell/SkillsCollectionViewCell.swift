import UIKit

protocol SkillsCollectionViewCellDelegate: AnyObject {
    func didDeleteSkill(at index: Int)
}

final class SkillsCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: SkillsCollectionViewCellDelegate?
    
    // MARK: - Ui
    
    private let skillsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.textColor = R.Colors.black
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "delete"), for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var skillsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
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
        contentView.addSubviews([skillsLabel, deleteButton])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
      
            skillsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            skillsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            skillsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            deleteButton.leadingAnchor.constraint(equalTo: skillsLabel.trailingAnchor, constant: 10),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }
}
