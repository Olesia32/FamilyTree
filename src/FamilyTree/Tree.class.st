Class {
	#name : 'Tree',
	#superclass : 'Object',
	#instVars : [
		'id',
		'persons',
		'mainPerson',
		'userId'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'accessing' }
Tree >> id [ 
^ id
]

{ #category : 'accessing' }
Tree >> id: anId [
id := anId 
]

{ #category : 'initialization' }
Tree >> initialize [ 
persons := OrderedCollection new.
]

{ #category : 'accessing' }
Tree >> mainPerson [ 
^ mainPerson 
]

{ #category : 'accessing' }
Tree >> mainPerson: aMainPerson [
mainPerson := aMainPerson 
]

{ #category : 'accessing' }
Tree >> userId [
^ userId
]

{ #category : 'accessing' }
Tree >> userId: aUser [
userId := aUser 
]
