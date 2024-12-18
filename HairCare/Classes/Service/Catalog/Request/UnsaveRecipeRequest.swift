//
//  UnsaveRecipeRequest.swift
//  HairCare
//
//  Created by Андрей Чернышев on 19.11.2024.
//

import Alamofire

struct UnsaveRecipeRequest: APIRequestBody {
    let anonymousId: String
    let internalId: String?
    let ids: [String]

    var url: String {
        GlobalDefinitions.domain + "/api/v1/recipes/unsave"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        var params: Parameters = [
            "anonymous_id": anonymousId,
            "recipes_ids": ids
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
