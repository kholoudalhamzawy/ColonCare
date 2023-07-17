//
//  backGroundView.swift
//  colonCancer
//
//  Created by KH on 20/05/2023.
//

import UIKit

class backGroundView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds
        colors.setBackGround(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
}
