Class {
	#name : 'Relation',
	#superclass : 'Object',
	#instVars : [
		'id',
		'firstPerson',
		'secondPerson',
		'type'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'accessing' }
Relation >> firstPerson [ 
^ firstPerson 
]

{ #category : 'accessing' }
Relation >> firstPerson: aFirstPerson [
firstPerson := aFirstPerson 
]

{ #category : 'accessing' }
Relation >> id [ 
^ id
]

{ #category : 'accessing' }
Relation >> id: anId [
id := anId 
]

{ #category : 'accessing' }
Relation >> secondPerson [
^ secondPerson 
]

{ #category : 'accessing' }
Relation >> secondPerson: aSecondPerson [
secondPerson := aSecondPerson 
]

{ #category : 'accessing' }
Relation >> type [ 
^ type
]

{ #category : 'accessing' }
Relation >> type: aType [
type := aType
]
