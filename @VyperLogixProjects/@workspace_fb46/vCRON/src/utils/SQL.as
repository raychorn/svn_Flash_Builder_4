package utils {
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;

	public class SQL {
		private var dbConnection:SQLConnection;
		private var getTodosStmt:SQLStatement;
		private var addTodoStmt:SQLStatement;
		private var delTodoStmt:SQLStatement;
		
		public function SQL(databaseFile:File) {
			dbConnection = new SQLConnection();
			dbConnection.open(databaseFile);
			
			initializeDB('myTable','todo TEXT');
			
			getTodosStmt = new SQLStatement();
			getTodosStmt.sqlConnection = dbConnection;
			getTodosStmt.text = "SELECT * FROM todos ";
			
			addTodoStmt = new SQLStatement();
			addTodoStmt.sqlConnection = dbConnection;
			addTodoStmt.text = "INSERT INTO todos (todo) VALUES (?) ";
			
			delTodoStmt = new SQLStatement();
			delTodoStmt.sqlConnection = dbConnection;
			delTodoStmt.text = "DELETE FROM todos WHERE id = ? ";
			
		}
		
		private function initializeDB(table_name:String,schema:String):void {
			var createStmt:SQLStatement = new SQLStatement();
			createStmt.sqlConnection = dbConnection;
			createStmt.text = "CREATE TABLE IF NOT EXISTS "+table_name+" (id INTEGER PRIMARY KEY AUTOINCREMENT"+(((schema is String) && (schema.length > 0)) ? ', ' : '')+schema+") ";
			createStmt.execute();
		}
		
		public function getAll():ArrayCollection {
			getTodosStmt.execute();
			return new ArrayCollection(getTodosStmt.getResult().data);
		}
		
		public function add(todo:String):void {
			addTodoStmt.clearParameters();
			addTodoStmt.parameters[0] = todo;
			addTodoStmt.execute();
		}
		
		public function remove(id:int):void {
			delTodoStmt.clearParameters();
			delTodoStmt.parameters[0] = id;
			delTodoStmt.execute();
		}
	}
}
