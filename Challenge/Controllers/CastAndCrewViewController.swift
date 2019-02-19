//
//  CastAndCrewViewController.swift
//  Challenge
//
//  Created by Nah on 2/20/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

protocol CastAndCrewViewType: Presentable {}

typealias CastAndCrewViewControllerDependency = CastAndCrewViewController.Dependency
extension CastAndCrewViewController {
    struct Dependency {
        let viewModel: CastAndCrewViewModel
    }
}

class CastAndCrewViewController: BaseViewController, CastAndCrewViewType {
    var onErrorReceive: ((_ title: String?, _ error: Error) -> Void)?

    @IBOutlet private var movieTitleLabel: UILabel!
    @IBOutlet private var totalPeopleLabel: UILabel!
    @IBOutlet private var tableView: UITableView!

    private var viewModel: CastAndCrewViewModel!
    private let disposeBag = DisposeBag()

    // MARK: - View Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupData()
    }

    // MARK: - Setup

    func inject(_ dependency: Dependency) {
        viewModel = dependency.viewModel
    }

    private func setupUI() {
        navigationItem.title = L10n.wizemovie
    }

    private func setupData() {
        guard viewModel != nil else { fatalError("viewModel non-existed") }

        navigationItem.title = L10n.castAndCrews
        movieTitleLabel.text = "\(viewModel.detail.title) (\(viewModel.detail.releaseDate.toString(format: .isoYear)))"
        totalPeopleLabel.text = "\(viewModel.people.count) people"
        tableView.reloadData()
    }

    // Re-layout table header view manually, because auto-layout doesn't work for this case
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let headerView = tableView.tableHeaderView else { return }
        let size = headerView.systemLayoutSizeFitting(headerView.bounds.size)
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            tableView.tableHeaderView = headerView
        }
    }
}

extension CastAndCrewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CastAndCrewPeopleTableViewCell.self)

        guard let person = viewModel.people.get(at: indexPath.row) else { return cell }
        cell.person = person
        return cell
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? ViewSuspendable)?.suspend()
    }
}
