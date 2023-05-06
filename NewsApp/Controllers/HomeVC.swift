//
//  ViewController.swift
//  NewsApp
//
//  Created by Hassane Sidibe on 4/15/23.
//

import UIKit

class HomeVC: UIViewController, CategoryManager {

    var newsManager = NewsManager()
    
    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var categoryToDisplay: NewsCategory?
    var selectedArticle: Article?
    var selectedRowIndex: IndexPath?
    
    var articles: [Article] = [
        Article(author: "Hassane Sidibe", content: "sklkjlkad aslkdjlkj asdkjlkjas lkjasdjlj", date: "01-12-1888", id: "assssasd", imageUrl: "none", time: "08.00", title: "Explosion in the toilet"),
        Article(author: "Jeff Pessos", content: "sklkjlkad aslkdjlkj asdkjlkjas lkjasdjlj", date: "01-12-1888", id: "assssasd", imageUrl: "none", time: "08.00", title: "Explosion in the toilet")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articlesTableView.delegate = self
        articlesTableView.dataSource = self
        articlesTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.articleCell_id)
        newsManager.delegate = self
          
        categoryToDisplay = .technology
        categoryLabel.text = categoryToDisplay?.rawValue
        newsManager.fetchNews(category: categoryToDisplay!)
        activityIndicator.startAnimating()
        //Hide articlesTableView untill they are loaded, then make it visible in the network call delegate method
        articlesTableView.alpha = 0
    }

    
    @IBAction func categoryButtonPressed(_ sender: UIButton) {
        //segueue to CategoryVC
        self.performSegue(withIdentifier: K.goToCategoryView, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.goToCategoryView {
            let destinationVC = segue.destination as! CategoryVC
            destinationVC.currentCategory = categoryLabel.text
            destinationVC.delegate = self
            
        } else if segue.identifier == K.homeToDetail {
            let destinationVC = segue.destination as! NewsDetailVC
            destinationVC.article = selectedArticle
        }
    }
    
    func didFinishSelectingCategory(_ categoryVC: CategoryVC, chosenCategory: NewsCategory) {

        if categoryToDisplay != chosenCategory && categoryToDisplay != nil {
            //user chose a different category to be displayed
            self.categoryToDisplay = chosenCategory
            categoryLabel.text = categoryToDisplay?.rawValue
            newsManager.fetchNews(category: categoryToDisplay!)
        }
        print("Delegate method called after selecting Category.")
        print("User selected: \(chosenCategory.rawValue)")
    }
    
    func categoryChanged(_ categoryVC: CategoryVC) {
        self.activityIndicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Deselect row if user selected one
//        print("HomeVC wilAppear() called 🎉")
        if let unwrappedSelectedRowIndexPath = selectedRowIndex {
            
            articlesTableView.deselectRow(at: unwrappedSelectedRowIndexPath, animated: true)
        }
    }
}


//MARK: - TableView methods

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let article = articles[indexPath.row]
        let cell = articlesTableView.dequeueReusableCell(withIdentifier: K.articleCell_id, for: indexPath) as! CustomArticleCell
        cell.articleTitleLabel.text = article.title
        cell.articleTimeLabel.text = article.time

        UIImageView.loadImage(for: cell.articleImageView, imageUrlString: article.imageUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRowIndex = indexPath  //I will need this index to deselect the row
        let article = articles[indexPath.row]
        selectedArticle = article
        //perform segueue
        self.performSegue(withIdentifier: K.homeToDetail, sender: self)
    }
    
    
}




//MARK: NewsManager delegate implementation
extension HomeVC: NewsManagerDelegate {
    func didFinishFetchingNewsArticles(_ newsManager: NewsManager, newsModel: NewsModel) {
        DispatchQueue.main.async {
            self.articles = newsModel.articles
            self.articlesTableView.reloadData()
//            newsModel.printArticleTitleForTesting()
            self.activityIndicator.stopAnimating()
            self.articlesTableView.alpha = 1
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

