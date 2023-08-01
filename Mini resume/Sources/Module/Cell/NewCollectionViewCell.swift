import UIKit

protocol NewCollectionViewCellDelegate: AnyObject {
    func didAddNewSkills(skill: String)
}

final class NewCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: NewCollectionViewCellDelegate?
    
    // MARK: - Ui
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    private var plusLabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.textColor = R.Colors.black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        setupConstraints()
        setupCell()
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCell))
        contentView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    // MARK: - Private Methods
    
    private func setupCell () {
        contentView.backgroundColor = R.Colors.lightGray
        contentView.layer.cornerRadius = 12
    }
    
    private func showCellTappedAlert() {
        let alertController = UIAlertController(title: R.NewCollectionViewCell.alertTitle, message: R.NewCollectionViewCell.alertMessage, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = R.NewCollectionViewCell.alertPlaceholder
        }
        
        let cancelAction = UIAlertAction(title: R.NewCollectionViewCell.alertCancel, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: R.NewCollectionViewCell.alertAdded, style: .default) { [weak self, weak alertController] _ in
            guard let textField = alertController?.textFields?.first,
                  let skillName = textField.text,
                  !skillName.isEmpty else {
                return
            }
            
            self?.delegate?.didAddNewSkills(skill: skillName)
        }
        alertController.addAction(addAction)
        
        if let parentViewController = findParentViewController() {
            parentViewController.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func findParentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    // MARK: - Action
    
    @objc private func didTapCell() {
        showCellTappedAlert()
    }
}

// MARK: - Setup Constrains

private extension NewCollectionViewCell {
    
    func addSubView() {
        contentView.addSubview(plusLabel)
        plusLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            plusLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            plusLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
