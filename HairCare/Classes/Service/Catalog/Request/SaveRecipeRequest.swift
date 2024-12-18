//
//  SaveRecipeRequest.swift
//  HairCare
//
//  Created by Андрей Чернышев on 19.11.2024.
//

import Alamofire

struct SaveRecipeRequest: APIRequestBody {
    let anonymousId: String
    let internalId: String?
    let id: String

    var url: String {
        GlobalDefinitions.domain + "/api/v1/recipes/save"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        var params: Parameters = [
            "anonymous_id": anonymousId,
            "recipes_id": id
        ]
        
        if let internalId {
            params["internal_id"] = internalId
        }
        
        return params
    }
    
    var headers: HTTPHeaders? {
        [
            "Access-Token": GlobalDefinitions.apiKey
        ]
    }
}
