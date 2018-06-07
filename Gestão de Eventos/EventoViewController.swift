//
//  EventoViewController.swift
//  Gestão de Eventos
//
//  Created by Fernando Gomes on 07/06/2018.
//  Copyright © 2018 lfernando. All rights reserved.
//

import UIKit

class EventoViewController: UIViewController {

    var evento: Evento? = nil
    
    @IBOutlet weak var imgEventoView: UIImageView!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var inicioLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var clienteImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgEvento = NSData(base64Encoded: replace(img: (self.evento?.imagem)!), options: [])
        let imgCliente = NSData(base64Encoded: replace(img: (self.evento?.clienteImagem)!), options: [])
        
        nomeLabel.text = self.evento?.nome
        inicioLabel.text = self.evento?.inicio
        localLabel.text = self.evento?.local
        
        imgEventoView.image = UIImage(data: imgEvento! as Data)
        clienteImgView.image = UIImage(data: imgCliente! as Data)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func participantesButton(_ sender: Any) {
        let participantesViewController = storyboard?.instantiateViewController(withIdentifier: "participantes") as! ParticipantesViewController
        
        participantesViewController.evento = self.evento
        navigationController?.pushViewController(participantesViewController, animated: true)
    }
    
    func replace(img: String) -> String {
        if img.range(of:"data:image/png;base64,") != nil {
            return img.replacingOccurrences(of: "data:image/png;base64,", with: "")
        }else if img.range(of:"data:image/jpeg;base64,") != nil{
            return img.replacingOccurrences(of: "data:image/jpeg;base64,", with: "")
        }
        
        return ""
    }
}
