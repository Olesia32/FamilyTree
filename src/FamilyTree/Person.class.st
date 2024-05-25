Class {
	#name : 'Person',
	#superclass : 'Object',
	#instVars : [
		'id',
		'firstName',
		'lastName',
		'gender',
		'birthDate',
		'birthPlace',
		'deathDate',
		'deathPlace',
		'mainPhoto',
		'fatherId',
		'motherId',
		'spouseId',
		'children',
		'tree'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'accessing' }
Person >> birthDate [
^ birthDate 
]

{ #category : 'accessing' }
Person >> birthDate: aBirthDate [ 
birthDate := aBirthDate 
]

{ #category : 'accessing' }
Person >> birthPlace [
^ birthPlace 
]

{ #category : 'accessing' }
Person >> birthPlace: aBirthPlace [
birthPlace := aBirthPlace 
]

{ #category : 'accessing' }
Person >> children [

	^ children
]

{ #category : 'accessing' }
Person >> children: arg1 [

	children := arg1
]

{ #category : 'accessing' }
Person >> deathDate [
^ deathDate 
]

{ #category : 'accessing' }
Person >> deathDate: aDeathDate [
deathDate := aDeathDate 
]

{ #category : 'accessing' }
Person >> deathPlace [
^ deathPlace 
]

{ #category : 'accessing' }
Person >> deathPlace: aDeathPlace [
deathPlace := aDeathPlace 
]

{ #category : 'accessing' }
Person >> fatherId [

	^ fatherId 
]

{ #category : 'accessing' }
Person >> fatherId: arg1 [

	| tmp1 |
	tmp1 := arg1.
	'<an unprintable nonliteral value>' runtimeUndeclaredWrite: tmp1
]

{ #category : 'accessing' }
Person >> firstName [ 
^ firstName
]

{ #category : 'accessing' }
Person >> firstName: aFirstName [
firstName := aFirstName 
]

{ #category : 'accessing' }
Person >> fullName [
^ firstName , ' ' , lastName 
]

{ #category : 'accessing' }
Person >> gender [ 
^ gender
]

{ #category : 'accessing' }
Person >> gender: aGender [
gender := aGender 
]

{ #category : 'accessing' }
Person >> id [ 
^ id
]

{ #category : 'accessing' }
Person >> id: anId [
id := anId 
]

{ #category : 'initialization' }
Person >> initialize [

	children := OrderedCollection new
]

{ #category : 'accessing' }
Person >> lastName [ 
^ lastName 
]

{ #category : 'accessing' }
Person >> lastName: aLastName [
lastName := aLastName 
]

{ #category : 'accessing' }
Person >> mainPhoto [ 
^ mainPhoto 
]

{ #category : 'accessing' }
Person >> mainPhoto: aMainPhoto [
mainPhoto := aMainPhoto 
]

{ #category : 'accessing' }
Person >> motherId [

	^ motherId 
]

{ #category : 'accessing' }
Person >> motherId: aMotherId [
motherId := aMotherId 
]

{ #category : 'accessing' }
Person >> spouseId [

	^ spouseId 
]

{ #category : 'accessing' }
Person >> spouseId: aSpouseId [
spouseId := aSpouseId 
]

{ #category : 'accessing' }
Person >> tree [ 
^tree 
]

{ #category : 'accessing' }
Person >> tree: aTree [
tree := aTree
]

{ #category : 'as yet unclassified' }
Person >> yearsOfLife [

	(birthDate isNotNil and: deathDate isNotNil) ifTrue: [
		^ '(' , (birthDate asDate year) asString , ' - ' , (deathDate asDate year) asString , ')' ].
	birthDate ifNotNil: [ ^ '(' , (birthDate asDate year) asString , ')' ].
	deathDate ifNotNil: [ ^ '(  - ' , (deathDate asDate year) asString , ')' ].
	^ ''
]
