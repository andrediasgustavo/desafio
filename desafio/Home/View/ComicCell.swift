import UIKit
import SnapKit
import Kingfisher

final class ComicCell: BaseTableViewCell {
    // MARK: Properties
    lazy var comicImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 12.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()

    // MARK: UITableView Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        comicImage.image = nil
        titleLabel.text = ""
        descriptionLabel.text = ""
    }
    
    override func setupView() {
        self.contentView.addSubview(comicImage)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        
        self.setupConstraints()
    }
    
    override func setupConstraints() {
        self.comicImage.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.comicImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8.0)
            make.top.equalToSuperview().offset(16.0)
            make.bottom.equalToSuperview().inset(16.0)
            make.height.equalTo(120)
            make.width.equalTo(130)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.comicImage.snp.top)
            make.height.greaterThanOrEqualTo(10)
            make.leading.equalTo(self.comicImage.snp.trailing).offset(8.0)
            make.trailing.equalToSuperview().offset(-8.0)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.comicImage.snp.trailing).offset(8.0)
            make.trailing.equalToSuperview().offset(-8.0)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8.0)
            make.bottom.equalToSuperview().inset(16.0)
            make.height.greaterThanOrEqualTo(60)
        }
    }
}

extension ComicCell {
    // MARK: Setup Methods
    func updateModel(item: ComicItem) {
        self.comicImage.image = nil
        if let path = item.imagePath, let url = URL(string: path) {
            DispatchQueue.main.async {
                self.configureImage(url: url)
            }
        } else {
            self.comicImage.backgroundColor = .gray.withAlphaComponent(0.5)
        }
        self.titleLabel.text = !item.title.isEmpty ? item.title : Constants.noTitleCell
        self.descriptionLabel.text = !item.description.isEmpty ? item.description : Constants.noDescriptionCell
    }
    
    // MARK: Helper Methods
    private func configureImage(url: URL) {
        let processor = DownsamplingImageProcessor(size: self.comicImage.bounds.size)
        KF.url(url)
          .setProcessor(processor)
          .loadDiskFileSynchronously()
          .cacheMemoryOnly()
          .fade(duration: 0.1)
          .onSuccess { result in
              self.reloadInputViews()
          }
          .onFailure { error in }
          .set(to: self.comicImage)
    }
}
