//
//  CardListViewController.swift
//  HearthstoneAPIConsumer
//
//  Created by Johnatas Rodrigues on 27/05/23.
//

import UIKit

class CardListViewController: UIViewController {
    private var tableView: UITableView!
    private var viewModel: CardListViewModel!
    private var loadingIndicator: UIActivityIndicatorView!
    private var alertView: UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        
        setupTableView()
        setupViewModel()
        fetchData()
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CardListTableViewCell.self, forCellReuseIdentifier: CardListTableViewCell.reuseIdentifier)
    }
    
    private func setupViewModel() {
        viewModel = CardListViewModel()
        viewModel.delegate = self
    }
    
    private func fetchData() {
        showLoadingIndicator()
        viewModel.fetchCards()
    }
    
    private func showLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        loadingIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }
    
    private func showAlert(message: String) {
        alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertView?.addAction(okAction)
        
        if let alert = alertView {
            present(alert, animated: true, completion: nil)
        }
    }
}

extension CardListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardListTableViewCell.reuseIdentifier, for: indexPath) as? CardListTableViewCell else {
            return UITableViewCell()
        }
        
        let card = viewModel.cards[indexPath.row]
        cell.configure(with: card)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 64
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCard = viewModel.cards[indexPath.row]
//        let cardDetailViewController = CardDetailViewController(card: selectedCard)
//        navigationController?.pushViewController(cardDetailViewController, animated: true)
    }
}

extension CardListViewController: CardListViewModelDelegate {
    func cardsFetched() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.hideLoadingIndicator()
        }
    }
    
    func cardsFetchFailed(withError error: Error) {
        DispatchQueue.main.async {
            self.hideLoadingIndicator()
            self.showAlert(message: error.localizedDescription)
        }
    }
}
