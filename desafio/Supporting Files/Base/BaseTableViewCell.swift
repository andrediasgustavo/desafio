//
//  BaseTableViewCell.swift
//  desafio
//
//  Created by Andre Dias on 16/07/23.
//

import UIKit

open class BaseTableViewCell: UITableViewCell {
    
    //MARK: required inits and methods
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - View Life Cycle
    open func setupView() {
        self.setupConstraints()
    }
    
    /// Method for setup view constraints it is callend on `setupView`
    open func setupConstraints() { }
}
