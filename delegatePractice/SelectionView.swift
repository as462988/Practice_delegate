//
//  SelectionView.swift
//  delegatePractice
//
//  Created by yueh on 2019/8/19.
//  Copyright © 2019 yueh. All rights reserved.
//

import Foundation
import UIKit

class SelectionView: UIView {
    
    var indicatorView = UIView()
    
    var btnArr: [UIButton] = []
    
    var selectedTag: Int?
    
    var dataSource: SelectionViewDataSource?{
        
        didSet {
            setBtn()
            addIndicatorView()
            
        }
    }

    var delegate: SelectionViewDelegate?

    
    func setBtn(){
        
        guard let dataSource = self.dataSource else {return}
        
        let btnNum = dataSource.selectQty(self)
        
        let width = (self.frame.width) / CGFloat(btnNum)
        
        for i in 0..<btnNum {
            let btn = UIButton(frame: CGRect(x: width * CGFloat(i) , y: 0, width: width, height: self.frame.height - 2))
            
            btn.setTitle(dataSource.setBtnTitle(self)[i], for: .normal)
            
            btn.setTitleColor(dataSource.setBtnColor(self), for: .normal)
            
            btn.titleLabel?.font = dataSource.setBtnTitleFont(self)
            
            btn.backgroundColor = .black
            
            btn.tag = i
            
            self.addSubview(btn)
            
            btn.addTarget(self, action: #selector(touchBtn(sender:)), for: .touchUpInside)
        }
    }
        
    @objc func touchBtn(sender: UIButton) {
        
        guard self.delegate?.canSelectBtn(at: sender.tag, self) == true else { return }
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.indicatorView.frame.origin.x = sender.frame.origin.x
        }
        
        self.delegate?.didSelectAt(sender.tag, sender, self)
        
        selectedTag = sender.tag
        
    }
    
    let width = UIScreen.main.bounds.width
    
    func addIndicatorView() {
        
        guard let dataSource = self.dataSource else {return}
        
        indicatorView.backgroundColor = dataSource.indicatorViewColor(self)
        
        indicatorView.frame = CGRect(x: 0, y: Int(self.frame.height), width: Int(width)/dataSource.selectQty(self), height: 2)
        
        self.addSubview(indicatorView)
    }

}

protocol SelectionViewDataSource{
    
    func indicatorViewColor(_ view: SelectionView) -> UIColor
    
    func setBtnTitleFont(_ view: SelectionView) -> UIFont
    
    func setBtnTitle(_ view: SelectionView) -> [String]
    
    func setBtnColor(_ view: SelectionView) -> UIColor
    
    func selectQty(_ view: SelectionView) -> Int

}

// default
extension SelectionViewDataSource {
    
    func indicatorViewColor(_ view: SelectionView) -> UIColor {
        
        return .blue
    }
    
    func setBtnTitleFont(_ view: SelectionView) -> UIFont {
        
        return UIFont.systemFont(ofSize: 18)
    }
    
    func setBtnColor(_ view: SelectionView) -> UIColor {
        
        return .white
    }
    
    func setBtnTitle(_ view: SelectionView) -> [String] {
        return ["Black", "Yellow", "Blue"]
    }
    
    func selectQty(_ view: SelectionView) -> Int {
        return 3
    }
    
}

protocol SelectionViewDelegate{
    
    func didSelectAt(_ index: Int,_ selection: UIButton,_ view: SelectionView)
    
    func canSelectBtn(at: Int, _ view: SelectionView ) -> Bool
    
    func unableSelection(at: Int,_ view: SelectionView)
    
    func enableSelection(at: Int,_ view: SelectionView)

}

extension SelectionViewDelegate {
    
    func didSelectAt(_ index: Int,_ selection: UIButton,_ view: SelectionView) {

    }
    
    
    func canSelectBtn(at: Int, _ view: SelectionView ) -> Bool {
        return true
    }
    
    func unableSelection(at: Int,_ view: SelectionView) {
        
        view.btnArr[at].isEnabled = false
        
    }
    
    func enableSelection(at: Int,_ view: SelectionView) {
        
        view.btnArr[at].isEnabled = true
        
    }
}

