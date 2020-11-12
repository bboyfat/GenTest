//
//  File.swift
//  GenTech
//
//  Created by Andrey Petrovskiy on 12.11.2020.
//

import ReSwift
import Foundation

enum LoadingType {
    case new
    case loadMore
}

struct FetchAction: Action {
    
    var fetchType: LoadingType
    
    init(query: String = Configs.query, fetchType: LoadingType = .new) {
        self.fetchType = fetchType
        switch fetchType {
        case .new:
            Configs.query = query
            Configs.page = 0
        default:
            ()
        }
        Fetch<Repo>(queueLabel: .firstQueue, query: query).task { (repos) in
            DispatchQueue.main.async {
                appStore.dispatch(ReposFetched<Repo>(repos: repos))
            }
        }
        Fetch<Repo>(queueLabel: .secondQueue, query: query).task { (repos) in
            DispatchQueue.main.async {
                appStore.dispatch(ReposFetched<Repo>(repos: repos))
            }
        }
    }
}

struct ReposFetched<M: Decodable>: Action {
    let repos: M
}

struct ErrorAction: Action {
    var message: String?
}
