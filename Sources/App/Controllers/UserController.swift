import Vapor

final class UserController {

    func list(_ req: Request) throws -> Future<View> {
        let allUsers = User.query(on: req).all()

        return allUsers.flatMap(to: View.self) { users in
            let data = ["userlist": users]
            return try req.view().render("userview", data)
        }
    }

    func create(_ req: Request) throws -> Future<Response> {
        let user = try req.content.decode(User.self)

        return user.save(on: req).map(to: Response.self) { _ in
            return req.redirect(to: "users")
        }
    }
}
