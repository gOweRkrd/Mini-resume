import UIKit

final class SkillCollectionViewCell: UICollectionViewCell {
    
    private let skillsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = R.Colors.black
        return label
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
    
    func configure(with resume: ResumeModel) {
        skillsLabel.text = resume.skills
    }
    
    // MARK: - Private Methods
    
    private func setupCell () {
        contentView.backgroundColor = R.Colors.lightGray
        contentView.layer.cornerRadius = 12
    }
}

// MARK: - Setup Constrains

private extension SkillCollectionViewCell {
    
    func addSubView() {
        contentView.addSubview(skillsLabel)
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            skillsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            skillsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)

        ])
    }
}
