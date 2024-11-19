//
//  GetBookmarksInsightsRequest.swift
//  HairCare
//
//  Created by Андрей Чернышев on 19.11.2024.
//

import Alamofire

struct GetBookmarksInsightsRequest: APIRequestBody {
    let userToken: String

    // TODO: заменить endpoint
    var url: String {
        GlobalDefinitions.dermatologyDomain + "/api/disease/bookmarks"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.dermatologyApiKey,
            "_user_token": userToken
        ]
    }
}
