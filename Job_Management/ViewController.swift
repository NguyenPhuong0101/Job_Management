//
//  ViewController.swift
//  Job_Management
//
//  Created by Bảo Nguyễn on 4/7/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var monthLabel: UILabel!
    
    
    var totalSquares = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellsView()
        setMonthView()
        
        // Do any additional setup after loading the view.
        print("Git Tutorial")
    }
    func setCellsView()
    {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    func setMonthView(){
        totalSquares.removeAll()
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while(count <= 42){
            if(count <= startingSpaces || count - startingSpaces > daysInMonth ){
                totalSquares.append("")
            }
            else {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        monthLabel.text = CalendarHelper().monthString(date: selectedDate) +  "  " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath ) as! CalendarCell
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        return cell
     }

    @IBAction func previousmonth(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    
    @IBAction func nextMonth(_ sender: Any) {
        
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    override open var shouldAutorotate: Bool{
        return false
    }
    
}

