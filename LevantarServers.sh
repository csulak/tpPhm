cd ~/.config/Neo4j\ Desktop/Application/neo4jDatabases/database-ee730214-b6ec-4549-90bc-8ced3640f4a8/installation-3.3.5/bin && ./neo4j start
systemctl start mongodb
service mysql start
echo | systemctl status mongodb
echo | service mysql status
