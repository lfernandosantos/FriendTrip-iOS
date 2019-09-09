//
//  CustomTextField.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 07/09/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import UIKit

protocol CustomTextFieldDelegate {
    func didTextUpdated(text: String)
}
class CustomTextField: UIView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    private var view: UIView?
    var textFieldDelegate: CustomTextFieldDelegate?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.nibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.nibSetup()
    }
    
    func configure(icon: UIImage? = nil,
                   backgroundColor: UIColor,
                   hint: String? = nil) {
        view?.layer.cornerRadius = 8
        self.layer.cornerRadius = 8
        //self.iconImageView.image = icon
        view?.backgroundColor = backgroundColor
    }
    
    private func nibSetup() {
        view = loadViewFromNib()
        view?.frame = bounds
        addSubview(view!)
        self.configure(backgroundColor: .white)
    }
    
    private func loadViewFromNib() -> UIView {
        
        let nib = UINib(nibName: "CustomTextField", bundle: nil)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return nibView
    }
}
