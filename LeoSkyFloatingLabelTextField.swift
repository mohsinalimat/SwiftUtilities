//
//  LeoSkyFloatingLabelTextField.swift
//  MedicalApp
//
//  Created by Apple on 02/02/17.
//  Copyright © 2017 vijayvirSingh. All rights reserved.
//

import UIKit

class LeoSkyFloatingLabelTextField: SkyFloatingLabelTextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        let toolbar = UIToolbar()

        toolbar.sizeToFit()

        let donebutton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(menuButtonTapped(sender:)))

        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        var arraybutton: [UIBarButtonItem] = []

        arraybutton.append(donebutton)

        arraybutton.append(space)

        arraybutton.append(donebutton)

        toolbar.setItems(arraybutton, animated: true)

        self.inputAccessoryView = toolbar

    }

    func menuButtonTapped(sender _: UIBarButtonItem) {

        _ = resignFirstResponder()

    }
}
