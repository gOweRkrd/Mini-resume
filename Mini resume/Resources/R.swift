import UIKit

enum StringResources {
    
    enum ResumeView {
        static let nameLabel = "Косяков Александр Александрович"
        static let professionLabel = "Junior iOS-разработчик, опыт более 1-го года"
        static let cityLabel = "Cанкт-Петербург"
        static let ourSelfLabel = "О себе"
        static let descriptionLabel = "Experienced software engineer skilled in developing scalable and maintainable systems"
        static let skillsLabel = "Мои навыки"
    }
    
    enum NewCollectionViewCell {
        static let alertTitle = "Добавление навыка"
        static let alertMessage = "Введите название навыка, которым вы владеете."
        static let alertPlaceholder = "Ввведите название"
        static let alertCancel = "Отмена"
        static let alertAdded = "Добавить"
    }
    
    enum ResumeListViewController {
        static let titleLabel = "Профиль"
    }
    
    enum Colors {
        static let white = UIColor(hexString: "#FFFFFF")
        static let black = UIColor(hexString: "##313131")
        static let gray = UIColor(hexString: "#96959B")
        static let lightGray = UIColor(hexString: "#F3F3F5")
    }
}

typealias R = StringResources
