//

import Foundation

class Config {
    fileprivate enum Environment: String {
        case production
        case staging

        var URLsFileName: String {
            switch self {
            case .production: return "URLs"
            case .staging: return "StagingURLs"
            }
        }
    }

    static let global = Config()

    let URLs: URLs

    init() {
        registerAdHocDefaults()

        let environment = prefferedEnvironment()
        URLs = .init(fileName: environment.URLsFileName)
    }
}

private func registerAdHocDefaults() {
    let bundle = Bundle.main
    guard
        let URL = bundle.url(forResource: "AdHocDefaults", withExtension: "plist"),
        let defaults = NSDictionary(contentsOf: URL) as? [String: Any] else {
        return
    }

    let standardDefaults = UserDefaults.standard
    standardDefaults.register(defaults: defaults)
}

private func prefferedEnvironment() -> Config.Environment {
    let standardDefaults = UserDefaults.standard
    guard
        let envString = standardDefaults.string(forKey: "environment_preference"),
        let environment = Config.Environment(rawValue: envString) else {
        return .production
    }
    return environment
}
