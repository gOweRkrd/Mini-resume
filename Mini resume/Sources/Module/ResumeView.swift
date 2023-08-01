import UIKit

final class ResumeView: UIView {
    
    private var resumeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "photo")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = R.ResumeView.nameLabel
        label.textColor = R.Colors.black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private var professionLabel: UILabel = {
        let label = UILabel()
        label.text = R.ResumeView.professionLabel
        label.textColor = R.Colors.gray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private var locationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "location")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var cityLabel: UILabel = {
        let label = UILabel()
        label.text = R.ResumeView.cityLabel
        label.textColor = R.Colors.gray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private var locationStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        return stack
    }()
    
    private var skillsLabel: UILabel = {
        let label = UILabel()
        label.text = "Мои навыки"
        label.textColor = R.Colors.black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private var pencilImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pencil")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = R.Colors.white
        collectionView.allowsMultipleSelection = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private var ourSelfLabel: UILabel = {
        let label = UILabel()
        label.text = "О себе"
        label.textColor = R.Colors.black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.setLineSpacing(8)
        label.text = "Experienced software engineer skilled in developing scalable and maintainable systems"
        label.textColor = R.Colors.black
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        setupConstraints()
        backgroundColor = R.Colors.lightGray
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Setup Constraints

private extension ResumeView {
    
    func addSubView() {
        locationStack = UIStackView(arrangedSubviews: [locationImage, cityLabel])
        self.addSubviews([resumeImageView, nameLabel, professionLabel, locationStack, skillsLabel, pencilImage, collectionView, ourSelfLabel, descriptionLabel])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            resumeImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            resumeImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            resumeImageView.widthAnchor.constraint(equalToConstant: 120),
            resumeImageView.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: resumeImageView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 80),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -80),
            
            professionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            professionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            professionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            locationStack.topAnchor.constraint(equalTo: professionLabel.bottomAnchor, constant: 2),
            locationStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            skillsLabel.topAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: 40),
            skillsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            pencilImage.topAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: 40),
            pencilImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: pencilImage.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            
            ourSelfLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 24),
            ourSelfLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: ourSelfLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
            
        ])
    }
}

extension UILabel {
    func setLineSpacing(_ lineSpacing: CGFloat) {
        guard let labelText = text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        attributedText = attributedString
    }
}
