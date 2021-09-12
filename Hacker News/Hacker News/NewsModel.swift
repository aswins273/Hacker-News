//
//  NewsModel.swift
//  Hacker News
//
//  Created by S, Aswin (623-Extern) on 12/09/21.
//

import Foundation

struct News : Codable {
    let hits: [NewsContent]
}

struct NewsContent : Codable {
    let title: String?
    let url: String?
    let author: String?
    let created_at_i: Int?
}
