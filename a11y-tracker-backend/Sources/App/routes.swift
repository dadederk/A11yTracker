import Fluent
import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: IssuesController())
    try app.register(collection: IssueController())

    try app.register(collection: TodoController())
}
