//

import Foundation

class URLs {
    let backend: URL

    init(fileName: String) {
        let bundle = Bundle.main
        guard
            let plistURL = bundle.url(forResource: fileName, withExtension: "plist"),
            let dict = NSDictionary(contentsOf: plistURL) else {
            fatalError("Expected URLs")
        }

        backend = url(for: "backend", in: dict)
    }
}

private func url(for key: String, in dict: NSDictionary) -> URL {
    guard let urlString = dict.value(forKey: key) as? String,
          let url = URL(string: urlString) else {
        //Crash early
        fatalError("Expected \(key)")
    }
    return url
}
