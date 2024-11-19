//
//  UnsaveInsightRequest.swift
//  HairCare
//
//  Created by Андрей Чернышев on 19.11.2024.
//

import Alamofire

struct UnsaveInsightRequest: APIRequestBody {
    let userToken: String
    let ids: [Int]

    // TODO: заменить endpoint
    var url: String {
        GlobalDefinitions.dermatologyDomain + "/api/disease/unsave"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    // TODO: заменить diseases_ids
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.dermatologyApiKey,
            "_user_token": userToken,
            "diseases_ids": ids
        ]
    }
}
