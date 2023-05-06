//
//  NewsManager.swift
//  NewsApp
//
//  Created by Hassane Sidibe on 4/15/23.
//

import Foundation

enum NewsCategory: String {
    case all = "all", national = "national", business = "business", sports = "sports",
         world = "world", politics = "politics", technology = "technology",
         startup = "startup", entertainment = "entertainment", miscellaneous = "miscellaneous",
         hatke = "hatke", science = "science", automobile = "automobile"
}

//MARK: NewsManagerDelegate
protocol NewsManagerDelegate {
    func didFinishFetchingNewsArticles (_ newsManager: NewsManager, newsModel: NewsModel)
    func didFailWithError(error: Error)
}


struct NewsManager {
    
    let baseNewsUrl = "https://inshorts.deta.dev/news?category="
    var delegate: NewsManagerDelegate?
    
    func fetchNews(category: NewsCategory) {
        let actualUrl = "\(baseNewsUrl)\(category.rawValue)"
        
        performRequest(urlString: actualUrl)
//        performRequest(urlString: "https://inshorts.deta.dev/news?category=entertainment")
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let err = error {
                    print(err)
                    return
                    
                } else {
                    if let safeData = data {
//                        print("Success fetching news data 🎉🎉🎉")
//                        print(String(data: safeData, encoding: .utf8))
                        if let newsModel = parseJson(newsData: safeData) {
                            //call delegate method
                            delegate?.didFinishFetchingNewsArticles(self, newsModel: newsModel)
                            
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
    
    
    
    func parseJson (newsData: Data) -> NewsModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(NewsData.self, from: newsData)
            
//            print("\n\nDecoded data:")
//            print(decodedData)
            //create and return a news model
            let newsModel = NewsModel(category: decodedData.category, articles: decodedData.data)
            return newsModel
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}


