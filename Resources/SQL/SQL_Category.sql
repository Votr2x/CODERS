These SQL commands are mainly categorized into five categories: 
	DDL – Data Definition Language
	DML – Data Manipulation Language
	DQL – Data Query Language
	DCL – Data Control Language
	TCL – Transaction Control Language

----------DDL (Data Definition Language)
DDL or Data Definition Language actually consists 
of the SQL commands that can be used to define the database schema. 
It simply deals with descriptions of the database schema 
and is used to create and modify the structure of database objects
in the database. DDL is a set of SQL commands 
used to create, modify, and delete database structures but not data. 
These commands are normally not used by a general user, 
who should be accessing the database via an application.

List of DDL commands: 
	CREATE: This command is used to create the database or its objects 
		(like table, index, function, views, store procedure, and triggers).
	DROP: This command is used to delete objects from the database.
	ALTER: This is used to alter the structure of the database.
	TRUNCATE: This is used to remove all records from a table, including all spaces allocated for the records are removed.
	COMMENT: This is used to add comments to the data dictionary.
	RENAME: This is used to rename an object existing in the database.

----------DML(Data Manipulation Language)
The SQL commands that deal with the manipulation of data 
present in the database belong to DML or Data Manipulation Language 
and this includes most of the SQL statements. 
It is the component of the SQL statement that controls 
access to data and to the database. 
Basically, DCL statements are grouped with DML statements.

List of DML commands: 
	INSERT: It is used to insert data into a table.
	UPDATE: It is used to update existing data within a table.
	DELETE: It is used to delete records from a database table.
	LOCK: Table control concurrency.
	EXEC(EXECUTE) / CALL: SQL Server uses the EXEC (or EXECUTE) statement to call stored procedures or execute dynamic SQL.
					Call a PL/SQL or JAVA subprogram.
	SHOWPLAN_XML / EXPLAIN PLAN: It describes the access path to data.
		SET SHOWPLAN_XML ON;
		GO


----------DQL (Data Query Language)
DQL statements are used for performing queries on the data 
within schema objects. The purpose of the DQL Command is 
to get some schema relation based on the query passed to it. 
We can define DQL as follows it is a component of SQL statement 
that allows getting data from the database and 
imposing order upon it. It includes the SELECT statement. 
This command allows getting the data out of the database 
to perform operations with it. 
When a SELECT is fired against a table or tables 
the result is compiled into a further temporary table, 
which is displayed or perhaps received by the program 
i.e. a front-end.

List of DQL: 
	SELECT: It is used to retrieve data from the database.


----------DCL (Data Control Language)
DCL includes commands such as GRANT and REVOKE which mainly deal with 
the rights, permissions, and other controls of the database system. 

List of  DCL commands: 
	GRANT: This command gives users access privileges to the database.
	REVOKE: This command withdraws the user’s access privileges given by using the GRANT command.


----------TCL (Transaction Control Language)
Transactions group a set of tasks into a single execution unit. 
Each transaction begins with a specific task and ends 
when all the tasks in the group are successfully completed. 
If any of the tasks fail, the transaction fails. 
Therefore, a transaction has only two results: success or failure.
You can explore more about transactions here. 
Hence, the following TCL commands are used to control 
the execution of a transaction: 
 BEGIN: Opens a Transaction.

List of TCL commands:
	COMMIT: Commits a Transaction.
	ROLLBACK: Rollbacks a transaction in case of any error occurs.
	SAVEPOINT: Sets a save point within a transaction.