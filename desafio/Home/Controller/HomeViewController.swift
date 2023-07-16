import UIKit
import SnapKit
import Combine
import SwiftUI

final class HomeViewController: BaseVC<HomeViewModel> {
    
    // MARK: Properties
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.showsVerticalScrollIndicator = false
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        view.allowsSelection = false
        view.dataSource = self
        view.separatorStyle = .singleLine
        view.backgroundColor = .white
        view.register(ComicCell.self, forCellReuseIdentifier: Constants.comicCellReuseIdentfier)
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
    
    private var errorView: UIView?
    var list: [ComicItem] = []
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: Life Cycle View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        super.setupView()
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.view.addSubview(bottomLabel)
        self.view.addSubview(activityLoadIndicator)
        self.navigationItem.title = Constants.homeTitle
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
            make.trailing.equalToSuperview().inset(16.0)
            make.bottom.equalToSuperview().inset(40.0)
        }
        
        self.bottomLabel.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(8.0)
            make.centerX.equalToSuperview()
        }
        
        self.activityLoadIndicator.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalTo(70)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: Bind method to HomeViewModel
    override func bind(to vm: HomeViewModel) {
        super.bind(to: vm)
        
        vm.inputs.fetchMarvelComicsData()
        
        vm.outputs.isLoading.sink { [weak self] isLoading in
            self?.handleActivityIndicator(isLoading: isLoading)
        }
        .store(in: &subscriptions)

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
        
        vm.outputs.error.sink { [weak self] error in
            self?.handleErrorView(error: error)
        }
        .store(in: &subscriptions)
    }
    
    // MARK: Helper methods
    private func handleActivityIndicator(isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            if isLoading {
                self?.errorView?.isHidden = true
                self?.activityLoadIndicator.isHidden = false
                self?.tableView.isHidden = true
                self?.activityLoadIndicator.startAnimating()
            } else {
                self?.tableView.isHidden = false
                self?.activityLoadIndicator.stopAnimating()
                self?.activityLoadIndicator.isHidden = true
                self?.view.layoutSubviews()
                self?.tableView.reloadData()
            }
        }
    }
    
    private func handleErrorView(error: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let errorViewSwiftUI = UIHostingController(rootView: ErrorView(viewModel: self.viewModel, messageError: error))
            self.errorView = errorViewSwiftUI.view
            if let errorView = self.errorView {
                self.view.addSubview(errorView)
                errorView.isHidden = false
                self.tableView.isHidden = true
                self.errorView?.translatesAutoresizingMaskIntoConstraints = false

                self.errorView?.snp.makeConstraints { make in
                    make.top.equalToSuperview()
                    make.bottom.equalToSuperview()
                    make.leading.equalToSuperview()
                    make.trailing.equalToSuperview()
                }

                self.view.layoutSubviews()
            }
        }
    }
}
