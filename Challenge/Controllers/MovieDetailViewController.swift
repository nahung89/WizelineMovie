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

protocol MovieDetailViewType: ErrorActionable, SettingActionable {
    var onCastCrewSelect: ((_ detail: MovieDetail, _ credits: MovieCredits) -> Void)? { get set }
}

typealias MovieDetailViewControllerDependency = MovieDetailViewController.Dependency
extension MovieDetailViewController {
    struct Dependency {
        let viewModel: MovieDetailViewModel
    }

    enum Section {
        case detail, credits
    }

    enum Row {
        case backdrop, title, summary
        case casts
        case director
    }
}

class MovieDetailViewController: BaseViewController, MovieDetailViewType {
    var onErrorReceive: ((_ title: String?, _ error: Error) -> Void)?
    var onCastCrewSelect: ((_ detail: MovieDetail, _ credits: MovieCredits) -> Void)?
    var onSettingSelect: (() -> Void)?

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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: L10n.setting, style: .plain, target: nil, action: nil)
        tableView.addSubview(refreshControl)
        tableView.register(headerFooterViewType: MovieDetailTableHeaderView.self)
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard
            let _section = viewModel.sections.get(at: section),
            let rows = viewModel.rowsInSections[_section]
        else { return 0 }
        return rows.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let _section = viewModel.sections.get(at: section) else { return nil }
        switch _section {
        case .credits:
            let headerView = tableView.dequeueReusableHeaderFooterView(MovieDetailTableHeaderView.self)
            headerView?.onSeeAllButtonSelect = { [weak self] in
                guard let self = self else { return }
                self.onCastCrewSelect?(self.viewModel.movieDetail, self.viewModel.movieCredits)
            }
            return headerView

        case .detail:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let _section = viewModel.sections.get(at: section) else { return 1 }
        switch _section {
        case .credits:
            return 44
        case .detail:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let section = viewModel.sections.get(at: indexPath.section),
            let row = viewModel.rowsInSections[section]?.get(at: indexPath.row)
        else { return UITableViewCell() }

        switch row {
        case .backdrop:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieDetailBackdropTableViewCell.self)
            cell.movie = viewModel.movieDetail
            return cell

        case .title:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieDetailBaseInfoTableViewCell.self)
            cell.movie = viewModel.movieDetail
            return cell

        case .summary:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieDetailSumaryTableViewCell.self)
            cell.movie = viewModel.movieDetail
            return cell

        case .casts:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieDetailCastTableViewCell.self)
            cell.casts = viewModel.movieCredits.casts
            return cell

        case .director:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieDetailDirectorTableViewCell.self)
            cell.crews = viewModel.movieCredits.crews
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? ViewSuspendable)?.suspend()
    }
}
