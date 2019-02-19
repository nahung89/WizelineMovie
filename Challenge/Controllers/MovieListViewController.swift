//
//  MovieListViewController.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

protocol MovieListViewType: ErrorActionable {}

typealias MovieListViewControllerDependency = MovieListViewController.Dependency
extension MovieListViewController {
    struct Dependency {
        let viewModel: MovieListViewModel
    }
}

class MovieListViewController: BaseViewController, MovieListViewType {
    var onErrorReceive: ((_ title: String?, _ error: Error) -> Void)?

    @IBOutlet private var tableView: UITableView!
    private let refreshControl = UIRefreshControl()

    private var viewModel: MovieListViewModel!
    private let disposeBag = DisposeBag()

    // MARK: - View Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBinding()
        setupData()
    }

    // MARK: - Setup

    func inject(_ dependency: Dependency) {
        viewModel = dependency.viewModel
    }

    private func setupUI() {
        view.backgroundColor = UIColor.random()
        tableView.addSubview(refreshControl)
    }

    private func setupBinding() {
        guard viewModel != nil else { fatalError("viewModel non-existed") }

        refreshControl.rx.controlEvent(.valueChanged)
            .filter({ [unowned self] in self.refreshControl.isRefreshing })
            .bind(to: viewModel.onRefresh)
            .disposed(by: disposeBag)

        viewModel.viewState
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] state in
                switch state {
                case .working:
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                case let .error(error):
                    self.refreshControl.endRefreshing()
                    self.onErrorReceive?(L10n.error, error)
                default:
                    break
                }
            }).disposed(by: disposeBag)
    }

    private func setupData() {
        viewModel.refresh()
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieListTableViewCell.self)

        guard let movie = viewModel.movies.get(at: indexPath.row) else { return cell }
        cell.textLabel?.text = movie.title
        return cell
    }
}
