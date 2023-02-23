//
//  UserViewModel.swift
//  Cathay-United-Bank-iOS-Homework
//
//  Created by 莊智凱 on 2023/2/16.
//

import Foundation

class UserViewModel {
    
    func fetchUserData(completion: @escaping (Result<User, Error>) -> Void) {
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: URL(string: "https://dimanyen.github.io/man.json")!)
                let userModel = try JSONDecoder().decode(UserModel.self, from: data)
                guard let user = userModel.response.first else { return }
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
