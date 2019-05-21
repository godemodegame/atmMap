import Foundation

// Url path to json file
var urlToData: URL {
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data.json"
    let urlPath = URL(fileURLWithPath: path)
    print(path)
    return urlPath
}

// Downloading new data.json
func loadAtms(completionHandler: (()->Void)?) {
    let urlString = "http://localhost:8080/api/atms"
    guard let url = URL(string: urlString) else { return }
    
    URLSession(configuration: .default).downloadTask(with: url) { (urlFile, responce, error) in
        guard let urlFile = urlFile else { return }
        do {
            try? FileManager.default.removeItem(at: urlToData)
            try FileManager.default.copyItem(at: urlFile, to: urlToData)
        } catch let error {
            print("-------|\(error)")
        }
        completionHandler?()
    }.resume()
}
