//
//  NotificationsViewController.swift
//  colonCancer
//
//  Created by KH on 21/04/2023.
//

import UIKit
import UserNotifications
import Combine

class ReminderViewController: UIViewController, ReminderTableHeaderViewDelegate {
    
    private var viewModel = ReminderViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    func didTapAdd() {
        navigationController?.pushViewController(AddReminderViewController(), animated: true)

    }
    
    func TableReload() {
        DispatchQueue.main.async {
            self.remindersTableView.reloadData()
            }
    }
    private var Myprescreptions: [(Prescription,Bool)] = []
    
    func GetPrescription( _ prescreptions: [(Prescription,Bool)]){
        Myprescreptions = prescreptions
    }

    
    func configureNavigationBar(){
        let ReminderView = UILabel()
        ReminderView.font = UIFont(name: "Poppins-Medium", size: 24)
        ReminderView.textColor = .label
        ReminderView.text = "Your Medications"
        navigationItem.titleView = ReminderView
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapPlus))
        navigationItem.hidesBackButton = true
    }
    private var headerView: ReminderTableHeaderView?

    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.addSubview(remindersTableView)
        
        headerView = ReminderTableHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 210))
        headerView?.delegate = self
        remindersTableView.tableHeaderView = headerView
        
        remindersTableView.delegate = self
        remindersTableView.dataSource = self
        remindersTableView.separatorColor = UIColor.clear
        configureNavigationBar()
        bindViews()
    }
   
    
    
    private let remindersTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ReminderTableViewCell.self, forCellReuseIdentifier: ReminderTableViewCell.identifier)
        return tableView
    }()
 
    
    func bindViews(){

        ReminderViewViewModel.model.$prescriptions.sink{ [weak self] _ in
            DispatchQueue.main.async {
                self?.remindersTableView.reloadData()
            }
        }.store(in: &subscriptions)

//        viewModel.$categories.sink{ [weak self] _ in
//            DispatchQueue.main.async {
//                self?.kidsAccountsTableView.reloadData()
//            }
//        }.store(in: &subscriptions)
//
    }
    private let BackGroundView = backGroundView()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        remindersTableView.frame = view.frame
        remindersTableView.backgroundView = BackGroundView
    }
    
    @objc private func didTapPlus(){
        navigationController?.pushViewController(AddReminderViewController(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //this will make the navigation bar appear again after it's hidden in the profile controller
        navigationController?.navigationBar.isHidden = false
//        viewModel.getChildren()
        TableReload()
    }
   
}

extension ReminderViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Myprescreptions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderTableViewCell.identifier, for: indexPath) as? ReminderTableViewCell else {
            return UITableViewCell()
        }

        let medModel = Myprescreptions[indexPath.row]

        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        cell.configureMed(name: medModel.0.name, dose: medModel.0.quantity, amount: medModel.0.amount, type: medModel.0.type as? MedType ?? .injection, time:  dateFormatter.string(from: medModel.0.time), id: medModel.0.id)
        

        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        remindersTableView.deselectRow(at: indexPath, animated: true)
        let cell = remindersTableView.cellForRow(at: indexPath) as? ReminderTableViewCell
        cell?.toggleCheck()
        
//        let childModel = viewModel.childern[indexPath.row]
//        navigationController?.pushViewController(KidDetailViewController(name: childModel.name, phone: childModel.phone, balance: childModel.balance, categories: ChildrenViewViewModel.model.categories ?? []), animated: true)

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {//trailing is when you swap to the left, there is leading function to swap to the right
       
        let deleteAction = UIContextualAction(style: .destructive, title: "delete"){//.destructive make the background color red
            (action,view,completionHandler) in
            //order matters, you have to delete it first from the data base and save it then from the array because we're using the array indexpath to access the table in the database
//            self.context.delete(self.itemArray[indexPath.row])
//            self.saveItems()
//            self.itemArray.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
            completionHandler(true) //means i finished editing in this function (deletAction), deleted in the arr and the tableview
        }
      
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

    
    
//
//        @IBOutlet var table: UITableView!
//
//        var models = [MyReminder]()
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            table.delegate = self
//            table.dataSource = self
//        }
//
//        @IBAction func didTapAdd() {
//            // show add vc
//            guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else {
//                return
//            }
//
//            vc.title = "New Reminder"
//            vc.navigationItem.largeTitleDisplayMode = .never
//            vc.completion = { title, body, date in
//                DispatchQueue.main.async {
//                    self.navigationController?.popToRootViewController(animated: true)
//                    let new = MyReminder(title: title, date: date, identifier: "id_\(title)")
//                    self.models.append(new)
//                    self.table.reloadData()
//
//                    let content = UNMutableNotificationContent()
//                    content.title = title
//                    content.sound = .default
//                    content.body = body
//
//                    let targetDate = date
//                    let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],
//                                                                                                              from: targetDate),
//                                                                repeats: false)
//
//                    let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
//                    UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
//                        if error != nil {
//                            print("something went wrong")
//                        }
//                    })
//                }
//            }
//            navigationController?.pushViewController(vc, animated: true)
//
//        }
//
//        @IBAction func didTapTest() {
//            // fire test notification
//            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
//                if success {
//                    // schedule test
//                    self.scheduleTest()
//                }
//                else if error != nil {
//                    print("error occurred")
//                }
//            })
//        }
//
//        func scheduleTest() {
//            let content = UNMutableNotificationContent()
//            content.title = "Hello World"
//            content.sound = .default
//            content.body = "My long body. My long body. My long body. My long body. My long body. My long body. "
//
//            let targetDate = Date().addingTimeInterval(10)
//            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],
//                                                                                                      from: targetDate),
//                                                        repeats: false)
//
//            let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
//            UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
//                if error != nil {
//                    print("something went wrong")
//                }
//            })
//        }
//
//    }
//
//    extension ViewController: UITableViewDelegate {
//
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
//
//    }
//
//
//    extension ViewController: UITableViewDataSource {
//
//        func numberOfSections(in tableView: UITableView) -> Int {
//            return 1
//        }
//
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return models.count
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//            cell.textLabel?.text = models[indexPath.row].title
//            let date = models[indexPath.row].date
//
//            let formatter = DateFormatter()
//            formatter.dateFormat = "MMM, dd, YYYY"
//            cell.detailTextLabel?.text = formatter.string(from: date)
//
//            cell.textLabel?.font = UIFont(name: "Arial", size: 25)
//            cell.detailTextLabel?.font = UIFont(name: "Arial", size: 22)
//            return cell
//        }
//
//    }
//
//
//    struct MyReminder {
//        let title: String
//        let date: Date
//        let identifier: String
//    }

//}
