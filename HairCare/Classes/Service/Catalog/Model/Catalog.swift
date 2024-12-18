//
//  Catalog.swift
//  ScinCare
//
//  Created by Андрей Чернышев on 22.10.2024.
//

struct Catalog: Codable, Hashable {
    let id: String
    let name: String
    let saved: Bool
}

// MARK: Public
extension Catalog {
    enum Mapper {
        case dermatology
        case hair
    }
    
    static func map(response: Any, mapper: Mapper) -> [Catalog] {
        let array: [[String: Any]] = {
            guard let json = response as? [String: Any] else { return [] }
            
            switch mapper {
            case .dermatology:
                guard
                   let data = json["_data"] as? [String: Any],
                   let drugs = data["drugs"] as? [[String: Any]]
                else { return [] }
                
                return drugs
            case .hair:
                return json["body"] as? [[String: Any]] ?? []
            }
        }()
        
        return array.compactMap { Catalog(json: $0) }
    }
    
    init?(json: [String: Any]) {
        guard
            let id: String = {
                if let int = json["id"] as? Int {
                    return String(int)
                }
                
                if let string = json["id"] as? String {
                    return string
                }
                
                return nil
            }(),
            let name = json["name"] as? String,
            let saved = json["saved"] as? Bool
        else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.saved = saved
    }
}
