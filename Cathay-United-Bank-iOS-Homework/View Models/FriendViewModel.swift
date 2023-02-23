//
//  FriendViewModel.swift
//  Cathay-United-Bank-iOS-Homework
//
//  Created by 莊智凱 on 2023/2/16.
//

import Foundation

enum FriendSituation: CaseIterable {
    case noFriends, hasFriendsWithoutInvitations, hasFriendsAndInvitations
    var apiUrl: [URL] {
        switch self {
        case .noFriends:
            return [URL(string: "https://dimanyen.github.io/friend4.json")!]
        case .hasFriendsWithoutInvitations:
            return [URL(string: "https://dimanyen.github.io/friend1.json")!, URL(string: "https://dimanyen.github.io/friend2.json")!]
        case .hasFriendsAndInvitations:
            return [URL(string: "https://dimanyen.github.io/friend3.json")!]
        }
    }
    var description: String {
        switch self {
        case .noFriends:
            return "No Friends"
        case .hasFriendsWithoutInvitations:
            return "Has Friends but without Invitations"
        case .hasFriendsAndInvitations:
            return "Has Friends and Invitations"
        }
    }
}

class FriendViewModel {
    
    var situation: FriendSituation = .noFriends
    var friends: [Friend] = []
    var filteredFriends: [Friend] = []
    
    func fetchFriendsFromMultipleAPIs(completion: @escaping (Result<Void, Error>) -> Void) {
        friends.removeAll()
        let dispatchGroup = DispatchGroup()
        situation.apiUrl.forEach { url in
            dispatchGroup.enter()
            self.fetchFriends(url: url) { result in
                switch result {
                case .success(let friendModel):
                    let friends = self.unifyDateFormat(friendModel: friendModel)
                    self.loadFriendsIntoViewModel(friends: friends)
                    dispatchGroup.leave()
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            dispatchGroup.wait()
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.filteredFriends = self.friends
            completion(.success(()))
        }
    }
    
    func fetchFriends(url: URL, completion: @escaping (Result<FriendModel, Error>) -> Void) {
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let friendModel = try JSONDecoder().decode(FriendModel.self, from: data)
                completion(.success(friendModel))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func unifyDateFormat(friendModel: FriendModel) -> [Friend] {
        var formattedFriendModel = friendModel
        for index in 0..<formattedFriendModel.response.count {
            formattedFriendModel.response[index].updateDate.removeAll { character in
                character == "/"
            }
        }
        return formattedFriendModel.response
    }
    
    func loadFriendsIntoViewModel(friends: [Friend]) {
        self.friends.append(contentsOf: friends.filter { friend in
            !self.friends.contains { friendInViewModel in
                friendInViewModel.fid == friend.fid
            }
        })
    }
}
