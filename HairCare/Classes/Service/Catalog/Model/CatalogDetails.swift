//
//  CatalogDetails.swift
//  ScinCare
//
//  Created by Андрей Чернышев on 22.10.2024.
//

struct CatalogDetails: Codable, Hashable {
    let id: String
    let name: String
    let saved: Bool
    let sections: [CatalogSection]
}

// MARK: Public
extension CatalogDetails {
    enum Mapper {
        case dermatology
        case hair
    }
    
    init?(response: Any, mapper: Mapper) {
        guard let json = response as? [String: Any] else { return nil }
        
        let data: [String: Any]? = {
            switch mapper {
            case .dermatology:
                return json["_data"] as? [String: Any]
            case .hair:
                return json["body"] as? [String: Any]
            }
        }()
        
        guard
            let data,
            let id: String = {
                if let int = data["id"] as? Int {
                    return String(int)
                }
                
                if let string = data["id"] as? String {
                    return string
                }
                
                return nil
            }(),
            let name = data["name"] as? String,
            let saved = data["saved"] as? Bool,
            let sectionsArray = data["sections"] as? [[String: Any]]
        else { return nil }
        
        self.id = id
        self.name = name
        self.saved = saved
        self.sections = sectionsArray.compactMap { CatalogSection(json: $0) }
    }
}
