//
//  Philosophy.swift
//  Bonheur_App
//
//  Created by Larderet on 04/11/2025.
//
import Foundation

// Enum pour les différents courants philosophiques
enum Philosophy: String, CaseIterable, Hashable {
    case epicurisme, confucianisme, bouddhisme, stoicisme
    
    var title: String {
        switch self {
        case .epicurisme: return "Epicurisme"
        case .confucianisme: return "Confucianisme"
        case .bouddhisme: return "Bouddhisme"
        case .stoicisme: return "Stoicisme"
        }
    }
    
    var description: String {
        switch self {
        case .epicurisme:
            return "L'épicurisme enseigne que le bonheur réside dans la recherche du plaisir et l'absence de douleur. Il privilégie les plaisirs simples, l'amitié sincère et la tranquillité de l'esprit. Pour Épicure, le bonheur s'atteint en se libérant des craintes inutiles et en vivant une vie modérée et réfléchie."
            
        case .confucianisme:
            return "Le confucianisme met l'accent sur l'harmonie sociale, le respect des traditions et la cultivation de vertus morales. Le bonheur découle de l'accomplissement de ses devoirs envers la famille et la société, ainsi que du perfectionnement de soi à travers l'éducation et la pratique des rituels."
            
        case .bouddhisme:
            return "Le bouddhisme enseigne que le bonheur véritable s'obtient en se libérant de la souffrance causée par l'attachement et le désir. À travers la méditation et la pratique du Noble Chemin Octuple, on atteint l'éveil et la sérénité intérieure en comprenant la nature impermanente de toutes choses."
            
        case .stoicisme:
            return "Le stoïcisme prône l'acceptation sereine de ce qui ne dépend pas de nous et la maîtrise de nos réactions. Le bonheur réside dans la vertu et la sagesse, en vivant conformément à la raison et à la nature. Les stoïciens cultivent la résilience face aux épreuves de la vie."
        }
    }
    
    var icon : String {
        switch self {
        case .epicurisme:
            return "IconeEpicurisme"
        case .confucianisme:
            return "IconConfusianisme"
        case .bouddhisme:
            return "IconBoudhisme"
        case .stoicisme:
            return "IconStoicisme"
        }
    }
}
