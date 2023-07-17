import Foundation

func fetchMarvelData(completion:  @escaping (String?, [ComicItem]) -> Void) {
    let baseURL = "https://gateway.marvel.com/v1/public/"
    let endpoint = "comics"
    
    guard let url = URL(string: "\(baseURL)\(endpoint)?apikey=b7e14bab409c70a5c4e7c2b319c09d7b&ts=1682982412&hash=3482f01e9bf207a437a4b621c91339ad") else {
        print("Invalid URL")
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        guard let data = data else {
            print("No data received")
            return
        }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let data = json["data"] as? [String: Any],
                let results = data["results"] as? [Any] {
                
                let providedeBy = json["attributionText"] as? String
                
                let list = results.map { value -> ComicItem in
                    let item = value as? [String: Any]
                    return ComicItem(item)
                }
                
                completion(providedeBy, list)
            }
        } catch {
            print("Error parsing JSON: \(error.localizedDescription)")
        }
    }
    
    task.resume()
}
