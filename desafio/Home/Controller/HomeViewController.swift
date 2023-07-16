import UIKit
import SnapKit
import Combine

final class HomeViewController: BaseVC<HomeViewModel> {
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.showsVerticalScrollIndicator = false
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        view.allowsSelection = false
        view.dataSource = self
        view.separatorStyle = .singleLine
        view.backgroundColor = .white
        view.register(ComicCell.self, forCellReuseIdentifier: "ComicCell")
        return view
    }()
    
    private var bottomLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 12.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.sizeToFit()
        return label
    }()
    
    var list: [ComicItem] = []
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        super.setupView()
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.view.addSubview(bottomLabel)
        self.view.addSubview(activityLoadIndicator)
        self.navigationItem.title = "Marvel Comics"
        self.setupConstraints()
    }
       
    override func setupConstraints() {
        super.setupConstraints()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityLoadIndicator.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16.0)
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().offset(16.0)
            make.bottom.equalToSuperview().inset(40.0)
        }
        
        self.bottomLabel.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(8.0)
            make.centerX.equalToSuperview()
        }
        
        self.activityLoadIndicator.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    override func bind(to vm: HomeViewModel) {
        super.bind(to: vm)
        
        vm.inputs.fetchMarvelComicsData()
        
        vm.outputs.comicsList.sink { [weak self] list in
            self?.list = list
            self?.tableView.reloadData()
        }
        .store(in: &subscriptions)
        
        vm.outputs.bottomLabelText.sink { [weak self] bottomText in
            self?.bottomLabel.text = bottomText
            self?.view.layoutIfNeeded()
        }
        .store(in: &subscriptions)
    }
}
