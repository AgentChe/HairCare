//
//  GetRecipesRequest.swift
//  HairCare
//
//  Created by Андрей Чернышев on 19.11.2024.
//

import Alamofire

struct GetRecipesRequest: APIRequestBody {
    let anonymousId: String
    let internalId: String?
    let search: String?
    
    var url: String {
        GlobalDefinitions.domain + "/api/v1/recipes"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        var params: Parameters = [
            "anonymous_id": anonymousId
        ]
        
        if let internalId {
            params["internal_id"] = internalId
        }
        
        if let search = search {
            params["search"] = search
        }
        
        return params
    }
    
    var headers: HTTPHeaders? {
        [
            "Access-Token": GlobalDefinitions.apiKey
        ]
    }
}
