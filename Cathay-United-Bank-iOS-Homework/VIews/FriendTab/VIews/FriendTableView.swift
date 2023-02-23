//
//  FriendTableView.swift
//  Cathay-United-Bank-iOS-Homework
//
//  Created by 莊智凱 on 2023/2/20.
//

import UIKit

protocol FriendTableViewDelegate: AnyObject {
    func searchBarTextDidBeginEditing(_ controller: FriendTableView)
    func searchBarTextDidEndEditing(_ controller: FriendTableView)
}

class FriendTableView: UIView {
    
    weak var delegate: FriendTableViewDelegate?

    // MARK: - Variables and Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var friendTableView: UITableView!
    var friendViewModel: FriendViewModel!
    
    // MARK: - Life Cycle
    init(friendViewModel: FriendViewModel) {
        super.init(frame: CGRect())
        customInit(friendViewModel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
}

// MARK: - Setup
fileprivate extension FriendTableView {
    func customInit(_ friendViewModel: FriendViewModel? = nil) {
        if let friendViewModel {
            self.friendViewModel = friendViewModel
        }
        setupView()
        setupSearchBar()
        setupFriendTableView()
    }
    
    func setupView() {
        let view = Bundle.main.loadNibNamed("\(FriendTableView.self)", owner: self, options: nil)!.first as! UIView
        view.frame = bounds
        addSubview(view)
    }
    
    func setupSearchBar() {
        searchBar.backgroundImage = UIImage()
    }
    
    func setupFriendTableView() {
        let nib = UINib(nibName: "\(FriendTableViewCell.self)", bundle: nil)
        friendTableView.register(nib, forCellReuseIdentifier: "\(FriendTableViewCell.self)")
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refreshTable), for: .valueChanged)
        friendTableView.refreshControl = refreshControl
    }
}

// MARK: - UITableViewDataSource
extension FriendTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friendViewModel.filteredFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(FriendTableViewCell.self)", for: indexPath) as? FriendTableViewCell else {
            return UITableViewCell()
        }
        cell.updateUI(friend: friendViewModel.filteredFriends[indexPath.row])
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension FriendTableView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        delegate?.searchBarTextDidBeginEditing(self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchBarTextDidBeginEditing(self)
        if searchText.isEmpty {
            friendViewModel.filteredFriends = friendViewModel.friends
        } else {
            friendViewModel.filteredFriends = friendViewModel.friends.filter {
                $0.name.contains(searchText)
            }
        }
        friendTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.searchBarTextDidEndEditing(self)
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        delegate?.searchBarTextDidEndEditing(self)
    }
}

// MARK: - Private Method
private extension FriendTableView {
    @objc func refreshTable() {
        friendViewModel.fetchFriendsFromMultipleAPIs { result in
            switch result {
            case .success():
                self.searchBar.text = ""
                self.searchBar.resignFirstResponder()
                self.friendTableView.reloadData()
                self.friendTableView.refreshControl?.endRefreshing()
            case .failure(let error):
                print(error)
            }
        }
    }
}
