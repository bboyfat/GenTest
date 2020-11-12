//
//  Model.swift
//  GenTech
//
//  Created by Andrey Petrovskiy on 12.11.2020.
//

import Foundation

struct Repo: Decodable{
    var items: [Items]
}

struct Items: Decodable {
    var name: String
    var owner: Owner
    var html_url: String
    var stargazers_count: Int
}

struct Owner: Decodable {
    var avatar_url: String
}
