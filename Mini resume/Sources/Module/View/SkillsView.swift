import UIKit

private extension CGFloat {
    static let leadingTrailingAnchor: CGFloat = 16
    static let topAnchor: CGFloat = 20
}

final class SkillsView: UIView {
    
    private var shouldShowNewCell: Bool = false
    
    // MARK: - Ui
    
    var collectionView: UICollectionView = {
        let layout = LeftAlignedFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = R.Colors.white
        collectionView.allowsMultipleSelection = true
        collectionView.showsVerticalScrollIndicator = false
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
    
    @objc
    private func pencilButtonTapped() {
        shouldShowNewCell.toggle()
        collectionView.reloadData()
        
        let newImageName = shouldShowNewCell ? "done" : "pencil"
        pencilButton.setImage(UIImage(named: newImageName), for: .normal)
    }
}

// MARK: - Setup constrains

private extension SkillsView {
    
    func addSubView() {
        self.addSubviews([ skillsLabel, pencilButton, collectionView, ourSelfLabel, descriptionLabel])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            skillsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: .topAnchor),
            skillsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .leadingTrailingAnchor),
            
            pencilButton.topAnchor.constraint(equalTo: self.topAnchor, constant: .topAnchor),
            pencilButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.leadingTrailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: pencilButton.bottomAnchor, constant: .topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .leadingTrailingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.leadingTrailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55),
            
            ourSelfLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 24),
            ourSelfLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .leadingTrailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: ourSelfLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .leadingTrailingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.leadingTrailingAnchor)
            
        ])
    }
}
