//
//  API.swift
//  GenTech
//
//  Created by Andrey Petrovskiy on 12.11.2020.
//

import Foundation

enum QueueLabel: String {
    case firstQueue = "firstQueque.lbl"
    case secondQueue = "secondQueue.lbl"
}

enum Configs {
    static var page = 0
    static var query = ""
    static var baseUrl: URL {
        return URL(string: "https://api.github.com/search/repositories?q=\(Configs.query)%3A%3E0&sort=stars&page=\(Configs.page)&per_page=15")!
    }
}

struct Fetch<M:Decodable> {
    let q: DispatchQueue
    func task(_ handler: @escaping(M) -> ()) {
        Configs.page.incr()
        q.async {
            print(Thread.current)
            URLSession.shared.dataTask(with: Configs.baseUrl) { (data, respons, error) in
                if let data = data {
                    guard let repos = parse(data: data) else {return}
                    handler(repos)
                }
            }.resume()
        }
        
    }
    
    private func parse(data: Data) -> M? {
        do {
            return try JSONDecoder().decode(M.self, from: data)
        } catch let decError {
            appStore.dispatch(ErrorAction(message: decError.localizedDescription))
            return nil
        }
        
    }
    
    init(queueLabel: QueueLabel, query: String) {
        self.q = DispatchQueue(label: queueLabel.rawValue, qos: .utility, attributes: .concurrent, target: .global())
    }
}

