# Compilar o projeto
javac -cp ".;mysql-connector-java-x.x.x.jar" -d bin src/model/*.java src/util/*.java src/dao/*.java src/service/*.java src/ui/*.java src/Main.java

# Executar o projeto
java -cp "bin;mysql-connector-java-x.x.x.jar" Main
