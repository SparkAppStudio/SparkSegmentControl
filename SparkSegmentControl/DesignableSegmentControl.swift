//
//  DesignableSegmentControl.swift
//  SparkSegmentControl
//
//  Created by YupinHuPro on 10/8/17.
//  Copyright © 2017 YupinHuPro. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableSegmentControl: UIControl {


    // MARK: -
    // MARK: Variables

    var selector: UIView!
    var buttons = [UIButton]()
    var selectedSegmentIndex = 0


    // MARK: -
    // MARK: IBs

    @IBInspectable var commaSeparatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }


    // MARK: -
    // MARK: Function Overrides
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height / 2

        layer.borderColor = UIColor.clear.cgColor
        //addBottomBorder(.lightGray, width: 2)
        updateView()
    }


    // MARK: -
    // Public Functions

    public func updateToIndex(_ index: Int) {
        tapped(button: buttons[index])
    }


    // MARK: -
    // MARK: Private Functions

    private func updateView() {
        buttons.removeAll()
        subviews.forEach{ $0.removeFromSuperview() }

        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")

        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }

        buttons.first?.setTitleColor(.black, for: .normal)

        let selectorHeight: CGFloat = 2
        let selectorWidth = frame.width / CGFloat(buttons.count)
        selector = UIView(frame: CGRect(x: 0, y: self.bounds.maxY - selectorHeight, width: selectorWidth, height: selectorHeight)
        )
        selector.layer.cornerRadius = frame.height/2
        selector.backgroundColor = UIColor.black
        addSubview(selector)


        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        sv.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    @objc private func buttonTapped(button: UIButton)  {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(UIColor.lightGray, for: .normal)
            if btn == button {
                selectedSegmentIndex = buttonIndex
                let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3, animations: {
                    self.selector.frame.origin.x = selectorStartPosition
                })
                btn.setTitleColor(.black, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }


    private func tapped(button: UIButton)  {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(UIColor.lightGray, for: .normal)
            if btn == button {
                selectedSegmentIndex = buttonIndex
                let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3, animations: {
                    self.selector.frame.origin.x = selectorStartPosition
                })
                btn.setTitleColor(.black, for: .normal)
            }
        }
    }

}
