//
//  MovieDetailViewController.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

protocol MovieDetailViewType: ErrorActionable {}

typealias MovieDetailViewControllerDependency = MovieDetailViewController.Dependency
extension MovieDetailViewController {
    struct Dependency {
        let viewModel: MovieDetailViewModel
    }
}

class MovieDetailViewController: BaseViewController, MovieDetailViewType {
    var onErrorReceive: ((_ title: String?, _ error: Error) -> Void)?

    @IBOutlet private var tableView: UITableView!
    private let refreshControl = UIRefreshControl()

    private var viewModel: MovieDetailViewModel!
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
        navigationItem.title = L10n.wizemovie
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

extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieDetailBackdropTableViewCell.self)
            cell.movie = viewModel.movieDetail
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieDetailBaseInfoTableViewCell.self)
            cell.movie = viewModel.movieDetail
            return cell

        case 2:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieDetailSumaryTableViewCell.self)
            cell.movie = viewModel.movieDetail
            return cell

        default:
            assertionFailure("out of range")
            return UITableViewCell()
        }
    }
}
