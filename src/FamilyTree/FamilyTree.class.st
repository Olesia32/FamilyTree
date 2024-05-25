Class {
	#name : 'FamilyTree',
	#superclass : 'Object',
	#instVars : [
		'treeId'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'initialization' }
FamilyTree >> initialize [ 
|login accessor session|
login := Login new
	database: PostgreSQLPlatform new;
	username: 'postgres';
	password: '19724Kll';
	host: 'localhost';
	port: '5432';
	databaseName: 'FamilyTreePharo'.
	
accessor := DatabaseAccessor forLogin: login.
accessor login.
accessor isLoggedIn.
session := FamilyTreeDescriptorSystem sessionForLogin: login.
session login.
]

{ #category : 'accessing' }
FamilyTree >> treeId: anId [
treeId := anId
]
