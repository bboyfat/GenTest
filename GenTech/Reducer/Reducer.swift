//
//  Reducer.swift
//  GenTech
//
//  Created by Andrey Petrovskiy on 12.11.2020.
//

import ReSwift

func mainReducer(action: Action, state: AppSate?) -> AppSate {
    var state = state ?? AppSate()
    switch action {
    case let fetchaction as FetchAction:
        switch fetchaction.fetchType {
        case .new:
            state.networkState = .fetchNewRepos
        default:
            state.networkState = .loading
        }
    case let repos as ReposFetched<Repo>:
        state.networkState = .reposDidLoad(repos.repos)
    default:
        break
    }
    return state
}

