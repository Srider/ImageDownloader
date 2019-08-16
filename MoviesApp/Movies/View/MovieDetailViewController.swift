//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Srikar on 06/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit


class MovieDetailViewController: UITableViewController {

    var moviePresenter:ViewToPresenterProtocol?

    var objMovie:Movie? = nil
    var arrItems:Array<String>! = [" Image", " Title ", " Overview "," Homepage", " Vote Count ", " Vote Average"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK:  UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView)->Int {
        return arrItems.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 21))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)
        
        label.text = arrItems[section]
        
        label.textColor = UIColor.white
        
        headerView.backgroundColor = UIColor.orange
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 21
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var size:CGFloat! = 50.0
        
        switch indexPath.section {
        case 0:
            size = 200
        case 2:
            size = 150
            
        default:
            size = 50
        }
        return size
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        
        var cell: UITableViewCell?
        
        if indexPath.section == 0 {
            cell = self.configureImageInfoCell(tableView, cellForRowAt: indexPath)
        } else {
            cell = self.configureTextInfoCell(tableView, cellForRowAt: indexPath)
        }
        cell?.setNeedsDisplay()
        cell?.contentView.setNeedsDisplay()
        return cell!
    }
    
    func configureImageInfoCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        let cellIdentifier:String? = Constants.Cells.kImageCell
        let cell:ImageCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath) as! ImageCell
        if objMovie!.dImageData != nil {
            cell.imgMovieImage.image = UIImage.init(data: objMovie!.dImageData!)
        } else {
            cell.imgMovieImage.image = UIImage(named: "no-image")
        }
        return  cell
    }
    
    func configureTextInfoCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        let cellIdentifier:String? = Constants.Cells.kTextCell
        let cell:TextCell! = (tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath) as! TextCell)
        var strText:String?
        
        switch indexPath.section {
        case 1:
            strText = objMovie!.title
        case 2:
            strText = objMovie!.overview
        case 3:
            if objMovie!.homepage == nil {
                strText = "Not Available"
            } else {
                strText = objMovie!.homepage
            }
        case 4:
            strText = String(objMovie!.vote_count)
        case 5:
            strText = String(objMovie!.vote_average)
        default:
            strText = " Not Available"
        }
        
        cell.txtDescription.text = strText
        cell.setNeedsDisplay()
        cell.contentView.setNeedsDisplay()

        return cell!
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
