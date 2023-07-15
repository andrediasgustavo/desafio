import UIKit

class ComicCell: UITableViewCell {
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        comicImage.image = nil
        titleLabel.text = ""
        descriptionLabel.text = ""
    }
    
    func updateModel(item: ComicItem) {
        self.comicImage.backgroundColor = .gray.withAlphaComponent(0.5)
        self.comicImage.image = nil
        if let path = item.imagePath, let url = URL(string: path) {
            downloadImage(from: url, completion: { image in
                DispatchQueue.main.async {
                    self.comicImage.image = image
                }
            })
        }
        
        self.titleLabel.text = item.title
        self.descriptionLabel.text = item.description
    }
}

extension ComicCell {
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            completion(image)
        }
        
        task.resume()
    }
}
