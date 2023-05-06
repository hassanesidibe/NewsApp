//
//  CategoryVC.swift
//  NewsApp
//
//  Created by Hassane Sidibe on 4/15/23.
//

import UIKit


//USE SYSTEM BACKGROUND COLOR AS THE COLOR FOR CATEGORYVS
//AND USE DEFAULT LABEL COLOR AS THE COLOR FOR THE LABELS


protocol CategoryManager {
    func didFinishSelectingCategory(_ categoryVC: CategoryVC, chosenCategory: NewsCategory)
    
    //Animate activity indicator in HomeVC
    func categoryChanged(_ categoryVC: CategoryVC)
}

class CategoryVC: UIViewController {

    var delegate: CategoryManager?
    var currentCategory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func categoryButtonPressed(_ sender: UIButton) {
        //trigger activity indicator in HomeVC
        let selectedCategoty = sender.titleLabel?.text
        if selectedCategoty != currentCategory {
            delegate?.categoryChanged(self)
        }
        
        if let upercasedchosenCategory = sender.titleLabel?.text {
            
            //convert chosen category to lowercase
            let chosenCategory = upercasedchosenCategory.lowercased()
            
            switch chosenCategory {
                
            case NewsCategory.national.rawValue:
                delegate?.didFinishSelectingCategory(self, chosenCategory: .national)
                
            case NewsCategory.business.rawValue:
                delegate?.didFinishSelectingCategory(self, chosenCategory: .business)
                
            case NewsCategory.sports.rawValue:
                delegate?.didFinishSelectingCategory(self, chosenCategory: .sports)
                
            case NewsCategory.world.rawValue:
                delegate?.didFinishSelectingCategory(self, chosenCategory: .world)
                
            case NewsCategory.politics.rawValue:
                delegate?.didFinishSelectingCategory(self, chosenCategory: .politics)
                
            case NewsCategory.technology.rawValue:
                delegate?.didFinishSelectingCategory(self, chosenCategory: .technology)
                
            case NewsCategory.startup.rawValue:
                delegate?.didFinishSelectingCategory(self, chosenCategory: .startup)
                
            case NewsCategory.entertainment.rawValue:
                delegate?.didFinishSelectingCategory(self, chosenCategory: .entertainment)
                
            case NewsCategory.hatke.rawValue:
                delegate?.didFinishSelectingCategory(self, chosenCategory: .hatke)
                
            case NewsCategory.science.rawValue:
                delegate?.didFinishSelectingCategory(self, chosenCategory: .science)
                
            case NewsCategory.automobile.rawValue:
                delegate?.didFinishSelectingCategory(self, chosenCategory: .automobile)
                
            default:
                delegate?.didFinishSelectingCategory(self, chosenCategory: .all)
                
            }
            
            self.dismiss(animated: true)
            print("CategoryVC should get dismissed")
        }
    }
    
}
