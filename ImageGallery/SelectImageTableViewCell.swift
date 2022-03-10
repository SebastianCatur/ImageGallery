//
//  SelectImageTableViewCell.swift
//  ImageGallery
//
//  Created by Vasile Sebastian Catur on 10.03.2022.
//

import UIKit

class SelectImageTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var tabelLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    var keyToModify = ""
    var modifiedKey = ""
    var themesDefaults = [[String:[String]?]]()

    override class func awakeFromNib() {
        awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(activateTextField(recognizer: )))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(doubleTapGesture)
        let arr = UserDefaults.standard.array(forKey: "themesArrayOfDict") as? [[String:[String]?]]
        if let array = arr {
            themesDefaults = array
        }
    }

    @objc func activateTextField(recognizer: UITapGestureRecognizer) {
        tabelLabel.alpha = 0.0
        textField.alpha = 1.0
        textField.text = tabelLabel.text
        if let text = tabelLabel.text {
            keyToModify = text
        }
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tabelLabel.text = textField.text
        tabelLabel.alpha = 1.0
        textField.alpha = 0.0
        textField.resignFirstResponder()
        if let text = textField.text {
            modifiedKey = text
        }
        updateDict()
        return true
    }

    func updateDict() {
        for index in themesDefaults.indices {
            var dict = themesDefaults[index]
            for (key, _) in dict {
                if key == keyToModify {
                    dict.switchKey(fromKey: keyToModify, toKey: modifiedKey)
                    themesDefaults.remove(at: index)
                    themesDefaults.insert(dict, at: index)
                    UserDefaults.standard.removeObject(forKey: "themesArrayOfDict")
                    UserDefaults.standard.set(themesDefaults, forKey: "themesArrayOfDict")
                }
            }
        }
    }
}

extension Dictionary {
    mutating func switchKey(fromKey: Key, toKey: Key) {
        if let entry = removeValue(forKey: fromKey) {
            self[toKey] = entry
        }
    }
}
