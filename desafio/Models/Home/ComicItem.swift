struct ComicItem {
    let title: String
    let description: String
    var imagePath: String?
    
    init(_ item: [String: Any]?) {
        self.title = item?["title"] as? String ?? "Sem titulo"
        
        self.imagePath = nil
        if let thumbnail = item?["thumbnail"] as? [String: Any] {
            if let path = thumbnail["path"] as? String , let pathExtension = thumbnail["extension"] as? String {
                self.imagePath = "\(path).\(pathExtension)"
            }
        }
        
        self.description = item?["description"] as? String ?? "Sem descrição"
    }
}
