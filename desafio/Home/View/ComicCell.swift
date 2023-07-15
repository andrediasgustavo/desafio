import UIKit
import SnapKit

final class ComicCell: UITableViewCell {
    
    lazy var comicImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14.0)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 12.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor.black
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupView()
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
    
    private func setupView() {
        self.contentView.addSubview(comicImage)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        self.comicImage.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let maxWidthContainer: CGFloat = 129
        let maxHeightContainer: CGFloat = 100

        
        self.comicImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8.0)
            make.top.equalToSuperview().offset(8.0)
            make.bottom.equalToSuperview().inset(8.0)
            make.width.equalTo(contentView.snp.height).multipliedBy(maxWidthContainer/maxHeightContainer)
            make.width.height.equalToSuperview().priority(.high)
            make.height.equalTo(maxHeightContainer)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.comicImage.snp.top)
            make.height.lessThanOrEqualTo(35)
            make.leading.equalTo(self.comicImage.snp.trailing).offset(8.0)
            make.right.equalTo(self).offset(-8.0)
           
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.comicImage.snp.trailing).offset(8.0)
            make.right.equalTo(self).offset(-8.0)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8.0)
            make.bottom.equalToSuperview().inset(8.0)
            make.height.greaterThanOrEqualTo(80)
        }
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
