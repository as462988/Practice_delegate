//
//  ViewController.swift
//  delegatePractice
//
//  Created by yueh on 2019/8/19.
//  Copyright © 2019 yueh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let firstSelectView = SelectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60.0))
    let secondSelectView = SelectionView(frame: CGRect(x: 0, y: 170, width: UIScreen.main.bounds.width, height: 60.0))
    
    let firstShowColorView = UIView()
    let secondShowColorView = UIView()
    
    let width = UIScreen.main.bounds.width
    let hight =  UIScreen.main.bounds.height

    let firstBtnArr = ["Yellow", "Blue"]
    
    let secondBtnArr = ["Black", "Yellow", "Blue"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstSelectView.dataSource = self
        firstSelectView.delegate = self

        secondSelectView.dataSource = self
        secondSelectView.delegate = self
        
        firstShowColorView.frame = CGRect(x: 0, y: firstSelectView.frame.height + 5, width: UIScreen.main.bounds.width, height: 100)
        
        firstShowColorView.backgroundColor = .yellow
        secondShowColorView.frame = CGRect(x: 0, y: 235, width: UIScreen.main.bounds.width, height: 120)
        
        secondShowColorView.backgroundColor = .black
        
        self.view.addSubview(firstSelectView)
        self.view.addSubview(secondSelectView)
        self.view.addSubview(firstShowColorView)
        self.view.addSubview(secondShowColorView)
    }
    
}

extension ViewController: SelectionViewDataSource {
    
    func selectQty(_ view: SelectionView) -> Int {
        
        if view == firstSelectView {
            
            return firstBtnArr.count
            
        } else {
            
            return secondBtnArr.count
        }
    }
    
    func setBtnTitle(_ view: SelectionView) -> [String] {
        
        if view == firstSelectView {
            
            return firstBtnArr
            
        } else {
            
            return secondBtnArr
        }
    }

}

extension ViewController: SelectionViewDelegate{
    
    func didSelectAt(_ index: Int,_ selection: UIButton,_ view: SelectionView)  {
        
        if view == firstSelectView {
            
            switch index{
                
            case 0: firstShowColorView.backgroundColor = .yellow
            case 1: firstShowColorView.backgroundColor = .blue
            default : break
            }
        }
        
        if view == secondSelectView {
            
            switch index {
            case 0: secondShowColorView.backgroundColor = .black
            case 1: secondShowColorView.backgroundColor = .yellow
            case 2: secondShowColorView.backgroundColor = .blue
            default : break
            }
        }
    }
    
    
    func canSelectBtn(at: Int, _ view: SelectionView) -> Bool {
        
        if view == firstSelectView {
            
            return true
            
        } else if view == secondSelectView {
            
            if firstSelectView.selectedTag == firstBtnArr.count - 1 {
                
                return false
                
            } else {
                
                return true
            }
            
        } else {
            
            return true
            
        }
    }
}
