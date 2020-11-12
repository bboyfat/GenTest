//
//  AppState.swift
//  GenTech
//
//  Created by Andrey Petrovskiy on 12.11.2020.
//

import ReSwift

struct AppSate: StateType {
    var networkState: NetworkState = .loading
}

enum NetworkState {
    case loading
    case fetchNewRepos
    case reposDidLoad(Repo)
    case loadingFailed(String?)
}
