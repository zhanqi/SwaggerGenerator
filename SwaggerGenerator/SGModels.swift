//
//  SGModels.swift
//  SwaggerGenerator
//
//  Created by mac on 5/3/2021.
//

import Foundation
import SightKit

class SGModel {
    var swagger:String? //":"2.0",
    var info:SG_info? //":Object{...},
    var host:String? //":"47.115.54.215:8085",
    var basePath:String? //":"/",
    var tags:[String:String] = [:] //":Array[15],
    var paths:[SG_path] = [] //":Object{...},
    var securityDefinitions:SG_securityDefinitions? //":Object{...},
    var definitions:[SG_definition] = [] //":Object{...}
    
    required convenience public init(json:SKJSON) {
        self.init()
        self.swagger = json["swagger"].string
        self.info = SG_info(json: json["info"])
        self.host = json["host"].string
        self.basePath = json["basePath"].string
        for value in json["tags"].arrayValue {
            tags[value["name"].stringValue] = value["description"].string
        }
        for (key,value) in json["paths"].dictionaryValue {
            let p = SG_path(json: value)
            p.path = key
            paths.append(p)
        }
        self.securityDefinitions = SG_securityDefinitions(json: json["securityDefinitions"])
        for (_,value) in json["definitions"].dictionaryValue {
            let p = SG_definition(json: value)
            definitions.append(p)
        }
    }
}

class SG_info{
    var description:String?
    var version:String?
    var title:String?
    var contact:SG_info_contact?
    
    required convenience public init(json:SKJSON) {
        self.init()
        self.description = json["description"].string
        self.version = json["version"].string
        self.title = json["title"].string
        self.contact = SG_info_contact(json: json["contact"])
    }
}

class SG_info_contact{
    var name:String?
    
    required convenience public init(json:SKJSON) {
        self.init()
        self.name = json["name"].string
    }
}

class SG_path {
    var path:String = ""
    
    var methods:[SG_path_method] = []
    
    required convenience public init(json:SKJSON) {
        self.init()
        for (key,value) in json.dictionaryValue {
            let p = SG_path_method(json: value)
            p.method = key
            methods.append(p)
        }
    }
}

class SG_path_method {
    var method:String = ""

    var tags:[String] = [] //":Array[1],
    var summary:String? //":"取消关注",
    var operationId:String? //":"deleteUsingPOST",
    var consumes:[String] = [] //":Array[1],
    var produces:[String] = [] //":Array[1],
    var parameters:[SG_path_method_parameter] = [] //":Array[1],
    var responses:[SG_path_method_response] = [] //":Object{...},
    #warning("todo")
    var security:[Any] = []
    var deprecated:Bool = false //":
    
    required convenience public init(json:SKJSON) {
        self.init()
        for value in json["tags"].arrayValue {
            tags.append(value.stringValue)
        }
        self.summary = json["summary"].string
        self.operationId = json["operationId"].string
        for value in json["consumes"].arrayValue {
            consumes.append(value.stringValue)
        }
        for value in json["produces"].arrayValue {
            produces.append(value.stringValue)
        }
        for value in json["parameters"].arrayValue {
            parameters.append(SG_path_method_parameter(json: value))
        }
        for (key,value) in json["responses"].dictionaryValue{
            let r = SG_path_method_response(json: value)
            r.code = key
            responses.append(r)
        }
        self.deprecated = json["deprecated"].boolValue
    }
}

class SG_path_method_parameter{
    var name:String?
    var `in`:String?
    var description:String?
    var required:Bool?
    var type:String?
    var format:String?
    var schema:SG_path_method_parameter_schema?
    var items:SG_path_method_parameter_items?
    var collectionFormat:String?
    required convenience public init(json:SKJSON) {
        self.init()
        self.name = json["name"].string
        self.`in` = json["in"].string
        self.description = json["description"].string
        self.required = json["required"].boolValue
        self.type = json["type"].string
        self.format = json["format"].string
        self.schema = SG_path_method_parameter_schema(json: json["schema"])
        self.items = SG_path_method_parameter_items(json: json["items"])
        self.collectionFormat = json["collectionFormat"].string
    }
}

class SG_path_method_parameter_items{
    var type:String?
    var format:String?
    required convenience public init(json:SKJSON) {
        self.init()
        self.type = json["type"].string
        self.format = json["format"].string
    }
}

class SG_path_method_parameter_schema{
    var originalRef:String?
    var ref:String?
    
    required convenience public init(json:SKJSON) {
        self.init()
        self.originalRef = json["originalRef"].string
        self.ref = json["$ref"].string
    }
}
class SG_path_method_response{
    var code:String?
    var description:String?
    var schema:SG_path_method_parameter_schema?
    
    required convenience public init(json:SKJSON) {
        self.init()
        self.description = json["description"].string
        self.schema = SG_path_method_parameter_schema(json: json["schema"])
    }
}

class SG_securityDefinitions{
    var Authorization:SG_securityDefinitions_Authorization?
    
    required convenience public init(json:SKJSON) {
        self.init()
        self.Authorization = SG_securityDefinitions_Authorization(json: json["Authorization"])
    }
}
class SG_securityDefinitions_Authorization{
    var type:String?
    var name:String?
    var `in`:String?
    required convenience public init(json:SKJSON) {
        self.init()
        self.type = json["type"].string
        self.name = json["name"].string
        self.`in` = json["in"].string
    }
}

class SG_definition{
    var type:String?
    var required:String?
    var properties:[SG_definition_property] = []
    var title:String?
    required convenience public init(json:SKJSON) {
        self.init()
        self.type = json["type"].string
        self.required = json["required"].string
        for (key,value) in json["properties"].dictionaryValue{
            let p = SG_definition_property(json: value)
            p.name = key
            properties.append(p)
        }
        self.title = json["title"].string
    }
}

class SG_definition_property{
    var name:String?
    var type:String?
    var format:String?
    var description:String?
    var originalRef:String?
    var ref:String?
    var items:SG_path_method_parameter_schema?
    required convenience public init(json:SKJSON) {
        self.init()
        self.name = json["name"].string
        self.type = json["type"].string
        self.format = json["format"].string
        self.description = json["description"].string
        self.originalRef = json["originalRef"].string
        self.ref = json["$ref"].string
        items = SG_path_method_parameter_schema(json: json["items"])
    }
}
