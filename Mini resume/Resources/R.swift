import UIKit

enum StringResources {
    
    enum ResumeView {
        static let nameLabel = "Косяков Александр Александрович"
        static let professionLabel = "Junior iOS-разработчик, опыт более 1-го года"
        static let cityLabel = "Cанкт-Петербург"
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
