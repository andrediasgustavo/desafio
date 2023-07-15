import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    
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
    
    private var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.style = .large
        view.color = .gray
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
    private var viewModel: HomeViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupView()
        getData()
    }
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.view.addSubview(bottomLabel)
        self.view.addSubview(activityIndicator)
        self.navigationItem.title = "Marvel Comics"
        self.setupConstraints()
    }
       
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
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
        
        self.activityIndicator.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func getData() {
        fetchMarvelData { providedBy, comicList in
            self.list = comicList
            
            DispatchQueue.main.async {
                self.bottomLabel.text = providedBy
                self.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicCell", for: indexPath) as! ComicCell

        let comic = self.list[indexPath.row]
        cell.updateModel(item: comic)
        return cell
    }
}

