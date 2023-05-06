//
//  NewsModel.swift
//  NewsApp
//
//  Created by Hassane Sidibe on 4/15/23.
//

import Foundation

struct NewsModel {
    let category: String
    let articles: [Article]
    
    func printArticleTitleForTesting() {
        for article in articles {
            print(article.title)
        }
    }
}
