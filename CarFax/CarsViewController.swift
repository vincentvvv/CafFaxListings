//
//  ViewController.swift
//  CarFax
//
//  Created by Vincent Vuong on 9/30/20.
//  Copyright © 2020 Vincent Vuong. All rights reserved.
//

import UIKit
import SnapKit

class CarsViewController: UIViewController, UITableViewDelegate {
    private let viewModel: CarsViewModel
    private let tableView =  UITableView()
    
    private lazy var loadingView = UIActivityIndicatorView(style: .large)

    init(viewModel: CarsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


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

    func showLoader(_ loading: Bool) {
        loadingView.isHidden = !loading
        loading ? loadingView.startAnimating() : loadingView.stopAnimating()
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true)
    }
}

