Class {
	#name : 'FamilyTreeDescriptorSystem',
	#superclass : 'DescriptorSystem',
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'actions' }
FamilyTreeDescriptorSystem >> classModelForPerson: aClassModel [

	(aClassModel newAttributeNamed: #id) useDirectAccess: true.
	aClassModel newAttributeNamed: #firstName.
	aClassModel newAttributeNamed: #lastName.
	aClassModel newAttributeNamed: #gender.
	aClassModel newAttributeNamed: #birthDate.
	aClassModel newAttributeNamed: #birthPlace.
	aClassModel newAttributeNamed: #deathDate.
	aClassModel newAttributeNamed: #deathPlace.
	aClassModel newAttributeNamed: #mainPhoto.
	aClassModel newAttributeNamed: #fatherId.
	aClassModel newAttributeNamed: #motherId.
	aClassModel newAttributeNamed: #spouseId.
	aClassModel newAttributeNamed: #tree
]

{ #category : 'as yet unclassified' }
FamilyTreeDescriptorSystem >> classModelForTree: aClassModel [

	(aClassModel newAttributeNamed: #id) useDirectAccess: true.
	aClassModel newAttributeNamed: #mainPerson.
	aClassModel newAttributeNamed: #userId
]

{ #category : 'as yet unclassified' }
FamilyTreeDescriptorSystem >> classModelForUser: aClassModel [
(aClassModel newAttributeNamed: #login) useDirectAccess: true.
aClassModel newAttributeNamed: #password.
]

{ #category : 'actions' }
FamilyTreeDescriptorSystem >> createNewSessionLog [ 
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
^ session 
]

{ #category : 'as yet unclassified' }
FamilyTreeDescriptorSystem >> descriptorForPerson: aDescriptor [

	| table |
	table := self tableNamed: 'PERSON'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #id
		to: (table fieldNamed: 'id').
	(aDescriptor newMapping: DirectMapping)
		from: #firstName
		to: (table fieldNamed: 'firstName').
	(aDescriptor newMapping: DirectMapping)
		from: #lastName
		to: (table fieldNamed: 'lastName').
	(aDescriptor newMapping: DirectMapping)
		from: #gender
		to: (table fieldNamed: 'gender').
	(aDescriptor newMapping: DirectMapping)
		from: #birthDate
		to: (table fieldNamed: 'birthDate').
	(aDescriptor newMapping: DirectMapping)
		from: #birthPlace
		to: (table fieldNamed: 'birthPlace').
	(aDescriptor newMapping: DirectMapping)
		from: #deathDate
		to: (table fieldNamed: 'deathDate').
	(aDescriptor newMapping: DirectMapping)
		from: #deathPlace
		to: (table fieldNamed: 'deathPlace').
	(aDescriptor newMapping: DirectMapping)
		from: #mainPhoto
		to: (table fieldNamed: 'mainPhoto').
	(aDescriptor newMapping: DirectMapping)
		from: #fatherId
		to: (table fieldNamed: 'fatherId').
	(aDescriptor newMapping: DirectMapping)
		from: #motherId
		to: (table fieldNamed: 'motherId').
	(aDescriptor newMapping: DirectMapping)
		from: #spouseId
		to: (table fieldNamed: 'spouseId').
	(aDescriptor newMapping: DirectMapping)
		from: #tree
		to: (table fieldNamed: 'tree')
]

{ #category : 'as yet unclassified' }
FamilyTreeDescriptorSystem >> descriptorForTree: aDescriptor [

	| table |
	table := self tableNamed: 'TREE'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #id
		to: (table fieldNamed: 'id').
	(aDescriptor newMapping: DirectMapping)
		from: #mainPerson
		to: (table fieldNamed: 'mainPerson').
	(aDescriptor newMapping: DirectMapping)
		from: #userId
		to: (table fieldNamed: 'userId')
]

{ #category : 'as yet unclassified' }
FamilyTreeDescriptorSystem >> descriptorForUser: aDescriptor [

	| table |
	table := self tableNamed: 'USERS'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #login
		to: (table fieldNamed: 'login').
	(aDescriptor newMapping: DirectMapping)
		from: #password
		to: (table fieldNamed: 'password').
]

{ #category : 'initialization' }
FamilyTreeDescriptorSystem >> initialize [
	super initialize
]

{ #category : 'tables' }
FamilyTreeDescriptorSystem >> tableForPERSON: aTable [

	| treeField fatherField motherField spouseField|
	(aTable createFieldNamed: 'id' type: platform serial) bePrimaryKey.
	aTable createFieldNamed: 'firstName' type: (platform varChar: 100).
	aTable createFieldNamed: 'lastName' type: (platform varChar: 100).
	aTable createFieldNamed: 'gender' type: (platform varChar: 6).
	aTable createFieldNamed: 'birthDate' type: platform date.
	aTable createFieldNamed: 'birthPlace' type: (platform varChar: 200).
	aTable createFieldNamed: 'deathDate' type: platform date.
	aTable createFieldNamed: 'deathPlace' type: (platform varChar: 200).
	aTable createFieldNamed: 'mainPhoto' type: (platform varChar: 200).
	treeField := aTable createFieldNamed: 'tree' type: platform integer.
	aTable
		addForeignKeyFrom: treeField
		to: ((self tableNamed: 'TREE') fieldNamed: 'id').
	fatherField := aTable createFieldNamed: 'fatherId' type: platform integer.
	aTable
		addForeignKeyFrom: fatherField 
		to: ((self tableNamed: 'PERSON') fieldNamed: 'id').
	motherField := aTable createFieldNamed: 'motherId' type: platform integer.
	aTable
		addForeignKeyFrom: fatherField 
		to: ((self tableNamed: 'PERSON') fieldNamed: 'id').
	spouseField := aTable createFieldNamed: 'spouseId' type: platform integer.
	aTable
		addForeignKeyFrom: fatherField 
		to: ((self tableNamed: 'PERSON') fieldNamed: 'id').
]

{ #category : 'as yet unclassified' }
FamilyTreeDescriptorSystem >> tableForTREE: aTable [

	| mainPersonField userField |
	(aTable createFieldNamed: 'id' type: platform serial) bePrimaryKey.
	mainPersonField := aTable
		                   createFieldNamed: 'mainPerson'
		                   type: platform integer.
	userField := aTable
		             createFieldNamed: 'userId'
		             type: (platform varChar: 100).
	aTable
		addForeignKeyFrom: mainPersonField
		to: ((self tableNamed: 'PERSON') fieldNamed: 'id').
	aTable
		addForeignKeyFrom: userField
		to: ((self tableNamed: 'USERS') fieldNamed: 'login')
]

{ #category : 'as yet unclassified' }
FamilyTreeDescriptorSystem >> tableForUSERS: aTable [
(aTable createFieldNamed: 'login' type: (platform varchar: 100))
		bePrimaryKey.
	aTable
		createFieldNamed: 'password'
		type: (platform varChar: 100).
]
