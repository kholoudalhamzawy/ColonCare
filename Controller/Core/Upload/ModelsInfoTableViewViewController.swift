//
//  ModelsInfoTableViewViewController.swift
//  colonCancer
//
//  Created by KH on 08/07/2023.
//

import UIKit

class ModelsInfoTableViewViewController:  UITableViewController {
    private let BackGroundView = backGroundView()

    func configureNavigationBar(){
        let ReminderView = UILabel()
        ReminderView.font = UIFont(name: "Poppins-Medium", size: 24)
        ReminderView.textColor = .label
        ReminderView.text = "Results"
        navigationItem.titleView = ReminderView
        navigationItem.backButtonTitle = " "

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        tableView = UITableView(frame: .zero, style: UITableView.Style.grouped)
        tableView.backgroundView = BackGroundView
        tableView.separatorColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        tableView.delegate = self

      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  navigationController?.hidesBarsOnSwipe = true
        if UploadViewViewModel.model.isSsequance {
            info = ModelsInfo.seqInfo
            headersForNavBar = ModelsInfo.headersForSeqNavBar
            fullInfo = ModelsInfo.fullSeqInfo
        } else {
            info = ModelsInfo.imageInfo
            headersForNavBar = ModelsInfo.headersForImageNavBar
            fullInfo = ModelsInfo.fullImageInfo
        }


    }

    // MARK: - Table view data source
    private var info: [String] = [""]
  
    
    private var headersForNavBar: [String]  = [""]
    
    private var fullInfo: [String]  = [""]
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return headersForNavBar.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
        // Return the desired height for the cell at the given indexPath
//            if indexPath.row == 0 {
//                // Set a custom height for the first cell
//                return 50 // Specify your desired height
//            } else {
                // Set the default height for other cells
                return UITableView.automaticDimension
//            }
    }
    
    //the height for the header above every section
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 18
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font =  UIFont(name: "Poppins-Medium", size: 20)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return UploadViewViewModel.model.requestResults[section]
    }
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = info[indexPath.row + indexPath.section]
            content.textProperties.color = .secondaryLabel
            content.textProperties.font =  UIFont(name: "Poppins-Regular", size: 18)!
            cell.contentConfiguration = content
            cell.backgroundColor = UIColor.clear
            cell.accessoryType = .detailDisclosureButton
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.numberOfLines = 0
            cell.sizeToFit()
            
           

            return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = InfoViewController(header: headersForNavBar[indexPath.section], body:  fullInfo[indexPath.row + indexPath.section]
)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc,
        animated: true)


    }


}



