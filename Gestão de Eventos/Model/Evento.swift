//
//  Evento.swift
//  Gestão de Eventos
//
//  Created by Fernando Gomes on 05/06/2018.
//  Copyright © 2018 lfernando. All rights reserved.
//

import Foundation

class Evento {
    var id: Int
    var nome: String
    var imagem: String
    var clienteImagem: String
    var inicio: String
    var local: String
    
    init(id: Int, nome: String, imagem: String, clienteImagem: String, inicio: String, local: String) {
        self.id = id
        self.nome = nome
        self.imagem = imagem
        self.clienteImagem = clienteImagem
        self.inicio = inicio
        self.local = local
    }
}
