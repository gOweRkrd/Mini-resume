import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchSkillsItems(completion: @escaping (Result<[ResumeModel], Error>) -> Void) {
        let skillsItems: [ResumeModel] = [
            ResumeModel(skills: "MVVM"),
            ResumeModel(skills: "Grand Central Dispatch"),
            ResumeModel(skills: "MVC"),
            ResumeModel(skills: "Swift Package Manager"),
            ResumeModel(skills: "UIKit"),
            ResumeModel(skills: "SwiftUI"),
            ResumeModel(skills: "URLSession"),
            ResumeModel(skills: "CocoaPods"),
            ResumeModel(skills: "HIG")   
        ]
        
        let error: Error? = nil
        
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(skillsItems))
        }
    }
}
