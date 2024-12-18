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
    
    static let dermatologyDomain = "https://dermatology.awesum-apps.com"
    static let dermatologyApiKey = "7LexM8IGOSmIrpEimANw"
    
    static let otterScaleHost = "https://api.korrekted.com"
    static let otterScaleApiKey = "idl8iUtNylnJpstZ"
    
    static let applicationTag = "HAIR CARE"
    static let amplitudeApiKey = "d433d2c66723aeefd10c5b65f91c1fa3"
    
    static let termsOfServiceUrl = URL(string: "https://thinkaboutapps.com/terms")!
    static let privacyPolicyUrl = URL(string: "https://thinkaboutapps.com/policy")!
    static let contactUsUrl = URL(string: "https://thinkaboutapps.com/contact")!
    
    enum Paygate {
        static let yearly = "app.haircare.yearly"
        static let weekly = "app.haircare.weekly"
    }
}
