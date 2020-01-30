//
//  AgreementViewCell.swift
//  LeanOnMe
//
//  Created by Justin Ji on 27/10/2017.
//  Copyright © 2017 Justin Ji. All rights reserved.
//

import UIKit

public let checkBox_borderColour = UIColor.darkGray.withAlphaComponent(0.2)
public let checkBox_backgroundColour = UIColor.lightGray.withAlphaComponent(0.3)
public let unselected_textColour = UIColor.darkGray.withAlphaComponent(0.7)
public let selected_textColour = UIColor.darkGray
public let paragraph_textColour = UIColor.darkGray.withAlphaComponent(0.8)

class AgreementViewCell: UICollectionViewCell {
    
    var isOneChecked: Bool = false
    var isTwoChecked: Bool = false
    var isThreeChecked: Bool = false
    var isFourChecked: Bool = false
    var isAgreementViewed: Bool = false
    
    let agreementString = "\n\n기쁨을 나누면 배가되고 슬픔을 나누면 반이 된다는 말이\n있습니다.\n여러분의 기쁨은 배로 슬픔은 반으로 나누어주세요.\n여러분은 혼자가 아닙니다.\n\n\"내 등에 기대\"를 찾아온 모두의 학창시절이 반짝반짝\n빛났으면 좋겠습니다.\n\n서로의 이야기에 공감하고, 함께 고민을 해결해 나감으로써\n모두가 행복할 수 있는 이야기 공간을 만드는 것이\n\"내 등에 기대\"가 지향하는 원칙과 방향입니다."
    
    let agreementTextview: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let paragraphOne: UILabel = {
        let label = UILabel()
        label.text = "\"내 등에 기대\"는 내가 이야기하고 싶은 것이라면 무엇이든\n 말할 수 있는 이야기 공간입니다.\n자신의 경험, 생각, 감정, 고민을 자유롭고 솔직하게\n이야기 해주세요.\n\n기쁨을 나누면 배가되고 슬픔을 나누면 반이 된다는 말이\n있습니다.\n여러분의 기쁨은 배로 슬픔은 반으로 나누어주세요.\n여러분은 혼자가 아닙니다.\n\n\"내 등에 기대\"를 찾아온 모두의 학창시절이 반짝반짝\n빛났으면 좋겠습니다.\n\n서로의 이야기에 공감하고, 함께 고민을 해결해 나감으로써\n모두가 행복할 수 있는 이야기 공간을 만드는 것이\n\"내 등에 기대\"가 지향하는 원칙과 방향입니다."
        label.textColor = UIColor.darkGray
        label.numberOfLines = 20
        label.font = komaconFont(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cautionLabel: UILabel = {
        let label = UILabel()
        label.text = "다음의 약속을 꼭 지켜주세요."
        label.textColor = .red
        label.textAlignment = .center
        label.font = komaconFont(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var checkBoxOne: UIButton = {
        let button = UIButton()
        button.layer.borderColor = checkBox_borderColour.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = checkBox_backgroundColour
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCheckBoxOne), for: .touchUpInside)
        return button
    }()
    
    let agreementOne: UILabel = {
        let label = UILabel()
        label.text = "동의합니다."
        label.textColor = unselected_textColour
        label.font = komaconFont(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let borderOne: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let paragraphTwo: UILabel = {
        let label = UILabel()
        label.text = "친구의 이야기를 존중해 주세요.\n내 이야기가 존중받고 싶듯 다른누군가의 이야기를 존중해야합니다.\n용기를 내어 자신의 이야기를 들려준 친구에게 공감과 지지를\n보내주세요."
        label.textColor = paragraph_textColour
        label.numberOfLines = 5
        label.font = komaconFont(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var checkBoxTwo: UIButton = {
        let button = UIButton()
        button.layer.borderColor = checkBox_borderColour.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = checkBox_backgroundColour
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCheckBoxTwo), for: .touchUpInside)
        return button
    }()
    
    let agreementTwo: UILabel = {
        let label = UILabel()
        label.text = "동의합니다."
        label.textColor = unselected_textColour
        label.font = komaconFont(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let borderTwo: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let paragraphThree: UILabel = {
        let label = UILabel()
        label.text = "욕설 및 비방, 성적 수치심 유발, 개인정보 요구, 상업적 목적의\n흥보 등의 게시글 및 댓글은 신고를 받게 되며 무통보로 삭제됩니다."
        label.textColor = paragraph_textColour
        label.numberOfLines = 5
        label.font = komaconFont(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var checkBoxThree: UIButton = {
        let button = UIButton()
        button.layer.borderColor = checkBox_borderColour.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = checkBox_backgroundColour
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCheckBoxThree), for: .touchUpInside)
        return button
    }()
    
    let agreementThree: UILabel = {
        let label = UILabel()
        label.text = "동의합니다."
        label.textColor = unselected_textColour
        label.font = komaconFont(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let borderThree: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let paragraphFour: UILabel = {
        let label = UILabel()
        label.text = "게시글 및 댓글을 3번이상 신고받은 계정은 이용이 중지되며 재가입이\n불가합니다."
        label.textColor = paragraph_textColour
        label.numberOfLines = 5
        label.font = komaconFont(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var completeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.darkGray
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = komaconFont(18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCompleteButton), for: .touchUpInside)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        setupComponents()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}































































