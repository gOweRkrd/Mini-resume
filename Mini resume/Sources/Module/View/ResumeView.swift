import UIKit

final class ResumeView: UIView {
    
    // MARK: - Ui
    
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
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        return label
    }()
    
    private var professionLabel: UILabel = {
        let label = UILabel()
        label.text = R.ResumeView.professionLabel
        label.textColor = R.Colors.gray
        label.textAlignment = .center
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
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
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        return label
    }()
    
    private var locationStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        return stack
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
        self.addSubviews([resumeImageView, nameLabel, professionLabel, locationStack])
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
            locationStack.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            
        ])
    }
}
