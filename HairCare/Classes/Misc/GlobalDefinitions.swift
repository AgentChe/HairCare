//
//  GlobalDefinitions.swift
//  Soccer
//
//  Created by Andrey Chernyshev on 16.01.2021.
//

import Foundation

final class GlobalDefinitions {
    static let domain = "https://hair.thinkaboutapps.com"
    static let apiKey = "K9tK6iIQ4mZZNnWhs9c9y3DI"
    
    static let dermatologyDomain = "https://dermatology.thinkaboutapps.com"
    static let dermatologyApiKey = "7LexM8IGOSmIrpEimANw"
    
    static let otterScaleHost = "https://api.korrekted.com"
    static let otterScaleApiKey = "idl8iUtNylnJpstZ"
    
    static let termsOfServiceUrl = URL(string: "https://thinkaboutapps.com/terms")!
    static let privacyPolicyUrl = URL(string: "https://thinkaboutapps.com/policy")!
    static let contactUsUrl = URL(string: "https://thinkaboutapps.com/contact")!
    
    enum Paygate {
        static let yearly = "mobile.hair.yearly"
        static let weekly = "mobile.hair.weekly"
    }
    
    enum References {
        static let nlm = URL(string: "https://www.nlm.nih.gov")!
        static let cdc = URL(string: "https://www.cdc.gov/health-topics.html")!
    }
}
