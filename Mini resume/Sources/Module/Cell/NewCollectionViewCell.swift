import UIKit

final class NewCollectionViewCell: UICollectionViewCell {
    
    private var plusLabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.textColor = R.Colors.black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
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
    
    @objc private func didTapCell() {
           // Show an alert here
           showCellTappedAlert()
       }
       
    private func showCellTappedAlert() {
        
        let alertController = UIAlertController(title: "Добавление навыка", message: "Введите название навыка, которым вы владеете.", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Ввведите название"
        }
    
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { [weak self, weak alertController] _ in
            guard let textField = alertController?.textFields?.first,
                  let skillName = textField.text,
                  !skillName.isEmpty else {
                return
            }
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
