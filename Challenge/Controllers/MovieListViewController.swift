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

protocol MovieListViewType: ErrorActionable, SettingActionable {
    var onMovieSelect: ((_ movie: Movie) -> Void)? { get set }
}

typealias MovieListViewControllerDependency = MovieListViewController.Dependency
extension MovieListViewController {
    struct Dependency {
        let viewModel: MovieListViewModel
    }
}

class MovieListViewController: BaseViewController, MovieListViewType {
    var onErrorReceive: ((_ title: String?, _ error: Error) -> Void)?
    var onMovieSelect: ((_ movie: Movie) -> Void)?
    var onSettingSelect: (() -> Void)?

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
        navigationItem.title = L10n.wizemovie
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: L10n.setting, style: .plain, target: nil, action: nil)
        tableView.addSubview(refreshControl)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Ad")
    }

    private func setupBinding() {
        guard viewModel != nil else { fatalError("viewModel non-existed") }

        navigationItem.rightBarButtonItem?.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.onSettingSelect?()
            }).disposed(by: disposeBag)

        refreshControl.rx.controlEvent(.valueChanged)
            .filter({ [unowned self] in self.refreshControl.isRefreshing })
            .bind(to: viewModel.onRefresh)
            .disposed(by: disposeBag)

        tableView.rx.contentOffset
            .skip(1)
            .filter { [unowned self] offset in
                guard self.tableView.contentSize.height > 0 else { return false }
                return offset.y + 300 >= self.tableView.contentSize.height - self.tableView.bounds.height
            }
            .map { _ in () }
            .bind(to: viewModel.onLoadMore)
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
        return viewModel.feeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let feed = viewModel.feeds.get(at: indexPath.row) else { return UITableViewCell() }

        switch feed {
        case let .ad(advertise):
            let cell = tableView.dequeueReusableCell(withIdentifier: "Ad", for: indexPath)
            cell.textLabel?.text = advertise.name
            cell.contentView.backgroundColor = .lightGray
            return cell

        case let .movie(movie):
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieListTableViewCell.self)
            cell.movie = movie
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }

        guard let feed = viewModel.feeds.get(at: indexPath.row) else { return }

        switch feed {
        case let .movie(movie):
            onMovieSelect?(movie)
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? ViewSuspendable)?.suspend()
    }
}
