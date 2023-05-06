//
//  NewsDetailVC.swift
//  NewsApp
//
//  Created by Hassane Sidibe on 4/15/23.
//

import UIKit

class NewsDetailVC: UIViewController {
//    I STPPED HERE ON PURPOSE
    var article: Article?
    
    
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    
    
    @IBOutlet weak var contentStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let unwrappedArticle = self.article {
            UIImageView.loadImage(for: articleImageView, imageUrlString: unwrappedArticle.imageUrl)
            
            titleLabel.text = unwrappedArticle.title
            authorLabel.text = unwrappedArticle.author
            contentTextView.text = unwrappedArticle.content
            
        } else {
            print("Unable to display article, because it is nil")
        }
    }
    
}

extension UIImageView {
    
    static func loadImage(for imageView: UIImageView, imageUrlString: String) {
        DispatchQueue.global(qos: .background).async {
                   do{
                       let data = try Data.init(contentsOf: URL.init(string: imageUrlString)!)
                          DispatchQueue.main.async {
                             let image: UIImage? = UIImage(data: data)
                              imageView.image = image
                          }
                    }
                   catch let errorLog {
                        debugPrint(errorLog.localizedDescription)
                  }
            }
    }
    

}
