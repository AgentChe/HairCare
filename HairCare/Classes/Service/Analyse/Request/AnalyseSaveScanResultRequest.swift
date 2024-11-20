//
//  AnalyseSaveScanResultRequest.swift
//  ScinCare
//
//  Created by Андрей Чернышев on 31.10.2024.
//

import Alamofire

// TODO: убрать area
struct AnalyseSaveScanResultRequest: APIRequestBody {
    let anonymousId: String
    let internalId: String?
    let analyseId: String
    let title: String
    
    var url: String {
        GlobalDefinitions.domain + "/api/v1/ai/analyses/save"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var headers: HTTPHeaders? {
        [
            "Access-Token": GlobalDefinitions.apiKey
        ]
    }
    
    var parameters: Parameters? {
        var params: Parameters = [
            "anonymous_id": anonymousId,
            "analyses_id": analyseId,
            "title": title,
            "area": []
        ]
        
        if let internalId {
            params["internal_id"] = internalId
        }
        
        return params
    }
}
