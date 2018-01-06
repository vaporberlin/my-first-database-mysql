import Vapor
import FluentProvider

final class User: Model {
  var storage = Storage()
  var username: String
  
  init(username: String) {
    self.username = username
  }
  
  func makeRow() throws -> Row {
    var row = Row()
    try row.set("username", username)
    return row
  }
  
  init(row: Row) throws {
    self.username = try row.get("username")
  }
}

// MARK: Fluent Preparation

extension User: Preparation {
  
  static func prepare(_ database: Database) throws {
    try database.create(self) { builder in
      builder.id()
      builder.string("username")
    }
  }
  
  static func revert(_ database: Database) throws {
    try database.delete(self)
  }
}

// MARK: Node

extension User: NodeRepresentable {
  func makeNode(in context: Context?) throws -> Node {
    var node = Node(context)
    try node.set("id", id)
    try node.set("username", username)
    return node
  }
}
