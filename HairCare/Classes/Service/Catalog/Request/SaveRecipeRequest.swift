//
//  SaveRecipeRequest.swift
//  HairCare
//
//  Created by Андрей Чернышев on 19.11.2024.
//

import Alamofire

struct SaveRecipeRequest: APIRequestBody {
    let userToken: String
    let id: Int

    // TODO: заменить endpoint
    var url: String {
        GlobalDefinitions.dermatologyDomain + "/api/disease/save"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    // TODO: заменить disease_id
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.dermatologyApiKey,
            "_user_token": userToken,
            "disease_id": id
        ]
    }
}
