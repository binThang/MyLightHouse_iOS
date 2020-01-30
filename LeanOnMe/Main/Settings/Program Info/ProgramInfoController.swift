//
//  ProgramInfoController.swift
//  LeanOnMe
//
//  Created by Justin Ji on 01/11/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

class ProgramInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewForProgramInfoDelegate {
  
    
    var agreement: String?
    var privacy: String?
    var agreementSize: CGRect?
    var privacySize: CGRect?
    
    let cellId = "cellId"
    var sectionForProgramInfo =  [
        SectionForProgramInfo(title: "버전정보", content: [""], isExpanded: false),
        SectionForProgramInfo(title: "이용약관", content: ["ㅇㅇㅇ"], isExpanded: false),
        SectionForProgramInfo(title: "개인정보 처리방침 및 보호정책", content: ["법적으로 제재가 있는 것은 아니구요 단지 이용약관은 공정거래법 및 소비자 보호법에 가까운것이구요.\n개인정보처리 방침은 정보처리 보안법에 가깝다고 보시면 됩니다.\n\n쇼핑몰을 운영하고 사이트를 운영하는데 관련된 법령을 고지하고 이를 준수하는 것이라고 보시면 됩니다.\n고지만 하면 법적 제재는 없습니다."], isExpanded: false)
        ]
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
        
         self.agreementSize = estimateFrameForText(text: self.agreement!)
         self.privacySize = estimateFrameForText(text: self.privacy!)
        
        setNavitationItemTitle(navigationController: navigationController!, navigationItem: navigationItem, title: "프로그램 정보")
        
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
        tableView.register(ProgramInfoViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionForProgramInfo.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionForProgramInfo[section].content.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if sectionForProgramInfo[indexPath.section].isExpanded {
            if indexPath.section == 1 {
                self.agreementSize = estimateFrameForText(text: self.agreement!)
             
                return (agreementSize?.height)! + 20
            } else if indexPath.section == 2 {
                return (privacySize?.height)! + 20
            } else {
                return 50
            }
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! ProgramInfoViewCell

        
        if indexPath.section == 1 {
            cell.customTextView.text = agreement
        } else if indexPath.section == 2 {
            cell.customTextView.text = privacy
        } else {
            cell.customTextView.text = "Ver. 1.5"
        }
  
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderViewForProgramInfo()
        
        header.customInit(title: sectionForProgramInfo[section].title, section: section, delegate: self)
        return header
    }
    
    func willExpandSection(header: ExpandableHeaderViewForProgramInfo, section: Int) {
        sectionForProgramInfo[section].isExpanded = !sectionForProgramInfo[section].isExpanded
        
        tableView.beginUpdates()
        for i in 0 ..< sectionForProgramInfo[section].content.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    
    
}
