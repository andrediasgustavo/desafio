struct ComicItem {
    let title: String
    let description: String
    var imagePath: String?
    
    init(_ item: MarvelComicsResult) {
        self.title = item.title
        
        if let path = item.thumbnail.path, !path.isEmpty, let thumbExtension = item.thumbnail.thumbnailExtension, !thumbExtension.isEmpty {
            self.imagePath = "\(path).\(thumbExtension)"
        }
        
        self.description = item.description ?? "Sem descrição"
    }
}
