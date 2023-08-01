import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchSkillsItems(completion: @escaping ([ResumeModel]) -> Void) {
       
        let skillsItems: [ResumeModel] = [
            ResumeModel(skills: "MMVM"),
            ResumeModel(skills: "MVC"),
            ResumeModel(skills: "Swift Package Manager"),
            ResumeModel(skills: "URLSession"),
            ResumeModel(skills: "Grand Central Dispatch"),
            ResumeModel(skills: "UIKit"),
            ResumeModel(skills: "SnapKit+"),
            ResumeModel(skills: "CoreData"),
            ResumeModel(skills: "SOLID"),
            ResumeModel(skills: "Storyboard")
        ]
        
        completion(skillsItems)
    }
}
