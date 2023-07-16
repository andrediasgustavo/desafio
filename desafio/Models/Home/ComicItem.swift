struct ComicItem {
    let title: String
    let description: String
    var imagePath: String?
    
    init(_ item: MarvelComicsResult) {
        self.title = item.title
        
        self.imagePath = nil
        self.imagePath = "\(item.thumbnail.path).\(item.thumbnail.thumbnailExtension)"
        
        self.description = item.description ?? "Sem descrição"
    }
}
