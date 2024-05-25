Class {
	#name : 'FamilyTreeRepository',
	#superclass : 'Object',
	#instVars : [
		'currentSession'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'adding' }
FamilyTreeRepository >> addPerson: aPerson [
	currentSession inUnitOfWorkDo: [ currentSession register: aPerson ].
	^ aPerson id
]

{ #category : 'adding' }
FamilyTreeRepository >> addRelation: aRelation [
	currentSession inUnitOfWorkDo: [
		{ (currentSession register: aRelation ) } ]
]

{ #category : 'adding' }
FamilyTreeRepository >> addTree: aTree [
	currentSession inUnitOfWorkDo: [ currentSession register: aTree ].
	^ aTree id
]

{ #category : 'adding' }
FamilyTreeRepository >> addUser: aUser [
currentSession inUnitOfWorkDo: [
	{
		currentSession register: aUser 
		}
]
]

{ #category : 'operations' }
FamilyTreeRepository >> create [
currentSession createTables 
]

{ #category : 'as yet unclassified' }
FamilyTreeRepository >> deletePerson: aPerson [
currentSession inUnitOfWorkDo: [ currentSession delete: aPerson ]
]

{ #category : 'as yet unclassified' }
FamilyTreeRepository >> deleteUser: aUser [
currentSession inUnitOfWorkDo: [

	currentSession delete: aUser 
	].
]

{ #category : 'as yet unclassified' }
FamilyTreeRepository >> getAllPersonsForTreeId: aTreeId [
^ currentSession 
	read: Person
	where: [:each | each tree = aTreeId ].
]

{ #category : 'as yet unclassified' }
FamilyTreeRepository >> getAllRelations [
^ currentSession read: Relation
]

{ #category : 'as yet unclassified' }
FamilyTreeRepository >> getChildrenForPerson: aPersonId [
^ currentSession read: Person where: [ :each | each fatherId = aPersonId or: [ each motherId = aPersonId ] ]
]

{ #category : 'as yet unclassified' }
FamilyTreeRepository >> getPersonById: anId [

	| person |
	person := currentSession read: Person where: [ :each | each id = anId ].
	person isEmpty
		ifTrue: [ ^ nil ]
		ifFalse: [ ^ person first ]
]

{ #category : 'as yet unclassified' }
FamilyTreeRepository >> getTreeById: anId [

	| tree |
	tree := currentSession read: Tree where: [ :each | each id = anId ].
	tree isEmpty ifTrue: [ ^ nil ] ifFalse: [ ^ tree first ]
]

{ #category : 'as yet unclassified' }
FamilyTreeRepository >> getTreeByUserLogin: aLogin [

	| tree |
	tree := currentSession
		        read: Tree
		        where: [ :each | each userId = aLogin ].
	tree isEmpty
		ifTrue: [ ^ nil ]
		ifFalse: [ ^ tree first ]
]

{ #category : 'as yet unclassified' }
FamilyTreeRepository >> getUserByLogin: aLogin [
|user|
user := currentSession read: User where: [ :each | each login = aLogin ].
	 (user isEmpty) ifTrue: [ ^ nil ] ifFalse: [ ^  user first]
]

{ #category : 'initialization' }
FamilyTreeRepository >> initialize [

	| login accessor session |
	login := Login new
		         database: PostgreSQLPlatform new;
		         username: 'postgres';
		         password: '19724Kll';
		         host: 'localhost';
		         port: '5432';
		         databaseName: 'Pharo'.
	accessor := DatabaseAccessor forLogin: login.
	accessor login.
	session := GlorpSession new.
	session system:
		(FamilyTreeDescriptorSystem forPlatform: login database).
	session accessor: accessor.
	currentSession := session
]

{ #category : 'as yet unclassified' }
FamilyTreeRepository >> updatePerson: aPerson [

	currentSession inUnitOfWorkDo: [
		| person |
		person := currentSession
			        readOneOf: Person
			        where: [ :each | each id = aPerson id ].
		person firstName: aPerson firstName.
		person lastName: aPerson lastName.
		person gender: aPerson gender.
		person birthDate: aPerson birthDate.
		person birthPlace: aPerson birthPlace.
		person deathDate: aPerson deathDate.
		person deathPlace: aPerson deathPlace.
		person mainPhoto: aPerson mainPhoto.
		person tree: aPerson tree.
		]
]

{ #category : 'as yet unclassified' }
FamilyTreeRepository >> updateTree: aTree [

	currentSession inUnitOfWorkDo: [
		| tree |
		tree := currentSession
			        readOneOf: Tree
			        where: [ :each | each id = aTree id ].
		tree id: aTree id.
		tree mainPerson: aTree mainPerson.
		tree userId: aTree userId. ].
]

{ #category : 'as yet unclassified' }
FamilyTreeRepository >> updateUser: aUser [
currentSession inUnitOfWorkDo: [
	| user |
	user := currentSession 
		readOneOf: User
		where: [:each | each login = aUser login].
	user login: aUser login.
	user password: aUser password.
	].
]
