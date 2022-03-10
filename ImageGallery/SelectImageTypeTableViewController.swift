//
//  SelectImageTypeTableViewController.swift
//  ImageGallery
//
//  Created by Vasile Sebastian Catur on 07.03.2022.
//

import UIKit

class SelectImageTypeTableViewController: UITableViewController {

    private var selectedUrls = [String]()
    var keyToModify = ""
    var number = 0
    var themesDefaults = [[String:[String]?]]()
    var recentlyDeleted = [[String:[String]?]]()
    var array = UserDefaults.standard.array(forKey: "themesArrayOfDict") as? [[String:[String]?]]



    override func viewDidLoad() {
        super.viewDidLoad()
        if let array = array {
            themesDefaults = array
        }
    }

    @IBAction func addTheme(_ sender: UIBarButtonItem) {
        number += 1
        var dict = [String:[String]]()
        dict["Untitled \(number)"] = [String]()
        themesDefaults.append(dict)
        updateThemeDefaults()
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if recentlyDeleted.isEmpty {
            return 1
        } else {
            return 2
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return themesDefaults.count
        case 1:
            return recentlyDeleted.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "Recently Deleted"
        default:
            return nil
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectImageTableViewCell", for: indexPath)
        if let cell = cell as? SelectImageTableViewCell {
            switch indexPath.section {
            case 0:
                cell.tabelLabel.text = themesDefaults[indexPath.row].keys.first
            case 1:
                cell.tabelLabel.text = recentlyDeleted[indexPath.row].keys.first
            default:
                cell.tabelLabel.text = ""
            }
        }
        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let arr = UserDefaults.standard.array(forKey: "themesArrayOfDict") as? [[String:[String]?]]
            if let array = arr {
                themesDefaults = array
            }

            if !themesDefaults[indexPath.row].values.isEmpty {
                if let imgListUrls = themesDefaults[indexPath.row].values.first {
                    selectedUrls = imgListUrls ?? [""]
                }

                if let key = themesDefaults[indexPath.row].keys.first {
                    keyToModify = key
                }
                performSegue(withIdentifier: "ShowImages", sender: indexPath.row)
            }
        } else {
            for subview in tableView.subviews where subview is SelectImageTableViewCell {
                for recognizer in subview.gestureRecognizers ?? [] {
                    subview.removeGestureRecognizer(recognizer)
                }
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        if splitViewController?.preferredDisplayMode != UISplitViewController.DisplayMode.oneOverSecondary {
//            splitViewController?.preferredDisplayMode = UISplitViewController.DisplayMode.oneOverSecondary
//        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ImageCollectionVC {
            vc.imageListUrls = selectedUrls
            vc.keyToModify = keyToModify
        }
    }


    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            switch indexPath.section {
            case 0:
                recentlyDeleted.append(themesDefaults[indexPath.row])
                themesDefaults.remove(at: indexPath.row)
                updateThemeDefaults()
                tableView.reloadData()
            case 1:
                recentlyDeleted.remove(at: indexPath.row)
                tableView.reloadData()
            default:
                print("")
            }
        }
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        if indexPath.section == 1 {
            let action = UIContextualAction(style: .normal,
                                            title: "Favourite") { [weak self] (action, view, completionHandler) in
                self?.handleSwipeLeading(indexPath: indexPath.row)
                                                completionHandler(true)
            }
            action.backgroundColor = .green
            return UISwipeActionsConfiguration(actions: [action])
        } else {
            return nil
        }
    }

    private func handleSwipeLeading(indexPath: Int) {
        themesDefaults.append(recentlyDeleted[indexPath])
        recentlyDeleted.remove(at: indexPath)
        updateThemeDefaults()
        tableView.reloadData()
    }

    private func updateThemeDefaults () {
        UserDefaults.standard.removeObject(forKey: "themesArrayOfDict")
        UserDefaults.standard.set(themesDefaults, forKey: "themesArrayOfDict")
    }
}
