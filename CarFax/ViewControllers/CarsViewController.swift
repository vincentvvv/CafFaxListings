//
//  ViewController.swift
//  CarFax
//
//  Created by Vincent Vuong on 9/30/20.
//  Copyright © 2020 Vincent Vuong. All rights reserved.
//

import UIKit
import SnapKit

class ListingsViewController: UIViewController {
    private let viewModel: ListingsViewModel
    private let tableView =  UITableView()
    
    private lazy var loadingView = UIActivityIndicatorView(style: .large)
    private var cellHeightCache: [IndexPath: CGFloat] = [:]

    private let listingCellIdentifier = "ListingCell"

    init(viewModel: ListingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListingCell.self, forCellReuseIdentifier: listingCellIdentifier)

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets)
            make.bottom.left.right.equalToSuperview()
        }

        loadingView.isHidden = true
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalTo(tableView)
        }

        setupBindings()
        viewModel.fetchListings()
    }
    
    func setupBindings() {
        viewModel.state.subscribe(queue: .main, onNext: { state in
            switch state {
            case .loading: self.showLoader(true)
            case .loaded:
                self.showLoader(false)
                self.tableView.reloadData()
                if self.viewModel.listings.count == 0 {
                    self.showAlert(title: "Empty", message: "No listings available")
                }
            case .error(let error):
                self.showLoader(false)
                self.showAlert(title: "Error", message: error.message ?? "Error")
            }
        }).add(to: disposer)
    }

    private func showLoader(_ loading: Bool) {
        loadingView.isHidden = !loading
        loading ? loadingView.startAnimating() : loadingView.stopAnimating()
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alert, animated: true)
    }

    private func callDealer(phone: String) {
        guard let url = URL(string: String(format: "tel://%@", phone)), UIApplication.shared.canOpenURL(url) else {
            showAlert(title: "Error", message: String(format: "Unable to make phone call to: %@", phone))
            return
        }
        UIApplication.shared.open(url)
    }
}

extension ListingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeightCache[indexPath] = cell.bounds.size.height
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeightCache[indexPath] ?? 200
    }
}

extension ListingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let totalListings = viewModel.listings.count
        tableView.separatorStyle = totalListings > 0 ? .singleLine : .none
        return totalListings
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listingCell = tableView.dequeueReusableCell(withIdentifier: listingCellIdentifier) as? ListingCell else {
            return UITableViewCell()
        }
        listingCell.listing = viewModel.getListing(at: indexPath.row)
        listingCell.onTapPhoneButton = { [weak self] phone in
            self?.callDealer(phone: phone)
        }
        return listingCell
    }
}
