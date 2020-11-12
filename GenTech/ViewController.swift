//
//  ViewController.swift
//  GenTech
//
//  Created by Andrey Petrovskiy on 12.11.2020.
//

import UIKit
import ReSwift

class ViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var model: [Items] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        searchBar.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: RepoCell.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: RepoCell.reuseIdentifier)
        appStore.subscribe(self)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.reuseIdentifier, for: indexPath) as? RepoCell else { return UITableViewCell()}
        let repo = model[indexPath.row]
        cell.set(repo)
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == model.count - 1 else { return }
        appStore.dispatch(FetchAction(fetchType: .loadMore))
    }
}

extension ViewController: StoreSubscriber {
    func newState(state: AppSate) {
        switch state.networkState {
        case .loading:
            ()
        case .reposDidLoad(let repos):
            self.model.append(contentsOf: repos.items.sorted(by: {$0.stargazers_count > $1.stargazers_count}))
        case .loadingFailed(let errorDescription):
            showError(errorDescription)
        case .fetchNewRepos:
            self.model = []
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        appStore.dispatch(FetchAction(query: text, fetchType: .new))
        searchBar.resignFirstResponder()
    }
}

