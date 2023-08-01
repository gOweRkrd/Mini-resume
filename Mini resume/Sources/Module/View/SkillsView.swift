import UIKit

final class SkillsView: UIView {
    
    private var shouldShowNewCell: Bool = false
    
    // MARK: - Ui
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = R.Colors.white
        collectionView.allowsMultipleSelection = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private var skillsLabel: UILabel = {
        let label = UILabel()
        label.text = R.ResumeView.skillsLabel
        label.textColor = R.Colors.black
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        return label
    }()
    
    private var pencilButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "pencil"), for: .normal)
        return button
    }()
    
    private var ourSelfLabel: UILabel = {
        let label = UILabel()
        label.text = R.ResumeView.ourSelfLabel
        label.textColor = R.Colors.black
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = R.ResumeView.descriptionLabel
        label.textColor = R.Colors.black
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        let attributedString = NSAttributedString(string: label.text ?? "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.attributedText = attributedString

        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        setupConstraints()
        backgroundColor = R.Colors.white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Public methods
    
    func setupPencilButtonTarget() {
        pencilButton.addTarget(self, action: #selector(pencilButtonTapped), for: .touchUpInside)
    }
    
    func showNewCell() -> Bool {
        return shouldShowNewCell
    }
    
    // MARK: - Action
    
    @objc private func pencilButtonTapped() {
        shouldShowNewCell.toggle()
        collectionView.reloadData()
        
        let newImageName = shouldShowNewCell ? "done" : "pencil"
        pencilButton.setImage(UIImage(named: newImageName), for: .normal)
    }
    
}

// MARK: - Setup Constraints

private extension SkillsView {
    
    func addSubView() {
        self.addSubviews([ skillsLabel, pencilButton, collectionView, ourSelfLabel, descriptionLabel])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            skillsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            skillsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            pencilButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            pencilButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: pencilButton.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55),
            
            ourSelfLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 24),
            ourSelfLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: ourSelfLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
            
        ])
    }
}
