//
//  ReminderTableHeaderView.swift
//  colonCancer
//
//  Created by KH on 21/05/2023.
//

import UIKit
import Combine

protocol ReminderTableHeaderViewDelegate: AnyObject {
    func didTapAdd()
    func TableReload()
    func GetPrescription( _ prescreptions: [(Prescription,Bool)])
}

class ReminderTableHeaderView: UIView, AddReminderViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    private var viewModel = ReminderViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    func didTapAdd() {
        delegate?.didTapAdd()
        
        delegate?.GetPrescription(ReminderViewViewModel.model.eventsForDate(date: selectedDate))
        collectionView.reloadData()
        delegate?.TableReload()
    }
    

    weak var delegate: ReminderTableHeaderViewDelegate?
  
   
    private var headerView = AddReminderView()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 43, height: 70)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 360, height: 72), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ReminderCollectionViewCell.self, forCellWithReuseIdentifier: ReminderCollectionViewCell.identifier)
        return collectionView
    }()
    
//    private var days: [UILabel] = ["Sat","Sun", "Mon", "Tue", "Wed","Thu", "Fri"]
//
//    private lazy var daysStack: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: days)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.distribution = .equalSpacing
//        stackView.axis = .horizontal
//        stackView.alignment = .center
//        return stackView
//    }()
    
    
   
    
    
    var selectedDate = CalendarHelper.getCurrentDate()
    var totalSquares = [Date]()
    var days = ["Sun", "Mon", "Tue", "Wed","Thu", "Fri", "Sat"]
    var week = [String]()
    
    func setWeekView()
    {
        totalSquares.removeAll()
        
//        var current = CalendarHelper().sundayForDate(date: selectedDate)
//        let nextSunday = CalendarHelper().addDays(date: current, days: 7)
        
//        while (current < nextSunday)
//        {
//            totalSquares.append(current)
//            current = CalendarHelper().addDays(date: current, days: 1)
//        }
        
        selectedDate = CalendarHelper.getCurrentDate()
        var PastOfWeak = CalendarHelper().addDays(date: selectedDate, days: -3)
        var restOfWeak = CalendarHelper().addDays(date: selectedDate, days: 3)
        var day = CalendarHelper().weekDay(date: PastOfWeak)
        
        while (PastOfWeak <= restOfWeak)
        {
            if (day > 6 ) {
                day = 0
            }
            totalSquares.append(PastOfWeak)
            week.append(days[day])
            PastOfWeak = CalendarHelper().addDays(date: PastOfWeak, days: 1)
            day = day + 1
        }

        collectionView.reloadData()
        delegate?.TableReload()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReminderCollectionViewCell.identifier, for: indexPath) as? ReminderCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let date = totalSquares[indexPath.item]
        let dateString = String(CalendarHelper().dayOfMonth(date: date))
        let day = week[indexPath.item]
        cell.configure(day: day, date: dateString)
        cell.backgroundColor = UIColor(red: 0.673, green: 0.391, blue: 0.954, alpha: 0.7)
        if(date == selectedDate)
        {
            cell.layer.cornerRadius = 15
            
        }
        else
        {
            cell.backgroundColor = .clear
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        selectedDate = totalSquares[indexPath.item]
        ReminderViewViewModel.model.modelSelcetedDate =  totalSquares[indexPath.item]

        delegate?.GetPrescription(ReminderViewViewModel.model.eventsForDate(date: selectedDate))
        collectionView.reloadData()
        delegate?.TableReload()

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        headerView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false


        addSubview(collectionView)
        
        setWeekView()
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerView)
        
        delegate?.GetPrescription(ReminderViewViewModel.model.eventsForDate(date: selectedDate))
        collectionView.reloadData()
        delegate?.TableReload()

    }
    
    
       override func willMove(toSuperview newSuperview: UIView?) {
           super.willMove(toSuperview: newSuperview)
           if newSuperview != nil {
               setWeekView()
           }
       }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds

        applyConstraints()


    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    private func applyConstraints(){
        
        let collectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            collectionView.heightAnchor.constraint(equalToConstant: 70),
            collectionView.widthAnchor.constraint(equalToConstant: 355),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 18),

//            collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        
        let headerViewConstraints = [
            headerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 18),
            headerView.heightAnchor.constraint(equalToConstant: 90),
            headerView.widthAnchor.constraint(equalToConstant: 355),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),

//            headerView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        NSLayoutConstraint.activate(collectionViewConstraints)
        NSLayoutConstraint.activate(headerViewConstraints)

        
    }
}





