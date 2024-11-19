//
//  GetRecipesRequest.swift
//  HairCare
//
//  Created by Андрей Чернышев on 19.11.2024.
//

import Alamofire

struct GetRecipesRequest: APIRequestBody {
    let userToken: String
    let search: String?

    // TODO: заменить endpoint
    var url: String {
        GlobalDefinitions.dermatologyDomain + "/api/disease"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        var params = [
            "_api_key": GlobalDefinitions.dermatologyApiKey,
            "_user_token": userToken
        ]
        
        if let search = search {
            params["search"] = search
        }
        
        return params
    }
}
