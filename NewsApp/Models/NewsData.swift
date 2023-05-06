//
//  NewsData.swift
//  NewsApp
//
//  Created by Hassane Sidibe on 4/15/23.
//

import Foundation

struct NewsData: Decodable {
    let category: String
    let data: [Article]
}

struct Article: Decodable {
    let author: String
    let content: String
    let date: String
    let id: String
    let imageUrl: String
    let time: String
    let title: String
    
}

















