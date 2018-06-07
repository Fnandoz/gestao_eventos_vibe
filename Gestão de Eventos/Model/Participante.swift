//
//  Participantes.swift
//  Gestão de Eventos
//
//  Created by Fernando Gomes on 05/06/2018.
//  Copyright © 2018 lfernando. All rights reserved.
//

import Foundation
import SwiftyJSON

class Participante {
    var id = Int()
    var nome = String()
    var checkIn = String()
    var email = String()
    var assinatura = String()
    var DataCadastro = String()
    var Acompanhantes: [JSON] = []
    var status = Bool()
    
    
    init(id: Int, nome:String, checkIn:String) {
        self.id = id
        self.nome = nome
        self.checkIn = checkIn
    }
}

