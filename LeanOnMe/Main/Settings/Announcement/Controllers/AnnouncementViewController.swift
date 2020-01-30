//
//  AnouncementViewController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 31/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class AnnouncementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate {

    let cellId = "cellId"
    var contentSize: CGRect?

//    var sections =  [
//        Section(title: "1월 공지사항입니다.", subtitle: "2017-01-01", content: ["1월에는 공지사항이 없습니다."], isExpanded: false),
//        Section(title: "2월 공지사항입니다.", subtitle: "2017-02-01",  content: ["2월에는 공지사항이 없습니다."], isExpanded: false),
//        Section(title: "3월 공지사항입니다.", subtitle: "2017-03-01",  content: ["3월에는 공지사항이 없습니다."], isExpanded: false),
//        Section(title: "4월 공지사항입니다.", subtitle: "2017-04-01", content: ["4월에는 공지사항이 없습니다."], isExpanded: false),
//        Section(title: "5월 공지사항입니다.", subtitle: "2017-05-01", content: ["5월에는 공지사항이 없습니다."], isExpanded: false)
//        ]

    var sections = [Section]()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.tableFooterView?.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        APIService.instance.fetchAnnouncement { (sectionArray) in
            self.sections = sectionArray
        }
        
        setNavitationItemTitle(navigationController: navigationController!, navigationItem: navigationItem, title: "공지사항")

        setupNavigationBar(navigationController: (navigationController)!, navigationItem: navigationItem, titile: "")
        view.backgroundColor = .white
        setupComponents()
    }
    
    func setupComponents() {
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            ])
        
        tableView.register(AnnouncementCell.self, forCellReuseIdentifier: "cellId")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].content.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if sections[indexPath.section].isExpanded {
            contentSize = estimateFrameForText(text: sections[indexPath.section].content.first!)
            return (contentSize?.height)! + 20
        } else {
            return 0
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 10
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! AnnouncementCell

        cell.customeLabel.text = sections[indexPath.section].content[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        
        header.customInit(title: sections[section].title, subtitle: sections[section].subtitle, section: section, delegate: self)
        return header
    }
    
    //헤더를 누르면 안에 공지사항의 글을 보여주는 함수
    func willExpandSection(header: ExpandableHeaderView, section: Int) {
        
        sections[section].isExpanded = !sections[section].isExpanded //true이면 false로, false이면 true로 바꿔줘서 열어주고 닫아주고 한다.
        
        tableView.beginUpdates()
        
        tableView.reloadRows(at: [IndexPath(row: 0, section: section)], with: .automatic)
//        for i in 0 ..< sections[section].content.count {
//             tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
//        }
        tableView.endUpdates()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


}


































































